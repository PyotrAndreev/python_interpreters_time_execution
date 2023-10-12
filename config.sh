# config.sh

# Pyenv Interpreters
pyenv_interpreters=(
    ### CPython ###
    # "2.1.3"
    # "2.7.18"
    # "3.8.12" 
    # "3.9.7" 
    # "3.10.5" 
    # "3.11.0" 
    "3.12.0" 
    # "3.13-dev"

    # ### Nogil ###
    # "nogil-3.9.10-1"

    # ### PyPy ###
    # "pypy3.5-5.7-beta" 
    # "pypy3.7-7.3.7"
    # "pypy3.9-7.3.12"
    # "pypy3.10-7.3.12"


    # ### Pyston ###
    # "pyston-2.3.5"

    # ### Jython ###
    # "jython-2.5.0" 
    # "jython-2.7.2"

    # ### GraalPy ###
    # "graalpy-23.1.0" 

    # ### Anaconda ###
    # "anaconda3-2019.03" 
    # "anaconda3-2020.02" 
    # "anaconda3-2021.04" 
    # "anaconda3-2022.05" 
    # "anaconda3-2023.07-2"

    # ### Miniconda ###
    # miniconda3-4.7.12

    # ### Miniforge ###
    # miniforge3-22.11.1-4

    # ### MicroPython ###
    # "micropython-1.19.1" 

    # ### Stackless ### 
    # "stackless-3.7.5" 

    # ### IronPython ###
    # "ironpython-2.7.5"

    # ### Cinder ###
    # "cindercd-3.10-dev"     
    )

# Non-Pyenv Interpreters
not_pyenv_interpreters=(

    ### PythonNet ###
    "pythonnet"

    )

# External Libraries
external_libraries_to_install=(
    "numpy"
    )
