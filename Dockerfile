FROM python:3.12

# Install base utilities
RUN apt-get update \
    && apt-get install -y build-essential \
    && apt-get install -y wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

RUN mkdir app
WORKDIR /app
# COPY pyproject.toml /app
COPY setup_openvisuspy.sh /app
# RUN pip install poetry
RUN chmod +x setup_openvisuspy.sh
RUN ./setup_openvisuspy.sh

COPY environment.yaml /app

RUN conda env create -f environment.yaml
RUN conda activate somospie