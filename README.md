# OpenVisus Tutorial: SOMOSPIE Terrain Parameters

<p align="center">
    <img src="https://nationalsciencedatafabric.org/assets/images/logo.png" width="350">
</p>

<p align="center">
<a href="https://www.python.org/downloads/release/python-310/"><img alt="Python 3.10" src="https://img.shields.io/badge/Python-3.10-3776AB.svg?style=flat&logo=python&logoColor=white"></a>
<a href="https://dl.acm.org/doi/10.1145/3588195.3595941"><img alt="DOI" src="https://zenodo.org/badge/DOI/10.1145/3588195.3595941.svg"></a>
<a href="https://opensource.org/licenses/Apache-2.0"><img alt="License" src="https://img.shields.io/badge/License-Apache_2.0-green.svg"></a>
<a href="https://nsdf-workspace.slack.com/"><img alt="Slack" src="https://badges.aleen42.com/src/slack.svg"></a>
<a href="https://www.docker.com"><img alt="Docker" src="https://badges.aleen42.com/src/docker.svg"></a>
<a href="https://github.com/astral-sh/ruff"><img alt="Ruff" src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json"></a>

## Overview

This tutorial uses the following architecture:

<p align="center">
    <img src="files/docs/Openvisus-somospie.png" width="800">
</p>

---

<details>
  <summary>Click me</summary>
  
  ### Table of content
  1. [Quickstart](#quickstart)
  2. [Installation](#installation)
  3. [Community](#community)
  4. [Related Publications](#related-publications)
  5. [Copyright and License](#copyright-and-license)
  6. [Authors](#authors)
  7. [Acknowledgments](#acknowledgments)
</details>

## Quickstart

The fastest way to get started is to use docker-compose:

```
docker-compose up -d
```

It should now be possible to access a Jupyter lab interface at:

```
http://localhost:5000/
```

## Installation

There are two ways to install and run the tutorial: i) [Using your local machine](#using-your-local-machine) and ii) [Using a docker container](#using-a-docker-container)

### Using your local machine

[Conda](https://www.anaconda.com/download/) is used to control all the dependencies in this project, the file `environment.yml` contains the list of required versions:

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

To install the dependencies in your local machine use the following command

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

### Using a Docker container

To build the docker image in your local machine:

```
docker build --platform linux/amd64 -f globalcomputinglab/somospie_openvisus .
```

To pull the image from Dockerhub:

```
docker pull globalcomputinglab/somospie_openvisus:latest
```

To run:

```
docker run -d -p 5000:5000 -p 8989:8989 --name tutorial --platform linux/amd64 globalcomputinglab/somospie_openvisus
```

Follow this URL to run the Jupyter Notebook `Tutorial.ipynb`:

```
http://localhost:5000/
```

## Community

OpenVisus is an open-source project. Questions, discussion, and
contributions are welcome. Contributions can be anything from new
packages to bug fixes, documentation, or even new core features.

Resources:

- **Slack workspace**: [nsdf-workspace](https://nsdf-workspace.slack.com/).
- **Github Discussions**: [issues](https://github.com/nsdf-fabric/catalog-comparison-tool/issues): not just for discussions, also Q&A.
- **Mailing list**: [https://groups.google.com/g/nsdf](https://groups.google.com/g/nsdf) - nsdf@googlegroups.com
- **Twitter**: [@FabricNsdf](https://twitter.com/FabricNsdf).

## Related Publications

- Camila Roa, Paula Olaya, Ricardo Llamas, Rodrigo Vargas, and Michela Taufer. 2023. GEOtiled: A Scalable Workflow for Generating Large Datasets of High-Resolution Terrain Parameters. In Proceedings of the 32nd International Symposium on High-Performance Parallel and Distributed Computing (HPDC '23). Association for Computing Machinery, New York, NY, USA, 311–312. https://doi.org/10.1145/3588195.3595941

## Copyright and License

Copyright (c) 2023, Global Computing Lab

Catalog Comparison Tool is distributed under terms of the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0) with LLVM Exceptions.
See [LICENSE](LICENSE) for more details.

## Authors

This project was created by the [NSDF team](https://nationalsciencedatafabric.org/contributors.html). To reach out email us at [info@nationalsciencedatafabric.org](email:info@nationalsciencedatafabric.org)

## Acknowledgments

National Science Data Fabric is funded by the National Science Foundation (NSF) under grant number 2138811.
Any opinions, findings, conclusions, or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.
