# Age Prediction API

This is a lightweight Age Prediction API using FastAPI and a Vision Transformer (ViT) model from Hugging Face (`nateraw/vit-age-classifier`). It predicts age ranges based on facial images.

## Structure
- `main.py`: The entry point for the FastAPI application. Includes endpoints for `/health` and `/predict`.
- `requirements.txt`: Python package dependencies.
- `Dockerfile`: MLOps ready Docker configuration which caches the PyTorch model locally to optimize container deployment.

## How to run locally

1. **Create and activate a virtual environment (optional but recommended):**
   ```bash
   python -m venv venv
   source venv/bin/activate
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Start the API Server:**
   ```bash
   uvicorn main:app --host 0.0.0.0 --port 8000 --reload
   ```

4. **Access the API:**
   - Swagger Dashboard (API documentation and testing): http://localhost:8000/docs
   - Predict Endpoint: Use `curl` or Postman to test:
     ```bash
     curl -X 'POST' \
       'http://localhost:8000/predict' \
       -H 'accept: application/json' \
       -H 'Content-Type: multipart/form-data' \
       -F 'file=@/path/to/your/image.jpg'
     ```

## How to run with Docker

1. **Build the Docker Image:**
   ```bash
   docker build -t age-prediction-api .
   ```

2. **Run the Docker Container:**
   ```bash
   docker run -p 8000:8000 age-prediction-api
   ```
