# FROM python:3.12-slim
FROM nvidia/cuda:12.4.1-cudnn-runtime-ubuntu22.04
RUN apt-get update && apt-get install -y python3 python3-pip ffmpeg git build-essential libglib2.0-0 libsm6 libxrender1 libxext6 && rm -rf /var/lib/apt/lists/*
RUN ln -sf python3 /usr/bin/python && ln -sf pip3 /usr/bin/pip


# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        git \
        build-essential \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \ 
        libxext6 \
        && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Install Python dependencies
RUN pip install numpy matplotlib pandas scikit-learn scikit-image seaborn \
    nibabel pydicom scipy

RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124

RUN pip install transformers diffusers accelerate datasets torch-ema

# Install GMI and MedMNIST from GitHub
RUN pip install git+https://github.com/Generative-Medical-Imaging-Lab/gmi.git
RUN pip install git+https://github.com/MedMNIST/MedMNIST.git@8cce68f261f993bd0450edc0200498a0691362c2

# Set default command
CMD ["python3"] 