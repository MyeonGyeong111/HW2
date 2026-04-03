from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import JSONResponse
from contextlib import asynccontextmanager
import io
from PIL import Image
import torch
from transformers import ViTFeatureExtractor, ViTForImageClassification

# Global dictionary to store the loaded model
ml_models = {}
MODEL_NAME = "nateraw/vit-age-classifier"

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup: Load the model and feature extractor once the server starts
    print("Loading lightweight age prediction model...")
    try:
        feature_extractor = ViTFeatureExtractor.from_pretrained(MODEL_NAME)
        model = ViTForImageClassification.from_pretrained(MODEL_NAME)
        ml_models["feature_extractor"] = feature_extractor
        ml_models["model"] = model
        print("Model loaded successfully.")
    except Exception as e:
        print(f"Failed to load model: {e}")
        
    yield # App is running
    
    # Shutdown: Clean up resources
    print("Cleaning up resources...")
    ml_models.clear()

# Initialize FastAPI application
app = FastAPI(
    title="Age Prediction API",
    description="MLOps Pipeline API Server for Age Prediction using a lightweight ViT model.",
    version="1.0.0",
    lifespan=lifespan
)

@app.get("/health")
def health_check():
    """Check API server and model status"""
    model_loaded = "model" in ml_models
    return {
        "status": "Healthy" if model_loaded else "Model Not Loaded",
        "model_ready": model_loaded
    }

@app.post("/predict")
async def predict_age(file: UploadFile = File(...)):
    """Upload an image to predict age"""
    if "model" not in ml_models:
        raise HTTPException(status_code=503, detail="Prediction model is currently unavailable.")
        
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="Invalid file format. Please upload an image.")
    
    try:
        # Read the image file into memory
        contents = await file.read()
        image = Image.open(io.BytesIO(contents)).convert("RGB")
        
        feature_extractor = ml_models["feature_extractor"]
        model = ml_models["model"]
        
        # Preprocess and prepare for the model
        inputs = feature_extractor(images=image, return_tensors="pt")
        
        # Inference
        with torch.no_grad():
            outputs = model(**inputs)
            
        # Parse prediction results
        logits = outputs.logits
        predicted_class_idx = logits.argmax(-1).item()
        
        # Maps index to actual age range string (e.g., "20-29")
        predicted_age_range = model.config.id2label[predicted_class_idx]
        
        return JSONResponse(status_code=200, content={
            "filename": file.filename,
            "predicted_age": predicted_age_range,
            "status": "success"
        })
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred during prediction: {str(e)}")
