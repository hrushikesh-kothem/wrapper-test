#!/bin/bash

# Set environment variables for temporary directories
export TMPDIR=/tmp
export MPLCONFIGDIR=/tmp

# Initialize Conda and activate environment
source /opt/etc/conda_init_script
conda activate karabo

# Run the Python script directly from within this shell script
python3 - << 'EOF'
from datetime import datetime
import numpy as np

from karabo.simulation.interferometer import InterferometerSimulation
from karabo.simulation.observation import Observation
from karabo.simulation.sky_model import SkyModel
from karabo.simulation.telescope import Telescope

# Create a simple sky model with three point sources
sky = SkyModel()
sky_data = np.array(
    [
        [20.0, -30.0, 1, 0, 0, 0, 100.0e6, -0.7, 0.0, 0, 0, 0],
        [20.0, -30.5, 3, 2, 2, 0, 100.0e6, -0.7, 0.0, 600, 50, 45],
        [20.5, -30.5, 3, 0, 0, 2, 100.0e6, -0.7, 0.0, 700, 10, -10],
    ]
)
sky.add_point_sources(sky_data)

# Get predefined telescope
telescope = Telescope.constructor("EXAMPLE")
telescope.centre_longitude = 3

# Set up observation
observation = Observation(
    start_frequency_hz=1e6,
    start_date_and_time=datetime(2024, 3, 15, 10, 46, 0),
)

# Run the simulation
simulation = InterferometerSimulation()
simulation.run_simulation(telescope, sky, observation)
EOF
