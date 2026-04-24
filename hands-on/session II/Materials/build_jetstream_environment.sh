#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------
# Pretty printing helpers (same style)
# ----------------------------------------

function generate_separator {
  local max_len=0
  for arg in "$@"; do
    ((${#arg} > max_len)) && max_len=${#arg}
  done

  local spaces
  printf -v spaces "%${max_len}s" ""
  echo "${spaces// /=}"
}

function print_separated_message {
  local sep
  sep=$(generate_separator "$@")

  echo "$sep"
  for line in "$@"; do
    echo "$line"
  done
  echo "$sep"
}

function die {
  echo "ERROR: $*" >&2
  exit 1
}

function step {
  # Usage: step "1/7" "Message"
  print_separated_message "[${1}] ${2}"
}

# ----------------------------------------
# Static settings (change only if needed)
# ----------------------------------------

ENV_NAME="NSDF-Tutorial"
KERNEL_NAME="nsdf-tutorial"
KERNEL_DISPLAY='Python (NSDF-Tutorial)'

# ----------------------------------------
# Derived paths
# ----------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# ----------------------------------------
# 0) Ensure conda is available
# ----------------------------------------

step "0/7" "Checking conda availability"

if command -v module >/dev/null 2>&1; then
  # Jetstream module environment
  module purge >/dev/null 2>&1 || true
  module load miniforge >/dev/null 2>&1 || true
fi

command -v conda >/dev/null 2>&1 || die "conda not found. Did you 'module load miniforge'?"

# Make conda activate work in scripts
# shellcheck disable=SC1090
source "$(conda info --base)/etc/profile.d/conda.sh"

# ----------------------------------------
# 1) Create env from environment.yml (replace if exists)
# ----------------------------------------

step "1/7" "Create env from environment.yml (name: ${ENV_NAME})"

if conda env list | awk '{print $1}' | grep -qx "$ENV_NAME"; then
  echo "Removing existing env: ${ENV_NAME}"
  conda env remove -n "$ENV_NAME" -y >/dev/null
fi

conda env create -f environment.yml >/dev/null

# ----------------------------------------
# 2) Activate environment
# ----------------------------------------

step "2/7" "Activate env: ${ENV_NAME}"

conda activate "$ENV_NAME"
hash -r

# ----------------------------------------
# 3) Verify activation (hard fail if wrong)
# ----------------------------------------

step "3/7" "Verify activation"

python - <<PY
import os, sys
env = os.environ.get("CONDA_DEFAULT_ENV")
prefix = os.environ.get("CONDA_PREFIX")
print("CONDA_DEFAULT_ENV:", env)
print("CONDA_PREFIX:", prefix)
print("sys.executable:", sys.executable)
if env != "$ENV_NAME":
    raise SystemExit(f"ERROR: expected CONDA_DEFAULT_ENV=$ENV_NAME but got {env}")
PY

# ----------------------------------------
# 4) Install GEOtiled/geotiled editable
# ----------------------------------------

step "4/7" "Install GEOtiled/geotiled editable"

GEOTILED_DIR="$SCRIPT_DIR/GEOtiled/geotiled"
[[ -d "$GEOTILED_DIR" ]] || die "GEOtiled/geotiled dir not found: $GEOTILED_DIR"

python -m pip install -e "$GEOTILED_DIR" >/dev/null

# ----------------------------------------
# 5) Configure Openvisuspy environment variables
# ----------------------------------------

step "5/7" "Configure Openvisuspy env vars (~/.bashrc)"

OPENVISUSPY_SRC="$SCRIPT_DIR/openvisuspy/src"
[[ -d "$OPENVISUSPY_SRC" ]] || die "openvisuspy/src not found: $OPENVISUSPY_SRC"

# Append only if not already present (idempotent-ish)
append_if_missing () {
  local line="$1"
  local file="$2"
  grep -Fqx "$line" "$file" 2>/dev/null || echo "$line" >> "$file"
}

BASHRC="$HOME/.bashrc"

append_if_missing "export PATH=\"\$PATH:${OPENVISUSPY_SRC}\"" "$BASHRC"
append_if_missing "export PYTHONPATH=\"\$PYTHONPATH:${OPENVISUSPY_SRC}\"" "$BASHRC"
append_if_missing "export BOKEH_ALLOW_WS_ORIGIN='*'" "$BASHRC"
append_if_missing "export BOKEH_RESOURCES='cdn'" "$BASHRC"
append_if_missing "export VISUS_CACHE=/tmp/visus-cache/nsdf-services/somospie" "$BASHRC"
append_if_missing "export VISUS_CPP_VERBOSE=1" "$BASHRC"
append_if_missing "export VISUS_NETSERVICE_VERBOSE=1" "$BASHRC"
append_if_missing "export VISUS_VERBOSE_DISKACCESS=1" "$BASHRC"

# Load into current shell too
# shellcheck disable=SC1090
source "$BASHRC"

# ----------------------------------------
# 6) Install openvisuspy editable
# ----------------------------------------

step "6/7" "Install openvisuspy editable"

OPENVISUSPY_DIR="$SCRIPT_DIR/openvisuspy"
[[ -d "$OPENVISUSPY_DIR" ]] || die "openvisuspy dir not found: $OPENVISUSPY_DIR"

python -m pip install -e "$OPENVISUSPY_DIR" >/dev/null

# ----------------------------------------
# 7) Install ipykernel + register kernel
# ----------------------------------------

step "7/7" "Install Jupyter kernel + extras"

# keep these visible enough to diagnose, but not too noisy
ENV_BIN_DIR="$CONDA_PREFIX/bin"

python -m ipykernel install --user \
  --name "$KERNEL_NAME" \
  --display-name "$KERNEL_DISPLAY" \
  --env PATH "$ENV_BIN_DIR:$OPENVISUSPY_SRC:$PATH" \
  --env LD_LIBRARY_PATH "$CONDA_PREFIX/lib:$CONDA_PREFIX/lib/gdalplugins" \
  --env PROJ_LIB "$CONDA_PREFIX/share/proj" \
  --env GDAL_DATA "$CONDA_PREFIX/share/gdal" \
  --env PROJ_NETWORK "ON" 

print_separated_message \
  "DONE" \
  "" \
  "Environment:" \
  "  conda activate ${ENV_NAME}" \
  "" \
  "Kernel:" \
  "  jupyter kernelspec list" \
  "  (look for '${KERNEL_DISPLAY}')"
