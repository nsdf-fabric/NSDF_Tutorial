FROM python:3.9


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

RUN pip install openvisus

COPY *.ipynb /app
COPY *.py /app/

EXPOSE 5000
RUN conda init
# ENTRYPOINT ["conda", "run", "-n", "somospie", "jupyter", "notebook", "SOMOSPIE Integration.ipynb", "--allow-root", "--port", "5000"]