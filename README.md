ERROR: runtime_result.csv: Error can be 255, WHY? It should be 0 or 1
Compare with [Mojo](https://www.modular.com/mojo)
# Python Interpreter Performance: Testing and Insights
Let's Radically Improve Your Python Time Execution.

The article explains how Python interpreters work, what types exist and provides test comparisons with deep analytics.
Here represented 18 Python interpreters and 28 versions.
The project provides an opportunity to test time execution of any files with '.py' extinction.

Temporary:
The project as an article in the next resources: linkedin, vc.ru, tproger, medium, hashnode, habr, towardsdatascience, ?tabnine
Research the [article](https://towardsdatascience.com/getting-started-with-pypy-ef4ba5cb431c)

## Table of Contents
take all the names and split by groups
- [About](#about)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Python Interpreters](#python-interpreters)
  - [CPython](#cpython)
  - [Nogil](#Nogil)
  - [PyPy](#pypy)
  - [Pyston](#pyston)
  - [Jython](#jython)
  - [GraalPy](#Graalpy)
  - [Anaconda](#anaconda)
  - [Miniconda](#miniconda)
  - [Miniforge](#miniforge)
  - [Xeus](#Xeus)
  - [MicroPython](#micropython)
  - [pythonnet](#pythonnet)
  - [Stackless](#stackless)
  - [Ironpython](#ironpython)
  - [Cinder](#cinder)
  - [Pyodide](#pyodide)
  - [Brython](#brython)
- [Results Analytics](#results-analytics)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## About
The first goal of the project is to compare Python files time execution with different Python interprets. It can be useful to understand different interpreters better that is the second goal and the first attempt to find the best interpreter for your python code.

I will do Mandelbrot set calculations as an example to demonstrate the results by some Python interprets. The test files do not represent whole power and vast abbility of some interpreters as multithreading. To come in more deeply you can make tests on your own Python files.

I will you three different Python files: 
- pure Python code
- pure Python code with type annotations
- Python code with ```numpy```

You will see 3 measurements of time file execution:
- measurement of function via ```time``` module
- measurement of the whole python file
- measurement of start interpreter and a python file execution

If you find any errors or inaccuracies, please 
## Getting Started

### Prerequisites
All tests were carried out on a Linux system Ubuntu 22.04 LTS x86_64
My system configuration:
- **CPU**: 4463MHz AMD Ryzen 7 5800H with Radeon Graphics
- **RAM**: ≈38GB 3200 MT/s SAMSUNG MZVLB1T0HBLR
- **GPU**: ≈6GB GeForce RTX 3060 Mobile / Max-Q

You may have different calculation results if you have different system parameters from those mentioned above.
To implement the project, make sure you have the following packages installed: ```pip```

### Installation
Ensure that you have the required dependencies for building Python in Ubuntu/Debian/Mint:
```shell
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
```

For the first let's install ```pyenv``` [GitHub](https://github.com/pyenv/pyenv)
```shell
curl https://pyenv.run | bash
```
```Pyenv``` is a popular tool used for managing multiple Python installations on your computer. It allows you to easily switch between different versions of Python and set the global or project-specific Python version. This is particularly useful when you work on different projects that require different Python versions or when you want to test your code with various Python versions.

### Project Structure
Now you are ready for tests.
At the moment open directory where ```tester.sh``` is located.
Just run the file:
```shell
./tester.sh
```
During the execution phase, all interpreters will be downloaded and installed automatically. The configuration is handled through a ```config.sh``` file, which contains the details of the interpreters and necessary libraries for performing Mandelbrot set calculations.
```config.sh``` and ```tester.sh``` must be in the same directory.

My internet connection is ~10Mb/s.
Time execution of ```./tester.sh``` from scratch is 30 minutes:
- 1 minute is computations

#### ```config.sh``` File Structure:
- **pyenv_interpreters**: Lists interpreters usable by the pyenv system.
- **not_pyenv_interpreters**: Specifies interpreters that cannot be installed by pyenv.
- **external_libraries**: Enumerates externally used frameworks what are imported from interpreters in the Python files as ```import numpy as np```

The next is default set:
- ```pyenv_interpreters```:
  - 2.1.3 2.7.18 3.8.12 3.9.7 3.10.5 3.11.0 3.12.0 3.13-dev 
  - nogil-3.9.10-1
  - pypy3.7-7.3.7 pypy3.5-5.7-beta pypy3.7-7.3.7 pypy3.9-7.3.12 pypy3.10-7.3.12
  - jython-2.5.0 jython-2.7.2 
  - graalpy-23.1.0
  - anaconda3-2019.03 anaconda3-2020.02 anaconda3-2021.04 anaconda3-2022.05 anaconda3-2023.07-2
  - miniconda3-4.7.12
  - miniforge3-22.11.1-4
  - micropython-1.19.1 
  - stackless-3.7.5 
  - ironpython-2.7.5 
  - cinder-3.10-dev

- ```not_pyenv_interpreters```: pythonnet-3.0.2
- ```external_libraries``` will be installed in each Python interpreter: ```numpy```

#### Customization:
- You can specify your chosen interpreters in the ```config.sh``` file.
- If adding your own Python files to the ```python_scripts_to_test``` directory, ensure to include any dependencies and external libraries under ```external_libraries``` in the ```config.sh``` file. 

## Python Interpreters
The engines that power your Python programs, making them come to life.

### CPython
- [GitHub](https://github.com/python/cpython)
- [Main site](https://www.python.org)
- [Documentation](https://docs.python.org/3/)
- [Developer’s Guide](https://devguide.python.org/)

```CPython``` is the default and most widely used implementation of the ```Python``` programming language, known for its adherence to the official ```Python``` specifications, being written in ```C```, and compiling ```Python``` code into bytecode for execution.
#### Pros:
1. **Widely Used**: ```CPython``` is the reference implementation, meaning it's the standard ```Python``` most developers use. So, you'll find a ton of resources and libraries.
2. **Robust Ecosystem**: Since ```CPython``` is the official reference implementation, it's closely aligned with the Python language itself. This means it's usually the first to support new features. It's well-established and battle-tested, so you can rely on it for mission-critical applications.
3. **Compatible**: ```CPython``` plays well with others. You can easily integrate ```Python``` libraries and frameworks into your projects.
4. **C-Power**: If you need extra speed for computationally intensive tasks, ```CPython``` can integrate ```C``` and ```C++``` code, giving you that extra boost.
#### Cons:
1. **Performance**: While it is not slow, it might not be as fast as other ```Python``` implementations like ```PyPy``` or ```Jython```. But for most use cases, it is plenty fast.
2. **Memory Usage**: It can be memory-intensive for some use cases. If you're building highly memory-efficient applications, you might need to explore other ```Python``` implementations.
3. **Global Interpreter Lock (GIL)**: This can limit the ability to use multiple ```CPU``` cores in a single process. It's not a problem for many applications, but if you're doing heavy parallel processing, it could be a bottleneck.
4. **Not Ideal for Some Scenarios**: For specific use cases like tasks that require low-level hardware control, ```CPython``` might not be the best fit. There are other Python implementations like ```MicroPython``` designed for these scenarios.

### Nogil
- [GitHub](https://github.com/colesbury/Nogil)
- [Documentation](https://github.com/colesbury/Nogil/tree/Nogil/Doc)
- [Python Multithreading without GIL](https://docs.google.com/document/d/18CXhDb1ygxg-YXNBJNzfzZsDFosB5e6BfnXLlejd9l0/edit#heading=h.kcngwrty1lv)

```GIL``` (going ```Nogil```) is a proof-of-concept implementation of ```CPython``` that supports multithreading without the global interpreter lock (```GIL```). Sometimes, you have tasks that can truly benefit from ```multi-threading```. This is where ```Nogil``` comes into play. For example, if you're doing computationally intensive work using a ```Python``` extension or library like ```NumPy``` or ```Cython```, ```Nogil``` can help. But it comes with great responsibility. You need to ensure that your code is thread-safe because ```Python``` won't protect you.
#### Pros:
1. **Performance Boost**: If you have computationally intensive tasks, this can lead to significant speed improvements. For example, imagine you're working on a ```Python``` application that needs to crunch numbers or process large data sets.
2. **Concurrency**: With ```Nogil```, you’re stepping into real concurrency. Unlike the pseudo-concurrency that ```Python```’s threading module offers due to the ``GIL``, ```Nogil``` in ```Cython``` can offer true concurrency which is crucial for certain applications. 
3. **Utilize Multiple Cores**: Modern computers have multiple cores, and ```Nogil``` allows your code to utilize these cores to their full extent by allowing multiple threads to run in ```parallel```.
4. **C-Power**: If you're integrating Python with existing ```C``` code, going ```Nogil``` can simplify the process. Python and ```C``` can work more harmoniously together, allowing for a seamless fusion of the two. This is especially valuable in scientific computing libraries and systems where high-performance is crucial.
#### Cons:
1. **Complexity**: Going ```Nogil``` often leads to more complex code. It introduces threading, which can be notoriously tricky to get right. You'll need to be well-versed in managing thread safety to avoid problems like race conditions, deadlocks, and data corruption.
2. **Python Object Access**: Without the ```GIL```, ```Python``` objects cannot be accessed from multiple threads without the use of locks or other synchronization mechanisms. This can lead to situations where you need to be extra cautious to prevent unexpected behavior. Imagine you are working on a web server application, and different threads are handling incoming requests. Without proper synchronization, one thread's action could inadvertently affect another's.
3. **Not Always Faster**: The benefits of ```Nogil``` are mostly seen in ```CPU```-bound tasks. For ```I/O```-bound tasks, the advantages might not be as pronounced, and the increased complexity may not be worth the trade-off. In some cases, it can even slow your program down. Python threads may be slower than expected due to the overhead of managing multiple threads. So, you have to carefully analyze your specific use case to see if going ```Nogil``` is worthwhile.

!!! ### PyPy
- [Heptapod](https://foss.heptapod.net/pypy/pypy)
- [Main site](https://www.pypy.org/)
- [Documentation](https://doc.pypy.org/en/latest/)
- [Releases](https://downloads.python.org/pypy/)

```PyPy``` is an alternative ```Python``` interpreter that aims to provide improved performance through Just-In-Time (```JIT```) compilation, making ```Python``` code run faster while maintaining compatibility with standard ```Python``` implementations. It is based on the ```RPython``` ([documentation](https://rpython.readthedocs.io/en/latest/)) compiler framework for dynamic language implementations. In practical terms, if you have a long-running program that requires a speed boost, ```PyPy``` is an excellent choice. It's like a turbocharger for ```Python```. But, if you're working with very small scripts or have memory constraints, ```CPython``` might be the better option.
#### Pros:
1. **Performance Boost**: ```PyPy``` uses a ```JIT``` compiler, which dynamically compiles your Python code into machine code, optimizing it as it goes. This makes it particularly efficient, faster for long-running processes compared to ```CPython```.
2. **Compatibility**: ```PyPy``` aims for compatibility with ```CPython```. This means most Python packages and libraries work seamlessly with ```PyPy```. You can usually switch to ```PyPy``` without too much trouble.
#### Cons:
1. **Warm-Up Time**: While ```PyPy``` is faster for long-running processes, it has a warm-up time. This means for brief scripts, it may not be as quick as ```CPython``` because of the time it takes to compile your code. However, this is often negligible for most real-world applications.
2. **Limited Support for C-Extensions**: Some ```Python``` packages that rely on ```C```-extensions might not work with ```PyPy```. While many packages do, this can be a limitation if you depend on a specific package that's not compatible.

!!! ### Pyston
- [GitHub](https://github.com/pyston/pyston)
- [Main site](https://www.pyston.org/)
- [Blog](https://blog.pyston.org/)
- [Discord](https://discord.com/invite/S7gsqnb)

#### Pros:
1.
#### Cons:
1.

### Jython
- [GitHub](https://github.com/jython/jython)
- [Main site](https://www.jython.org/)
- [The Definitive Guide to Jython](https://jython.readthedocs.io/en/latest/)

```Jython``` is an implementation of the Python programming language written in Java, allowing Python code to be executed on the Java Virtual Machine (JVM). If you have a piece of Python code and a Java application, Jython can bridge the gap. You write Python code, and Jython translates it into Java, allowing you to run Python within a Java environment.
#### Pros:
1. **Java Integration**: ```Jython``` is seamlessly integrated with ```Java```, allowing Python developers to leverage the vast ecosystem of ```Java``` libraries, frameworks, and tools with ```Python``` code. This makes it a preferred choice for ```Python``` developers working in ```Java```-heavy environments.
2. **Cross-Platform**: Like other ```Python``` interpreters, ```Jython``` is cross-platform. It can run on any platform with a Java Virtual Machine (```JVM```), making it suitable for various operating systems.
3. **Java Performance**: ```Jython``` can benefit from the performance optimizations present in the ```JVM```, making it faster than traditional ```Python``` interpreters for some use cases.
#### Cons:
1. **Compatibility**: ```Jython``` is compatible with ```Python 2.7```, which is outdated and no longer officially supported. This restricts access to modern Python features and libraries introduced in Python 3.x.
2. **Global Interpreter Lock (GIL)**: Like ```CPython```, ```Jython``` is subject to the Global Interpreter Lock, limiting its ability to take full advantage of multi-core processors for CPU-bound tasks.
3. **Community and Libraries**: Jython has a smaller community and ecosystem compared to ```CPython``` or ```PyPy```. This means fewer third-party libraries and community support.

### GraalPy
- [GitHub](https://github.com/oracle/graalpython)
- [Main site](https://www.graalvm.org/python/)
- [Documentation](https://www.graalvm.org/latest/docs/)

```GraalPy``` is an implementation of the ```Python``` language on top of ```GraalVM```. A primary goal is to support ```PyTorch```, ```SciPy```, and their constituent libraries, as well as to work with other data science and machine learning libraries from the rich Python ecosystem. ```GraalPy``` can usually execute pure Python code faster than ```CPython```, and nearly match ```CPython``` performance when ```C``` extensions are involved. ```GraalPy``` currently aims to be compatible with ```Python 3.10```. While many workloads run fine, any ```Python``` program that uses external packages could hit something unsupported.
#### Pros:
1. **High Performance**: ```GraalPy``` is known for its performance advantage over traditional ```CPython```. It's reported to execute ```Python``` code on average 3.4 times faster than ```CPython```, which can be a significant boon in computationally intensive work scenarios
2. **Interoperability**: It plays well with other ```GraalVM``` languages, like ```JavaScript``` and ```Java```. This makes it an excellent choice for polyglot applications where you need to use multiple languages.
3. **Native Image Compilation**: You can compile your ```Python``` applications into standalone executables using ```GraalVM```'s native image feature. This results in faster startup times and less memory usage.
4. **Data Science Libraries**: ```GraalPy``` aims to support major data science and machine learning libraries like ```PyTorch``` and ```SciPy```.
5. **Ecosystem Integration**: ```GraalVM``` is integrated into various tools, like ```Truffle``` and ```SubstrateVM```, which enables ```GraalPython``` to work smoothly with different libraries and frameworks.
#### Cons:
1. **Warm-up Time**: Before reaching peak performance, ```GraalPy``` requires a warm-up period, especially when running on the JVM or with a native executable created by Native Image. The actual startup behavior highly depends on the workload, which might not be ideal in scenarios requiring immediate peak performance right from the start.
2. **Large Binary Size**: ```GraalPy``` binaries are significantly larger than ```CPython``` binaries, nearly about 10 times larger. The larger binary size is due to various factors including different data structures, extra metadata, and additional code required to support the ```JIT``` (Just-In-Time) compiler for ```Python``` code.
3. **Limited Package Compatibility**: ```GraalPy``` comes with a tool called ```ginstall``` to install a small list of packages known to work with ```GraalVM```'s ```Python``` runtime. This suggests that not all Python packages may be compatible with ```GraalPy```, and developers might need to check and ensure the compatibility of the libraries and frameworks they plan to use. Furthermore, ```ginstall``` is for packages made explicitly compatible with ```GraalVM```, whereas using ```pip``` to install packages can be a gamble for extension modules, indicating possible compatibility issues with some ```Python``` packages.

### Anaconda
- [GitHub](https://github.com/Anaconda-Platform)
- [Main site](https://www.anaconda.com/)
- [Documentation by tariff plan](https://docs.anaconda.com/)
- [Anaconda Cloud](https://anaconda.cloud/)
- [Code in the cloud](https://www.anaconda.com/code-in-the-cloud)

```Anaconda``` is a distribution of ```Python``` and ```R```, used for data science and scientific computing. That includes a collection of 250+ pre-installed open-source scientific packages and their dependencies that have been tested to work well together, including ```SciPy```, ```NumPy```, and many others. Use the ```conda install``` command to easily install 7,500+ popular open-source packages for data science — including advanced and scientific analytics — from the ```Anaconda``` repository. It is a popular choice for ```data analysis``` and ```machine learning```. 
#### Pros:
1. **Package Management**: ```Anaconda``` provides a robust package management system via ```conda```, making it easy to install, update, and manage ```Python``` packages and dependencies.
2. **Data Science Ecosystem**: ```Anaconda``` comes pre-packaged with a comprehensive set of libraries and tools for ```data science```, ```machine learning```, and scientific computing, making it a top choice for data professionals.
3. **Virtual Environments**: ```Anaconda``` includes ```conda``` environments that allow you to create isolated ```Python``` environments with specific package configurations.
#### Cons:
1. **Performance**: While ```Anaconda``` provides excellent tools for data science, it might not be as optimized for general-purpose ```Python``` development or high-performance computing as some other distributions.
2. **Resource Intensive**: It can be resource-intensive. Some data science tasks can be memory-hungry, and ```Anaconda``` may require a substantial amount of ```RAM```. If you're working on a machine with limited resources, it might slow down your system.
3. **Updates**: ```Anaconda``` updates might not be as frequent as the official ```Python``` interpreter ```CPython```. This can be an issue if you need the bleeding-edge ```Python``` features.

!!! ### Miniconda
- [User guide](https://docs.conda.io/projects/conda/en/stable/user-guide/index.html) 
- [Documentation](https://docs.conda.io/projects/miniconda/en/latest/)

A free minimal installer for conda. Miniconda is a small, bootstrap version of Anaconda that includes only conda, Python, the packages they depend on, and a small number of other useful packages, including pip, zlib, and a few others. Use the conda install command to install 7,500+ additional conda packages from the Anaconda repository.
#### Pros:
1. **Lightweight**: Miniconda is lightweight and quick to install, making it a great choice if you are working with limited disk space or only need specific packages. Anaconda requires around 3 GB of disk space for installation, while Miniconda only requires around 400 MB.
#### Cons:
1. **Limited Pre-installed Packages**: As a minimalistic distribution, Miniconda doesn't come with a wide array of pre-installed scientific packages and tools that are present in Anaconda. You have to manually install many of them.

!!! ### Miniforge
- [GitHub](https://github.com/conda-forge/miniforge)

Miniforge is a lightweight distribution of Python, based on conda, designed for minimalism and simplicity in managing packages and environments for scientific computing and data science applications. If Miniforge is on the system path (default on Mac and Linux), its versions of the ```conda``` and ```mamba``` programs can be used at any command prompt. The most notable difference is that the default channel for packages will be conda-forge.

!!! ### Xeus
- [GitHub](https://github.com/jupyter-xeus/xeus)
- [Documentation](https://xeus.readthedocs.io/en/latest/)

```Xeus``` is a library meant to facilitate the implementation of kernels for Jupyter. It takes the burden of implementing the Jupyter Kernel protocol, so developers can focus on implementing the interpreter part of the kernel.  It offers enhanced features for exploratory data analysis, visualization, and collaboration.
#### Pros:
1. **Rich Ecosystem**: Being part of the Jupyter ecosystem, ```Xeus``` inherits the extensive set of available tools, extensions, and libraries that Jupyter is known for. This means you can leverage various visualization libraries, data processing tools, and machine learning frameworks seamlessly.
2. **Interactive Computing**: ```Xeus``` enhances the interactivity of Jupyter notebooks. It allows you to work with multiple programming languages like C++, Python, and more, offering a broader spectrum for interactive coding and data analysis.
#### Cons:
1. **Resource Consumption**: Due to its support for languages like C++, which can be resource-intensive, ```Xeus``` might require more computational resources. If you're working on a less powerful machine, this can be a drawback.

!!! ### MicroPython
- [GitHub](https://github.com/micropython/micropython)
- [Main site](https://micropython.org/)
- [Documentation](https://docs.micropython.org/en/latest/)
- [Discord](https://discord.com/invite/RB8HZSAExQ)

MicroPython is a wonderful tool for lightweight, power-efficient, and compact implementation of the Python 3 programming language, designed to run on microcontrollers and constrained environments, allowing developers to program embedded systems with Python.
#### Pros:
1. **Lightweight**: MicroPython is compact, designed to run on devices with limited memory and processing power. It's the perfect fit for IoT gadgets, sensors, and microcontrollers.
#### Cons:
1. **Limited Libraries**: While MicroPython has a rich library ecosystem, it's not as extensive as regular Python. Some libraries and modules you're accustomed to may be absent, so you may need to build custom solutions for certain tasks.
2. **Less Computing Power**: MicroPython's main aim is to run on resource-constrained devices. This means it won't perform as well as full Python on more capable hardware.

!!! ### Pythonnet
- [GitHub](https://github.com/pythonnet/pythonnet)
- [Main site](http://pythonnet.github.io/)
- [Documentation](https://pythonnet.github.io/pythonnet/)

Python.NET is a package that gives Python programmers nearly seamless integration with the .NET Common Language Runtime (CLR) and provides a powerful application scripting tool for .NET developers. It allows Python code to interact with the CLR, and may also be used to embed Python into a .NET application making it possible to use Python scripting and libraries alongside C# or other .NET languages, enhancing the flexibility and capabilities of .NET applications.
#### Pros:
1. **Interoperability**: Pythonnet offers seamless interoperability between Python and .NET languages like C# and F#. This means you can use Python in your existing .NET projects, leveraging Python's rich ecosystem of libraries.
2. **Cross-Platform**: Pythonnet is cross-platform, which means you can develop applications that run on Windows, macOS, and Linux. This flexibility is incredibly valuable for businesses targeting a wide range of users.
#### Cons:
1. 

### Ironpython
- [GitHub](https://github.com/IronLanguages/ironpython3)
- [Main site](https://ironpython.net/)
- [Documentation](https://ironpython.net/documentation/)

IronPython is an open-source implementation of the Python programming language that is tightly integrated with .NET. IronPython can use .NET and Python libraries, and other .NET languages can use Python code just as easily.
#### Pros:
1. **Compatibility with .NET**: IronPython is a Python interpreter built for the .NET platform. This means it seamlessly integrates with .NET applications, libraries, and frameworks. It's great for scenarios where you need to use Python alongside C# or other .NET languages.
2. **Strong Type System**: Python is known for its dynamic typing, but IronPython allows you to work with a more rigid type system if your project demands it. This can make your code more reliable in certain situations.
3. **Speed and Performance**: IronPython often performs better than ```CPython``` in some scenarios, especially when it comes to multi-threading and handling large datasets. This makes it a suitable choice for performance-critical applications.
#### Cons:
1. **Limited Standard Library**: One of the downsides of IronPython is that its standard library is not as extensive as ```CPython```'s. This means that you might need to rely more heavily on .NET libraries and may occasionally face compatibility issues with Python packages.
2. **Compatibility with C Extensions**: ```CPython``` has a vast ecosystem of C-based extensions, and IronPython is not compatible with these. If your project relies on such extensions, you might face challenges.: ```CPython``` has a vast ecosystem of C-based extensions, and IronPython is not compatible with these. If your project relies on such extensions, you might face challenges.
3. **Not the Python Reference Implementation**: Since IronPython is not the reference implementation of Python, it may not be suitable for scenarios where strict adherence to the Python language specification is required.

!!! ### Stackless
- [GitHub](https://github.com/stackless-dev/stackless/tree/main-slp/Stackless)
- [Main site](http://www.stackless.com)
- [Documentation](https://stackless.readthedocs.io/en/3.7-slp/stackless-python.html)
- [Wiki](https://github.com/stackless-dev/stackless/wiki/)

Stackless Python is an enhanced version of the Python programming language that provides a lightweight, efficient way to work with concurrency and microthreads, allowing tasks to be managed without the overhead of traditional threads or processes. It enables more flexible and efficient multitasking in Python programs.
#### Pros:
1. **Microthreads**: Stackless is designed to support microthreads, also known as tasklets. These are lightweight and allow for concurrent execution without the overhead of traditional threads. In practical terms, this means you can efficiently handle thousands of tasks concurrently.
2. **Improved Concurrency**: Stackless Python has a built-in scheduling mechanism for tasklets. This simplifies concurrent programming compared to the Global Interpreter Lock (GIL) in ```CPython```. It's a great choice for applications that need to handle many tasks concurrently, such as network servers.
3. **Cooperative Multitasking**: Unlike traditional operating system threads, Stackless uses cooperative multitasking. This means tasks willingly yield control to others when they're waiting for I/O or other events. This can lead to more predictable and efficient task scheduling.
4. **Enhanced Performance**: For certain types of applications, especially those requiring high concurrency, Stackless can deliver better performance than ```CPython```. This is because it avoids the overhead associated with threads and the GIL.
#### Cons:
1. **Compatibility**: Stackless Python may not be fully compatible with all Python libraries and frameworks. This can be an issue if your project relies on third-party packages that are not adapted for Stackless Python.

!!! ### Cinder
- [GitHub](https://github.com/facebookincubator/cinder)

Cinder is Meta's internal performance-oriented production version of ```CPython``` 3.10. It contains a number of performance optimizations, including bytecode inline caching, eager evaluation of coroutines, a method-at-a-time JIT, and an experimental bytecode compiler that uses type annotations to emit type-specialized bytecode that performs better in the JIT. Cinder is powering Instagram, where it started, and is increasingly used across more and more Python applications in Meta.

!!! ### Pyodide
- [GitHub](https://github.com/pyodide/pyodide)
- [Documentation](https://pyodide.org/en/stable/)
- [Try in your browser](https://pyodide.org/en/stable/console.html) on any device

```Pyodide``` is a Python distribution for the browser and Node.js based on WebAssembly. Pyodide makes it possible to install and run Python packages in the browser with micropip. Any pure Python package with a wheel available on PyPi is supported. Many packages with C extensions have also been ported for use with Pyodide. These include many general-purpose packages such as regex, PyYAML, lxml and scientific Python packages including NumPy, pandas, SciPy, Matplotlib, and scikit-learn. Pyodide comes with a robust Javascript ⟺ Python foreign function interface so that you can freely mix these two languages in your code with minimal friction. This includes full support for error handling, async/await, and much more. When used inside a browser, Python has full access to the Web APIs.
#### Pros:
1. **Python in the Browser**: Pyodide allows you to run Python in your web browser. No need to install Python separately on your machine; it's right there in your browser. This is like carrying your Python environment with you, accessible from anywhere.
2. **Versatility**: Pyodide is versatile; it supports many Python libraries. You can do everything from data analysis with Pandas to visualization with Matplotlib right in your browser.
#### Cons:
1. **Browser Limitations**: The browser environment has limitations. It might not support every Python library, especially those that rely on C extensions or require direct access to the system. So, you might not be able to do everything you can in a standard Python environment.
2. **Performance**: Although Pyodide is impressive, it may not be as performant as a locally installed Python interpreter. For heavy computations or large datasets, you might notice a difference in speed.
3. **Internet Connection**: Internet is required to run Pyodide.

!!! ### Brython
- [GitHub](https://github.com/brython-dev/brython)
- [Main site](https://brython.info/)
- [Documentation](https://brython.info/static_doc/3.12/en/intro.html)
- [Wiki](https://github.com/brython-dev/brython/wiki/)
- [Try in your browser](https://brython.info/tests/editor.html) on any device
- [Try in your browser with console](https://brython.info/tests/console.html?lang=en) on any device

Brython (Browser Python) is a Python interpreter that allows you to run Python code directly in a web browser, enabling client-side scripting using Python for web applications. Brython is designed to replace Javascript as the scripting language for the Web. As such, it is a Python 3 implementation, adapted to the HTML5 environment, that is to say with an interface to the DOM objects and events.
#### Pros:
1. **Python in the Browser**: With Brython, you can write Python code that executes directly in a web browser. This is incredibly convenient if you're a Python developer and want to create web applications.
2. **Seamless Integration**: It's a great choice when your backend is also Python. You can share code and logic between the front-end and back-end, simplifying development.
3. **Client-side**: You can create dynamic web pages without the need for a server. This makes Brython suitable for applications that require quick client-side updates.
#### Cons:
1. **Limited Libraries**: Brython doesn't support all Python libraries due to the constraints of running in a web browser. You might miss out on some powerful Python modules.
2. **Performance**: While it's fast for a browser-based Python interpreter, it can't match the execution speed of JavaScript. So, for performance-critical applications, you might need to rely on JavaScript.

So, while ```CPython``` is the go-to interpreter for most Python developers due to its reliability and performance, you might consider other interpreters like ```PyPy``` or Jython if you have specific requirements. The beauty of Python is that you can choose the right interpreter for your needs.

## Results Analytics
Show here the results of the computations.
Provide comparison between results of the interpreters.
Make the conclusion of the comparison

## Usage

Explain how users can use your project. Provide code examples or usage scenarios if applicable.

## Contributing

If you're open to contributions, explain how others can contribute to your project. Include guidelines for reporting bugs, suggesting features, and submitting pull requests.

## License

This project is licensed under the [License Name] License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

Mention any contributors, libraries, or tools that you want to acknowledge or give credit to.

