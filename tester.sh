#!/bin/bash

##############################
# Initialize pyenv and other environment variables as needed
##############################
# Source configurations: importing pyenv_interpreters, not_pyenv_interpreters, external_libraries_to_install
# config.sh must be in the same directory as the current file
source config.sh

# Check if pyenv is installed and available
if ! command -v pyenv &> /dev/null; then
    echo "pyenv is not installed or not available. Please install it."
    exit 1
fi

# Check if pyenv_interpreters and not_pyenv_interpreters are empty
if [ ${#pyenv_interpreters[@]} -eq 0 ] && [ ${#not_pyenv_interpreters[@]} -eq 0 ]; then
    echo "Error: pyenv_interpreters and not_pyenv_interpreters is empty. Please provide interpreter versions in config.sh."
    exit 1
    # raise error: we need interpreters to do tests
fi
# "pypy3.9-v7.3.13-linux64" "pypy3.10-v7.3.13-linux64" "pythonnet-3.0.2"

# All Python files for tests must be in the 'python_scripts_to_test' directory
# 'python_scripts_to_test' must be in the same directory as tester.sh
files_to_execute=(python_scripts_to_test/*.py)

# new_python_rows need to measure execution time from inside of the python file
new_python_rows=$(cat <<EOF
import timeit
tic = timeit.default_timer()
image = mandelbrot()
toc = timeit.default_timer()
print(round((toc - tic) * 1000))
EOF
)

# Contract a function of installing external_libraries_to_install
install_external_packages() {
    local interpreter="$1"  # declares a local variable and assigns it the value of the first argument passed to the function
    # external_libraries_to_install was imported
    for external_package in "${external_libraries_to_install[@]}"; do
        if ! pip show "$external_package" &> /dev/null; then
            echo "Installing $external_package for $interpreter..."
            pip install "${external_package}" > /dev/null 2>&1 || echo "Failed to install $external_package."
        fi
    done
}

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
# Install all python pyenv_interpreters, not_pyenv_interpreters and external packages
##############################

# Check pyenv_interpreters for not empty case
if [ -n "$pyenv_interpreters" ]; then
    # Python pyenv_interpreters to install via pyenv if it is not installed before.
    # pyenv_interpreters was imported
    for interpreter in "${pyenv_interpreters[@]}"; do
        # Check if the interpreter is already installed in pyenv, if not: install
        if ! pyenv versions --bare | grep -wq "$interpreter"; then
            # Create a virtual environment for the interpreter
            echo "$interpreter is not installed in pyenv. Installing..."
            pyenv install "$interpreter" || { echo "Failed to install $interpreter."; exit 1; }
        fi

        pyenv local "$interpreter"  # Set the Python locally
        # Install external packages (compatible with the interpreter version) if they are not
        install_external_packages "$interpreter"
    done
fi

# Check not_pyenv_interpreters for not empty case
# $not_pyenv_interpreters was imported
if [ -n "$not_pyenv_interpreters" ]; then
    # Upgrade pip to have the last version
    pip install --upgrade pip
    # Python not_pyenv_interpreters to install via pip if it is not installed before.
    for interpreter in "${not_pyenv_interpreters[@]}"; do
        pip install "${interpreter}"

        pyenv local "$interpreter"  # Set the Python locally
        # Install external packages (compatible with the interpreter version) if they are not
        install_external_packages "$interpreter"
    done
fi

##############################
# Calculate time execution of the script
##############################

for file_path in "${files_to_execute[@]}"; do

    # Use head to extract all lines except the last 2 and create a temporary file to measure execution time from inside of the python file
    head -n -2 "$file_path" > temp_file.py
    # Append the new content to the temporary file
    echo "$new_python_rows" >> temp_file.py

    for interpreter in "${pyenv_interpreters[@]}"; do

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
