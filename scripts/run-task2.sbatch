#!/bin/bash
#SBATCH --job-name=task2-ipcv
#SBATCH --mail-type=ALL
#SBATCH --mail-user=niccolo.zanotti@studio.unibo.it
#SBATCH --time=08:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=30G
#SBATCH --partition=l40
#SBATCH --output=%x_%j.logs
#SBATCH --chdir=/scratch.hpc/niccolo.zanotti/software/IPCV/assignment2
#SBATCH --gres=gpu:1

# --- Setup Environment ---
export SCRATCH="/scratch.hpc/$USER"
export PROJECT_DIR="$SCRATCH/software/IPCV/assignment2"

COMMIT_HASH=$(git rev-parse --short HEAD)

# Check if git command worked, fallback to "unknown" if not
if [ -z "$COMMIT_HASH" ]; then
    COMMIT_HASH="unknown"
fi

echo "Running on commit: $COMMIT_HASH"

export NOTEBOOK="assignment2.ipynb"
export OUTPUT_NOTEBOOK="assignment2_${COMMIT_HASH}.ipynb"

# uv binary (0.10)
export PATH="$SCRATCH/ext_bins/uv-bin:$PATH"
export XDG_CACHE_HOME="$SCRATCH/.cache"
export XDG_DATA_HOME="$SCRATCH/.local/share"
export XDG_CONFIG_HOME="$SCRATCH/.config"

# graphviz binary (ubuntu 22.04)
export PATH="$EXT_BINS/graphviz/usr/bin:$PATH"
export LD_LIBRARY_PATH="$EXT_BINS/graphviz/usr/lib:$LD_LIBRARY_PATH"

echo "Starting execution of $NOTEBOOK..."
echo "Output will be saved to $OUTPUT_NOTEBOOK"

uv run jupyter nbconvert \
    --to notebook \
    --execute "$PROJECT_DIR/$NOTEBOOK" \
    --output "$PROJECT_DIR/$OUTPUT_NOTEBOOK"

echo "Done."
