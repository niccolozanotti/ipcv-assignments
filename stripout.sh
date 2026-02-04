#!/usr/bin/env bash

# Check if nbstripout is installed
if ! command -v nbstripout &>/dev/null; then
  echo "Error: nbstripout is not installed"
  echo "Please install it along with other dev dependencies via"
  echo "pip install .[dev]"
  exit 1
fi

# Initialize arrays to separate flags from files
extra_flags=()
files=()

# Loop through all arguments provided to the script
for arg in "$@"; do
  if [[ "$arg" == -* ]]; then
    # If it starts with a hyphen, treat it as a flag
    extra_flags+=("$arg")
  else
    # Otherwise, treat it as a file
    files+=("$arg")
  fi
done

# Check if at least one file was provided
if [ ${#files[@]} -eq 0 ]; then
  echo "Usage: $0 [optional flags] <file1.ipynb> [file2.ipynb ...]"
  echo "Example: $0 --keep-output my_notebook.ipynb"
  exit 1
fi

# Loop strictly over the detected files
for file in "${files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Error: File '$file' does not exist"
    exit 1
  fi

  # NOTE: the metadata.kernelspec is kept since quarto needs it to start
  # the kernel and execute the cells when rendering
  nbstripout "${extra_flags[@]}" --extra-keys="metadata.celltoolbar " \
    "metadata.language_info.codemirror_mode.version" \
    "metadata.language_info.pygments_lexer" \
    "metadata.language_info.version metadata.toc" \
    "metadata.notify_time metadata.varInspector" \
    "cell.metadata.heading_collapsed" \
    "cell.metadata.hidden" \
    "cell.metadata.code_folding" \
    "cell.metadata.tags" \
    "cell.metadata.init_cell" \
    "$file"
done
