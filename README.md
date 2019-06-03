# Wolfram Python Package Manager

Wolfram Language functions to facilitate the management of Python packages (uses pip)

## Installation

To install, run the following code:
```
PacletInstall["https://github.com/arnoudbuzing/wolfram-python-package-manager/releases/download/v0.0.1/PythonPackageManager-0.0.1.paclet"]
```

You can check the following page for more recent releases:

https://github.com/arnoudbuzing/wolfram-python-package-manager/releases

Quit the Wolfram kernel and restart it

## Examples

Get the version of your Python installation (e.g. `python --version`):

```
In[1]:= PythonVersion[]

Out[1]= Python 3.6.8
```

Get the version of your Python Package manager (e.g. `pip --version`):

```
In[2]:= PythonPackageVersion[]

Out[2]= pip 19.1.1 from C:\Users\arnoudb.WRI\AppData\Local\Programs\Python\Python36\lib\site-packages\pip (python 3.6)
```

Get information on a Python package (e.g. `pip show <name>`):

```
In[3]:= PythonPackageInformation["pyzmq"]

Out[3]= <|Name -> pyzmq, Version -> 17.1.2, Summary -> Python bindings for 0MQ, Home-page -> https://pyzmq.readthedocs.org, Author -> Brian E. Granger, Min Ragan-Kelley, Author-email -> zeromq-dev@lists.zeromq.org, License -> LGPL+BSD, Location -> c:\users\arnoudb.wri\appdata\local\programs\python\python36\lib\site-packages, Requires -> , Required-by -> zmq, notebook, jupyter-client|>
```

List all installed Python packages (e.g. `pip list`):

```
In[4]:= PythonPackageList[]

Out[4]= <|accelasc -> 1.0.3, aiohttp -> 3.5.4, aiowolfram -> 1.0.3, async-timeout -> 3.0.1, attrs -> 19.1.0, backcall -> 0.1.0, betabernsum -> 0.0.25, bleach -> 3.1.0, certifi -> 2019.3.9, chardet -> 3.0.4, colorama -> 0.4.1, cvxpy -> 1.0.22, cycler -> 0.10.0, decorator -> 4.4.0, defusedxml -> 0.5.0, dill -> 0.2.9, ecos -> 2.0.7.post1, entrypoints -> 0.3, future -> 0.17.1, idna -> 2.8, idna-ssl -> 1.1.0, ipykernel -> 5.1.0, ipython -> 7.4.0, ipython-genutils -> 0.2.0, ipywidgets -> 7.4.2, jedi -> 0.13.3, Jinja2 -> 2.10, jsonschema -> 3.0.1, jupyter -> 1.0.0, jupyter-client -> 5.2.4, jupyter-console -> 6.0.0, jupyter-core -> 4.4.0, kiwisolver -> 1.1.0, logomaker -> 0.8, MarkupSafe -> 1.1.1, matplotlib -> 3.0.3, mistune -> 0.8.4, multidict -> 4.5.2, multiprocess -> 0.70.7, nbconvert -> 5.4.1, nbformat -> 4.4.0, networkx -> 2.3, notebook -> 5.7.8, numpy -> 1.15.4, oauthlib -> 3.0.1, osqp -> 0.5.0, pandas -> 0.24.2, pandocfilters -> 1.4.2, parso -> 0.3.4, pickleshare -> 0.7.5, Pillow -> 5.4.1, pip -> 19.1.1, prometheus-client -> 0.6.0, prompt-toolkit -> 2.0.9, Pygments -> 2.3.1, pygments-mathematica -> 0.3.4, pyparsing -> 2.4.0, pyrsistent -> 0.14.11, python-dateutil -> 2.8.0, pytz -> 2018.9, pywinpty -> 0.5.5, pyzmq -> 17.1.2, qtconsole -> 4.4.3, requests -> 2.21.0, scipy -> 1.2.1, scs -> 2.1.0, Send2Trash -> 1.5.0, setuptools -> 40.6.2, six -> 1.12.0, spectral -> 0.19, terminado -> 0.8.2, testpath -> 0.4.2, tornado -> 6.0.2, traitlets -> 4.3.2, typing-extensions -> 3.7.2, urllib3 -> 1.24.2, wcwidth -> 0.1.7, webencodings -> 0.5.1, widgetsnbextension -> 3.4.2, wolframclient -> 1.0.2, wolframwebengine -> 1.0.0, yarl -> 1.3.0, zmq -> 0.0.0|>
```

Install a Python package (e.g. `pip install <name>`):

```
In[5]:= PythonPackageInstall["aiowolfram"]

Out[5]= Success[InstallationComplete, <|MessageTemplate :> The installation of "`name`" is complete., MessageParameters -> <|name -> aiowolfram|>|>]
```

Uninstall a Python package (e.g. `pip uninstall <name>`):

```
In[6]:= PythonPackageUninstall["aiowolfram"]

Out[6]= Success[UninstallationComplete, <|MessageTemplate :> The uninstallation of "`name`" is complete., MessageParameters -> <|name -> aiowolfram|>|>]
```
