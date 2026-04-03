FROM python:3.10-slim

# Best practices for Python Docker
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    HF_HOME=/app/.cache/huggingface

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Optimize #1: Install PyTorch CPU version to massively reduce image size (~2GB -> ~200MB)
RUN pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu

COPY requirements.txt .

# Optimize #2: Remove 'torch' from requirements to skip CUDA version, then install
RUN sed -i '/torch/d' requirements.txt && \
    pip install --no-cache-dir -r requirements.txt && \
    # Remove build essentials after compilation to keep image slim
    apt-get purge -y --auto-remove build-essential

# Optimize #3: Non-root user with dedicated cache directory
RUN addgroup --system appgroup && adduser --system --group appuser && \
    mkdir -p /app/.cache/huggingface && \
    chown -R appuser:appgroup /app

# Switch to non-root user for security
USER appuser

# Optimize #4: Pre-download model as non-root to cache it correctly inside the image
RUN python -c "from transformers import ViTFeatureExtractor, ViTForImageClassification; \
    ViTFeatureExtractor.from_pretrained('nateraw/vit-age-classifier'); \
    ViTForImageClassification.from_pretrained('nateraw/vit-age-classifier')"

# Copy application source code with correct ownership
COPY --chown=appuser:appgroup . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
