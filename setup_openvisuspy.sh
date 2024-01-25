#!/bin/bash

# Define the directory name
DIR="openvisuspy"

if [ -d "$DIR" ]; then
    echo "Removing existing $DIR directory..."
    rm -rf "$DIR"
fi
echo "Cloning the openvisuspy repository..."
git clone https://github.com/sci-visus/openvisuspy.git

cd openvisuspy
git checkout c1c8340cd015f04bc431b904a2bdfc0901cc34b0

echo "export PATH=\$PATH:$(pwd)/src" >> ~/.bashrc
echo "export PYTHONPATH=\$PYTHONPATH:$(pwd)/src" >> ~/.bashrc

. ~/.bashrc

echo "Setup completed."
