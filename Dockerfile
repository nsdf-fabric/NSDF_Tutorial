FROM python:3.10

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

COPY setup_openvisuspy.sh /app

RUN chmod +x setup_openvisuspy.sh
RUN ./setup_openvisuspy.sh

COPY environment.yml /app/

RUN conda env create -f environment.yml 
SHELL ["conda", "run", "-n", "somospie", "/bin/bash", "-c"]

RUN apt-get update && apt-get install -y grass grass-doc
RUN pip install openvisus

RUN git clone https://github.com/TauferLab/GEOtiled.git
WORKDIR /app/GEOtiled/geotiled
RUN pip install -e .

WORKDIR /app

COPY Tutorial.ipynb /app
COPY Explore_Data.ipynb /app
COPY *.py /app/

EXPOSE 8989 5000

COPY /files/ /app/files/
COPY /idx_data/ /app/idx_data/

RUN conda init
CMD ["conda", "run","-n", "somospie","jupyter", "lab", "--port=5000", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''","--NotebookApp.password=''"]
