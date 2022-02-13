#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"


if [ -z "$1" ]; then
    echo "Pass virtual env directory as argument"
else
    echo "Activating the virtual python environment"
    source $DIR/$1/bin/activate #ped-detector is the name of your virtual env
    echo "Running the pedestrian detector"
    if [ "$2" == "--headless" ]; then
	echo "Running Headless!"
        python $DIR/src/thermal_save_csv.py --headless \
        --color_depth=256 \
        --max_temp=31 \
        --ambient_offset=10 \
        --ambient_time=120 \
        --csv_save_interval=10 \
        --blob_min_threshold=0 \
        --blob_filterbyarea --blob_min_area=750 \
        --blob_filterbyconvexity --blob_min_convexity=0.87 \
        --blob_filterbyinertia --blob_min_inertiaratio=0.1 
    else
        python $DIR/src/thermal_save_csv.py \
        --color_depth=256 \
        --max_temp=31 \
        --ambient_offset=10 \
        --ambient_time=120 \
        --csv_save_interval=10 \
        --blob_min_threshold=0 \
        --blob_filterbyarea --blob_min_area=750 \
        --blob_filterbyconvexity --blob_min_convexity=0.87 \
        --blob_filterbyinertia --blob_min_inertiaratio=0.1 
#        --blob_max_threshold=255 \
#        --blob_filterbycircularity --blob_min_circularity=0.1 \
    fi
fi

# ITS THE AMBIENT OFFSET vs PHYSICAL POSITION OF THE SENSOR
