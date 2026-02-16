# Image Processing and Computer Vision assignments

This repository contains the solution to the 2 assignments for the [course](https://www.unibo.it/en/study/course-units-transferable-skills-moocs/course-unit-catalogue/course-unit/2024/446598)
*Image Processing and Computer Vision* taught at [unibo](https://www.unibo.it) for the a.y. 24/25 by [Prof. S. Salti](https://scholar.google.com/citations?user=1kcIJG0AAAAJ) and [Prof. G. Lisanti](https://scholar.google.com/citations?user=OdDBed4AAAAJ).

---

## Setup

```sh
# Clone repository
git clone -b main --single-branch https://github.com/niccolozanotti/ipcv-assignments
cd ipcv-assignments

# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install dependencies
pip install ".[assignment1]"      # Assignment 1
pip install ".[assignment2]"      # Assignment 2
pip install ".[dev]"              # dev tools
# Or with uv:
uv sync --extra assignment1       # Assignment 1
uv sync --extra assignment2       # Assignment 2
uv sync --extra dev               # With dev tools
```

### License

The code in this repository is [MIT](./LICENSE) licensed.
