#!/bin/bash

##############################
# Initialize pyenv and other environment variables as needed
##############################

# Check if pyenv is installed and available
if ! command -v pyenv &> /dev/null; then
    echo "pyenv is not installed or not available. Please install it."
    exit 1
fi

# Python interpreters to install via pyenv if it is not installed.
interpreters=("2.1.3" "2.7.18" "3.8.12" "3.9.7" "3.10.5" "3.11.0" "3.12.0" "3.13-dev" "jython-2.5.0" "jython-2.7.2" "cinder-3.10-dev" "anaconda3-2019.03" "anaconda3-2020.02" "anaconda3-2021.04" "anaconda3-2022.05" "anaconda3-2023.07-2" "micropython-1.19.1" "pypy3.7-7.3.7" "pypy3.9-v7.3.13-linux64" "pypy3.10-v7.3.13-linux64" "pythonnet-3.0.2" "stackless-3.7.5" "ironpython-2.7.5" "graalpy-23.1.0" "mambaforge-22.9.0-3" "miniconda3-4.7.12" "miniforge3-22.11.1-4" "nogil-3.9.10-1")
#"3.0.1" "3.1.0" "pypy-1.6" "pypy-5.7.0" "pypy2-5.3" "pypy3-2.3.1" "ironpython-2.7.7" "pyston-2.3.5"
# The necessary libraries for testing python files will be installed in the venv.
libraries_to_install=("numpy")

# All Python files must be in the 'python_scripts_to_test' directory
# 'python_scripts_to_test' must be in the same directory as tester.sh
files_to_execute=(python_scripts_to_test/*.py)

# new_python_rows need to measure execution time from inside of the python file
new_python_rows=$(cat <<EOF
import time
tic = time.perf_counter_ns()
image = mandelbrot()
toc = time.perf_counter_ns()
print(round((toc - tic)/1_000_000))
EOF
)

# Extract file names from paths and filter for specific file name
echo "The next files will be tested for time execution:"
for file in "${files_to_execute[@]}"; do
    echo "$(basename "$file")"
done
echo ""

# The file runtime results will be saved in the output CSV file.
output_csv="runtime_result.csv"
# Create the CSV file with header
echo "Error,File,TimeFunctions(ms),TimeScript(ms),TimeScriptInterpreter(ms),Interpreter" > "$output_csv"


##############################
# Install all python interpreters and external packages
##############################

# Loop through each interpreter and function file
for interpreter in "${interpreters[@]}"; do
    # Check if the interpreter is already installed in pyenv, if not: install
    if ! pyenv versions --bare | grep -wq "$interpreter"; then
        # Create a virtual environment for the interpreter
        echo "$interpreter is not installed in pyenv. Installing..."
        pyenv install "$interpreter" || { echo "Failed to install $interpreter."; exit 1; }
    fi

    pyenv local "$interpreter"  # Set the Python locally

#   Install external packages (compatible with the interpreter version) if they are not
    for external_package in "${libraries_to_install[@]}"; do
        if ! pip show "$external_package" &> /dev/null; then
            echo "Installing $external_package for $interpreter..."
            pip install "${external_package}" > /dev/null 2>&1 || echo "Failed to install $external_package."
        fi
    done
done


##############################
# Calculate time execution of the script
##############################

for file_path in "${files_to_execute[@]}"; do

    # Use head to extract all lines except the last 2 and create a temporary file to measure execution time from inside of the python file
    head -n -2 "$file_path" > temp_file.py
    # Append the new content to the temporary file
    echo "$new_python_rows" >> temp_file.py

    for interpreter in "${interpreters[@]}"; do

        # Measure the whole execution time in microseconds
        start_whole_time=$(date +%s%3N)  # Get the start whole time in microseconds

        # Set the Python interpreter locally
        pyenv local "$interpreter"
        
        # Measure the script execution time in microseconds
        start_script_time=$(date +%s%3N)  # Get the start script time in microseconds
        python "$file_path"
        exit_status=$?  # 0 - script executed successfully, 1 - with error
        end_script_time=$(date +%s%3N)  # Get the end script time in microseconds
        
        end_whole_time=$(date +%s%3N)  # Get the end whole time in microseconds

        elapsed_script_time=$((end_script_time - start_script_time))  # Calculate the elapsed script time in microseconds
        elapsed_whole_time=$((end_whole_time - start_whole_time))  # Calculate the elapsed whole time in microseconds

	      echo "_______results_______"
	      file=$(basename "$file_path")

        if [ $exit_status -eq 1 ]; then
          # An error occurred
	        elapsed_script_time="-"
	        elapsed_whole_time="-"
	      fi

        # Measure time execution via python script
        python_time=$(python temp_file.py)  # execute the temporary file
        exit_status=$?  # 0 - script executed successfully, 1 - with error
        if [ $exit_status -eq 1 ]; then
          # An error occurred
	        python_time="-"
	      fi

        # Append the result to the CSV file
        echo "$exit_status,$file,$python_time,$elapsed_script_time,$elapsed_whole_time,$interpreter" >> "$output_csv"

        echo "File: $file"
        echo "Interpreter: $interpreter"
        echo "Execution python time: $python_time ms"
        echo "Execution script time: $elapsed_script_time ms"
        echo "Execution whole time: $elapsed_whole_time ms"

        # Output after the operation
        echo "====================="
        echo ""
    done
    # Clean up the temporary file, which used for measure time execution via python script
    rm temp_file.py
done
