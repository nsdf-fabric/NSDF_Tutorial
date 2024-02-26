# **NSDF Tutorial: Using NSDF for End-to-End Analysis of Scientific Data**

<p align="center">
    <img src="files/docs/Logos.png" width="450">
</p>

<p align="center">
<a href="https://www.python.org/downloads/release/python-310/"><img alt="Python 3.10" src="https://img.shields.io/badge/Python-3.10-3776AB.svg?style=flat&logo=python&logoColor=white"></a>
<a href="https://dl.acm.org/doi/10.1145/3588195.3595941"><img alt="DOI" src="https://zenodo.org/badge/DOI/10.1145/3588195.3595941.svg"></a>
<a href="https://opensource.org/licenses/Apache-2.0"><img alt="License" src="https://img.shields.io/badge/License-Apache_2.0-green.svg"></a>
<a href="https://nsdf-workspace.slack.com/"><img alt="Slack" src="https://badges.aleen42.com/src/slack.svg"></a>
<a href="https://www.docker.com"><img alt="Docker" src="https://badges.aleen42.com/src/docker.svg"></a>
<a href="https://github.com/astral-sh/ruff"><img alt="Ruff" src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json"></a>

## Overview

This tutorial introduces [OpenVisus](https://github.com/sci-visus/OpenVisus), an [NSDF](https://nationalsciencedatafabric.org/) service that improves the way scientific data is accessed, analyzed, and visualized using cloud technologies. The tutorial provides step-by-step guidance using a module of the [SOMOSPIE](https://globalcomputing.group/somospie/) engine to collect raw data from a public source, like the USDA portal. This data is then converted into multiple files for analysis with NSDF and for storage on both public and private platforms.  The module used is [GEOtiled](https://github.com/TauferLab/GEOtiled), the first step in the SOMOSPIE process, which efficiently calculates terrain attributes over large areas from digital elevation models (DEMs), maintaining high accuracy.

Throughout the tutorial, you will learn to:

Construct a modular workflow that combines your application module with NSDF services for enhanced data visualization and analysis.

Upload and download intermediary data to/from public storage solutions such as Dataverse, and to/from private storage options like Seal Storage.

Deploy the NSDF dashboard for sophisticated data visualization and analysis, including features like zooming in for detailed examination, selecting specific subregions for cropping, and exporting these areas in a format compatible with Python.

This tutorial follows the steps in Figure 1.

<p align="center">
    <img src="files/docs/workflow-diagram.png" width="800">
    <br>
    <em>Figure 1. Workflow diagram illustrating the tutorial's process of data collection, transformation, analysis, and storage using the SOMOSPIE engine and NSDF services.</em>
</p>

---

### Table of content
  1. [Prerequisites](#prerequisites)
  2. [Running the Tutorial with Docker](#running-the-tutorial-with-docker)
  3. [APPENDIX: Installing the Tutorial from the Beginning ](#appendix-installing-the-tutorial-from-the-beginning)
  4. [Community and Resources](#community-and-resources)
  5. [Related Publications](#related-publications)
  6. [Copyright and License](#copyright-and-license)
  7. [Authors](#authors)
  8. [Acknowledgments](#acknowledgments)

## Prerequisites

Before starting this tutorial, ensure you have installed Git and Docker Desktop on your computer.

* **To install Git**: Follow the [installation instructions](https://github.com/git-guides/install-git) for your operating system (Linux, Windows, or Mac).
* **To install Docker Desktop**: Follow the [installation instructions](https://docs.docker.com/engine/install/) for your operating system (Linux, Windows, or Mac).

After installation, confirm that both tools are correctly set up by executing the following commands in your terminal.

> :bulb: **Note:** For Windows users, we recommend using the [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.4) terminal for these verifications.

* To verify the GitHub installation:
```
# Check the Git version
git --version
```
Expected output: 
```
git version 3.12.0` 
```

* To verify Docker Desktop installation: Make sure you open the Docker Desktop application before running Docker commands.
```
# Check the Docker installation information
docker info
```
Expected output:
```
Client:
 Version:    24.0.5
 Context:    default
 Debug Mode: false

Server:
 Containers: 120
  Running: 0
  Paused: 0
  Stopped: 120
 Images: 48
```
> :bulb: **Note**: The specific numbers in the output might vary based on your installation details and additional information may also appear.

## Running the Tutorial with Docker

To run this tutorial, we have prepared a Docker container named [`globalcomputinglab/somospie_openvisus`](https://hub.docker.com/repository/docker/globalcomputinglab/somospie_openvisus/general) that includes all necessary software. Ensure you have installed Docker Desktop as outlined in the [Prerequisites](#prerequisites) and have it open on your computer.

Follow these steps in your terminal to use the Docker container for the tutorial:
```
# Clone the tutorial repository:
git clone https://github.com/nsdf-fabric/Openvisus_Tutorial.git

# Navigate to the tutorial directory:
cd Openvisus_Tutorial

# Launch the Docker environment:
docker-compose up -d
```

After executing the above command, open your preferred web browser (such as Google Chrome, Firefox, or Safari) and enter the following URL to access Jupyter Lab and the tutorial notebook (Tutorial.ipynb):
```
# Access to Jupyter Lab (Tutorial.ipynb)
http://127.0.0.1:5000/lab/tree/Tutorial.ipynb
```

When you have finished the tutorial, ensure to stop the Docker container to free up resources. Do this by entering the following command in your terminal:
```
# Stop the Docker container 
docker-compose down
```

## APPENDIX: Installing the Tutorial from the Beginning 

This session provides detailed instructions for setting up and running the workflow from the beginning. You have two options: you can set up a [Docker container](#using-a-docker-container) or configure your [local machine](#using-your-local-machine) for deployment. These instructions are designed for users with more advanced technical skills, and they can be customized to incorporate your application with GEOtiled.

### Using a Docker container

To build the docker image in your local machine:

```
docker build --platform linux/amd64 -t globalcomputinglab/somospie_openvisus .
```

To pull the image from Dockerhub:

```
docker pull --platform linux/amd64 globalcomputinglab/somospie_openvisus:latest
```

To run:

```
docker run -d -p 5000:5000 -p 8989:8989 --name tutorial --platform linux/amd64 globalcomputinglab/somospie_openvisus
```

Follow this URL to run the Jupyter Notebook `Tutorial.ipynb`:

```
http://localhost:5000/
```

### Using your local machine

[Conda](https://www.anaconda.com/download/) is used to control all the dependencies in this project; the file `environment.yml` contains the list of required versions:

```
# environment.yml

name: somospie
channels:
  - conda-forge
  - defaults
dependencies:
  - python=3.10
  - gdal
  - pip
  - pip:
      - pandas
      - pyspark
      - findspark
      - scikit-learn
      - matplotlib
      - grass-session
      - bokeh
      - xmltodict
      - requests
      - colorcet
      - geopandas
      - tqdm
      - panel
      - jupyterlab
      - grass-session
      - tifffile
      - rasterio
      - imagecodecs
```

To install the dependencies in your local machine, use the following command:

> :bulb: **Note:** Conda is mandatory in this step, use [this](https://www.anaconda.com/download/) link to install it

```
conda env create -f environment.yml
```

Activate the virtual environment:

```
conda activate somospie
```

Install OpenVisus dependencies:

```
# use this file to install openvisus in your local machine
./setup_openvisuspy.sh
```

Run the Jupyter Notebook and follow the internal instructions:

```
jupyter notebook Tutorial.ipynb
```

## Community and Resources

NSDF and SOMOSPIE are open-source projects. Questions, discussion, and contributions are welcome. Contributions can be anything from new packages to bug fixes, documentation, or even new core features.

NSDF Resources:
- **Slack workspace**: [nsdf-workspace](https://nsdf-workspace.slack.com/).
- **Github Discussions**: [issues](https://github.com/nsdf-fabric/catalog-comparison-tool/issues): Discussions and Q&A.
- **Mailing list**: [https://groups.google.com/g/nsdf](https://groups.google.com/g/nsdf) - nsdf@googlegroups.com
- **Twitter**: [@FabricNsdf](https://twitter.com/FabricNsdf).

SOMOSPIE Resources:
- **GitHub:** [SOMOSPIE software](https://github.com/TauferLab/SOMOSPIE)
- **Webpage:** [SOMOSPIE overview](https://globalcomputing.group/somospie)
- **Questions:** Michela Taufer [mtaufer@utk.edu](email:mtaufer@utk.edu). 

## Related Publications

[1] Roa, C., Olaya, P., Llamas, R., Vargas, R., Taufer, M. GEOtiled: A Scalable Workflow for Generating Large Datasets of High-Resolution Terrain Parameters. Proceedings of the 32nd International Symposium on High-Performance Parallel and Distributed Computing (2023). [link](https://dl.acm.org/doi/abs/10.1145/3588195.3595941)

[2] Olaya, Paula and Luettgau, Jakob and Roa, Camila and Llamas, Richardo and Vargas, Rodrigo and Wen, Sophia and Chung, I-Hsin and Seelam, Seetharami and Park, Yoonho and Lofstead, Jay and others Enabling Scalability in the Cloud for Scientific Workflows: An Earth Science Use Case. IEEE International Conference on Cloud Computing (2023). [link](https://research.ibm.com/publications/enabling-scalability-in-the-cloud-for-scientific-workflows-an-earth-science-use-case)

[3] D. Rorabaugh, M. Guevara, R. Llamas, J. Kitson, R. Vargas, and M. Taufer. SOMOSPIE: A modular SOil MOisture SPatial Inference Engine based on data-driven decisions. In Proceedings of the 2019 15th International Conference on eScience (eScience) (2019). [link](https://ieeexplore.ieee.org/document/9041768)

## Copyright and License

Copyright (c) 2024, Global Computing Lab

Catalog Comparison Tool is distributed under terms of the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0) with LLVM Exceptions.
See [LICENSE](LICENSE) for more details.

## Authors

This project was created by the [NSDF team](https://nationalsciencedatafabric.org/contributors.html) and the SOMOSPIE team. To reach out email us at [info@nationalsciencedatafabric.org](email:info@nationalsciencedatafabric.org) and Dr. Michela Taufer [mtaufer@utk.edu](email:mtaufer@utk.edu). 

## Acknowledgments
The authors of this tutorial would like to express their gratitude to:

* NSF through the awards 2138811, 2103845, 2334945, 2138296, and 2331152.
* The Dataverse team [link](https://dataverse.org/about)
* The Seal Storage team [link](https://www.sealstorage.io/home/#team)
* Vargas Lab led by Dr. Rodrigo Vargas [link](https://www.udel.edu/academics/colleges/canr/departments/plant-and-soil-sciences/faculty-staff/rodrigo-vargas/)

Any opinions, findings, conclusions, or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.  
