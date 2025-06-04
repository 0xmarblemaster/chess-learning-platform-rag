FROM python:3.10-slim

WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app

# Install system dependencies (updated to include OpenCV requirements)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    wget \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Install Stockfish chess engine
RUN FILENAME="stockfish-ubuntu-x86-64-avx2.tar" && \
    wget https://github.com/official-stockfish/Stockfish/releases/download/sf_16/${FILENAME} \
    && tar -xf ${FILENAME} \
    && cp stockfish/stockfish-ubuntu-x86-64-avx2 /usr/local/bin/stockfish \
    && chmod +x /usr/local/bin/stockfish \
    && rm -rf stockfish ${FILENAME} \
    && stockfish --version

# Copy requirements file
COPY backend/requirements.txt /app/backend/

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r /app/backend/requirements.txt

# Copy the rest of the application
COPY . /app/

# Create necessary directories
RUN mkdir -p /app/backend/input \
    /app/backend/output_images \
    /app/backend/data

# Expose port (updated to match Flask app)
EXPOSE 5001

# Run healthcheck to ensure services are ready
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:5001/', timeout=10)" || exit 1

# Command to run the Flask application
CMD ["python", "-m", "backend.app"]