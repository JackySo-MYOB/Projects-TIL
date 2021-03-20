## Devops python development practice - Virtual environment, DevOps practice, pyforest and Pre-commit check for Python coding

### Make routines

```bash
$ make

 Choose a command run:

var                                      Show all defined variables
blog-howto                               Medium - Transform Your Favorite Python IDE Into a DevOps Tool
fetch-github                             Git clone to $(REPO) - DevOps Tool codes
pip-install-choice                       Pick requirements.txt to PIP install
pip-install                              PIP install $(PIP) in virtual environment
pip-install-requirements                 PIP install $(PIP) in virtual environment
pre-commit                               Setup pre-commit
hello-venv                               Python run src/main.py in virtual environment
devops-venv                              Python run devops.py in virtual environment
readme                                   Read github-repo README.md
branch2main                              Merge branch to main
```

### Virtual environment

#### Sample python development in virutal environment - src-hello/hello.py

```bash
$ make hello-venv
./.venv/bin/pip install -r requirements.txt
Requirement already satisfied: black in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 1)) (20.8b1)
Requirement already satisfied: mypy in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 2)) (0.812)
Collecting pre-commit
  Using cached pre_commit-2.11.1-py2.py3-none-any.whl (187 kB)
Requirement already satisfied: console in ./.venv/lib/python3.8/site-packages (from -r requirements.txt (line 2)) (0.9906)
Requirement already satisfied: pyfiglet in ./.venv/lib/python3.8/site-packages (from -r requirements.txt (line 3)) (0.8.post1)
Requirement already satisfied: regex>=2020.1.8 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (2020.11.13)
Requirement already satisfied: typed-ast>=1.4.0 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (1.4.2)
Requirement already satisfied: click>=7.1.2 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (7.1.2)
Requirement already satisfied: mypy-extensions>=0.4.3 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (0.4.3)
Requirement already satisfied: toml>=0.10.1 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (0.10.2)
Requirement already satisfied: pathspec<1,>=0.6 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (0.8.1)
Requirement already satisfied: appdirs in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (1.4.4)
Requirement already satisfied: typing-extensions>=3.7.4 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (3.7.4.3)
Requirement already satisfied: ezenv>=0.92 in ./.venv/lib/python3.8/site-packages (from console->-r requirements.txt (line 2)) (0.92)
Collecting identify>=1.0.0
  Using cached identify-2.1.3-py2.py3-none-any.whl (98 kB)
Collecting cfgv>=2.0.0
  Using cached cfgv-3.2.0-py2.py3-none-any.whl (7.3 kB)
Collecting nodeenv>=0.11.1
  Using cached nodeenv-1.5.0-py2.py3-none-any.whl (21 kB)
Collecting virtualenv>=20.0.8
  Using cached virtualenv-20.4.2-py2.py3-none-any.whl (7.2 MB)
Collecting pyyaml>=5.1
  Using cached PyYAML-5.4.1-cp38-cp38-manylinux1_x86_64.whl (662 kB)
Collecting filelock<4,>=3.0.0
  Using cached filelock-3.0.12-py3-none-any.whl (7.6 kB)
Collecting distlib<1,>=0.3.1
  Using cached distlib-0.3.1-py2.py3-none-any.whl (335 kB)
Requirement already satisfied: six<2,>=1.9.0 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit->-r requirements.txt.makefile (line 3)) (1.15.0)
Installing collected packages: filelock, distlib, virtualenv, pyyaml, nodeenv, identify, cfgv, pre-commit
Successfully installed cfgv-3.2.0 distlib-0.3.1 filelock-3.0.12 identify-2.1.3 nodeenv-1.5.0 pre-commit-2.11.1 pyyaml-5.4.1 virtualenv-20.4.2
touch ./.venv/bin/.initialized-with-Makefile.venv
./.venv/bin/python src-hello/hello.py



##     ##        ##            ### ## ##
###   ###        ##           ##      ##
###   ###  ###   ## ##   ###  ###  ## ##  ###    ## ##  ###  # ##  ## ##
#### #### #  ##  ####   ## ## ##   ## ## ## ##   ## ## ## ## ## ## ## ##
## # # ##  ####  ###    ##### ##   ## ## #####   ## ## ##### ## ## ## ##
## ### ## ## ##  ####   ##    ##   ## ## ##       # #  ##    ## ##  # #
##  #  ## ## ##  ## ##  ## ## ##   ## ## ## ## #  ###  ## ## ## ##  ###
##  #  ##  ## ## ##  ##  ###  ##   ## ##  ###  #   #    ###  ## ##   #



```

### Devops practices

#### Sample run - make devops-venv

```bash

$  make devops-venv
./.venv/bin/pip install -r requirements.txt.devops
Requirement already satisfied: black in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 1)) (20.8b1)
Requirement already satisfied: mypy in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 2)) (0.812)
Requirement already satisfied: flake8 in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 3)) (3.9.0)
Requirement already satisfied: pre-commit in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 4)) (2.11.1)
Requirement already satisfied: numpy==1.19.2 in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.devops (line 2)) (1.19.2)
Requirement already satisfied: numba==0.51.2 in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.devops (line 3)) (0.51.2)
Requirement already satisfied: matplotlib==3.3.2 in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.devops (line 4)) (3.3.2)
Requirement already satisfied: diagrams==0.17.0 in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.devops (line 5)) (0.17.0)
Requirement already satisfied: colorama in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.devops (line 6)) (0.4.4)
Requirement already satisfied: coverage in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.devops (line 7)) (5.5)
Requirement already satisfied: pytest==6.2.2 in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.devops (line 8)) (6.2.2)
Requirement already satisfied: pylint in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.devops (line 9)) (2.7.2)
Requirement already satisfied: profiling in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.devops (line 10)) (0.1.3)
Requirement already satisfied: line-profiler in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.devops (line 11)) (3.1.0)
Requirement already satisfied: jinja2<3.0,>=2.10 in ./.venv/lib/python3.8/site-packages (from diagrams==0.17.0->-r requirements.txt.devops (line 5)) (2.11.3)
Requirement already satisfied: graphviz<0.14.0,>=0.13.2 in ./.venv/lib/python3.8/site-packages (from diagrams==0.17.0->-r requirements.txt.devops (line 5)) (0.13.2)
Requirement already satisfied: python-dateutil>=2.1 in ./.venv/lib/python3.8/site-packages (from matplotlib==3.3.2->-r requirements.txt.devops (line 4)) (2.8.1)
Requirement already satisfied: cycler>=0.10 in ./.venv/lib/python3.8/site-packages (from matplotlib==3.3.2->-r requirements.txt.devops (line 4)) (0.10.0)
Requirement already satisfied: kiwisolver>=1.0.1 in ./.venv/lib/python3.8/site-packages (from matplotlib==3.3.2->-r requirements.txt.devops (line 4)) (1.3.1)
Requirement already satisfied: pillow>=6.2.0 in ./.venv/lib/python3.8/site-packages (from matplotlib==3.3.2->-r requirements.txt.devops (line 4)) (8.1.2)
Requirement already satisfied: certifi>=2020.06.20 in ./.venv/lib/python3.8/site-packages (from matplotlib==3.3.2->-r requirements.txt.devops (line 4)) (2020.12.5)
Requirement already satisfied: pyparsing!=2.0.4,!=2.1.2,!=2.1.6,>=2.0.3 in ./.venv/lib/python3.8/site-packages (from matplotlib==3.3.2->-r requirements.txt.devops (line 4)) (2.4.7)
Requirement already satisfied: setuptools in ./.venv/lib/python3.8/site-packages (from numba==0.51.2->-r requirements.txt.devops (line 3)) (54.1.2)
Requirement already satisfied: llvmlite<0.35,>=0.34.0.dev0 in ./.venv/lib/python3.8/site-packages (from numba==0.51.2->-r requirements.txt.devops (line 3)) (0.34.0)
Requirement already satisfied: py>=1.8.2 in ./.venv/lib/python3.8/site-packages (from pytest==6.2.2->-r requirements.txt.devops (line 8)) (1.10.0)
Requirement already satisfied: attrs>=19.2.0 in ./.venv/lib/python3.8/site-packages (from pytest==6.2.2->-r requirements.txt.devops (line 8)) (20.3.0)
Requirement already satisfied: pluggy<1.0.0a1,>=0.12 in ./.venv/lib/python3.8/site-packages (from pytest==6.2.2->-r requirements.txt.devops (line 8)) (0.13.1)
Requirement already satisfied: packaging in ./.venv/lib/python3.8/site-packages (from pytest==6.2.2->-r requirements.txt.devops (line 8)) (20.9)
Requirement already satisfied: iniconfig in ./.venv/lib/python3.8/site-packages (from pytest==6.2.2->-r requirements.txt.devops (line 8)) (1.1.1)
Requirement already satisfied: toml in ./.venv/lib/python3.8/site-packages (from pytest==6.2.2->-r requirements.txt.devops (line 8)) (0.10.2)
Requirement already satisfied: six in ./.venv/lib/python3.8/site-packages (from cycler>=0.10->matplotlib==3.3.2->-r requirements.txt.devops (line 4)) (1.15.0)
Requirement already satisfied: MarkupSafe>=0.23 in ./.venv/lib/python3.8/site-packages (from jinja2<3.0,>=2.10->diagrams==0.17.0->-r requirements.txt.devops (line 5)) (1.1.1)
Requirement already satisfied: typed-ast>=1.4.0 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (1.4.2)
Requirement already satisfied: pathspec<1,>=0.6 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (0.8.1)
Requirement already satisfied: click>=7.1.2 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (7.1.2)
Requirement already satisfied: appdirs in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (1.4.4)
Requirement already satisfied: typing-extensions>=3.7.4 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (3.7.4.3)
Requirement already satisfied: mypy-extensions>=0.4.3 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (0.4.3)
Requirement already satisfied: regex>=2020.1.8 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (2020.11.13)
Requirement already satisfied: mccabe<0.7.0,>=0.6.0 in ./.venv/lib/python3.8/site-packages (from flake8->-r requirements.txt.makefile (line 3)) (0.6.1)
Requirement already satisfied: pyflakes<2.4.0,>=2.3.0 in ./.venv/lib/python3.8/site-packages (from flake8->-r requirements.txt.makefile (line 3)) (2.3.0)
Requirement already satisfied: pycodestyle<2.8.0,>=2.7.0 in ./.venv/lib/python3.8/site-packages (from flake8->-r requirements.txt.makefile (line 3)) (2.7.0)
Requirement already satisfied: IPython in ./.venv/lib/python3.8/site-packages (from line-profiler->-r requirements.txt.devops (line 11)) (7.21.0)
Requirement already satisfied: pyyaml>=5.1 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (5.4.1)
Requirement already satisfied: virtualenv>=20.0.8 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (20.4.2)
Requirement already satisfied: cfgv>=2.0.0 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (3.2.0)
Requirement already satisfied: nodeenv>=0.11.1 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (1.5.0)
Requirement already satisfied: identify>=1.0.0 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (2.1.3)
Requirement already satisfied: distlib<1,>=0.3.1 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit->-r requirements.txt.makefile (line 4)) (0.3.1)
Requirement already satisfied: filelock<4,>=3.0.0 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit->-r requirements.txt.makefile (line 4)) (3.0.12)
Requirement already satisfied: click-default-group>=1.2 in ./.venv/lib/python3.8/site-packages (from profiling->-r requirements.txt.devops (line 10)) (1.2.2)
Requirement already satisfied: urwid>=1.2.1 in ./.venv/lib/python3.8/site-packages (from profiling->-r requirements.txt.devops (line 10)) (2.1.2)
Requirement already satisfied: valuedispatch>=0.0.1 in ./.venv/lib/python3.8/site-packages (from profiling->-r requirements.txt.devops (line 10)) (0.0.1)
Requirement already satisfied: isort<6,>=4.2.5 in ./.venv/lib/python3.8/site-packages (from pylint->-r requirements.txt.devops (line 9)) (5.7.0)
Requirement already satisfied: astroid<2.6,>=2.5.1 in ./.venv/lib/python3.8/site-packages (from pylint->-r requirements.txt.devops (line 9)) (2.5.1)
Requirement already satisfied: wrapt<1.13,>=1.11 in ./.venv/lib/python3.8/site-packages (from astroid<2.6,>=2.5.1->pylint->-r requirements.txt.devops (line 9)) (1.12.1)
Requirement already satisfied: lazy-object-proxy>=1.4.0 in ./.venv/lib/python3.8/site-packages (from astroid<2.6,>=2.5.1->pylint->-r requirements.txt.devops (line 9)) (1.5.2)
Requirement already satisfied: jedi>=0.16 in ./.venv/lib/python3.8/site-packages (from IPython->line-profiler->-r requirements.txt.devops (line 11)) (0.18.0)
Requirement already satisfied: decorator in ./.venv/lib/python3.8/site-packages (from IPython->line-profiler->-r requirements.txt.devops (line 11)) (4.4.2)
Requirement already satisfied: pickleshare in ./.venv/lib/python3.8/site-packages (from IPython->line-profiler->-r requirements.txt.devops (line 11)) (0.7.5)
Requirement already satisfied: prompt-toolkit!=3.0.0,!=3.0.1,<3.1.0,>=2.0.0 in ./.venv/lib/python3.8/site-packages (from IPython->line-profiler->-r requirements.txt.devops (line 11)) (3.0.17)
Requirement already satisfied: backcall in ./.venv/lib/python3.8/site-packages (from IPython->line-profiler->-r requirements.txt.devops (line 11)) (0.2.0)
Requirement already satisfied: pygments in ./.venv/lib/python3.8/site-packages (from IPython->line-profiler->-r requirements.txt.devops (line 11)) (2.8.1)
Requirement already satisfied: pexpect>4.3 in ./.venv/lib/python3.8/site-packages (from IPython->line-profiler->-r requirements.txt.devops (line 11)) (4.8.0)
Requirement already satisfied: traitlets>=4.2 in ./.venv/lib/python3.8/site-packages (from IPython->line-profiler->-r requirements.txt.devops (line 11)) (5.0.5)
Requirement already satisfied: parso<0.9.0,>=0.8.0 in ./.venv/lib/python3.8/site-packages (from jedi>=0.16->IPython->line-profiler->-r requirements.txt.devops (line 11)) (0.8.1)
Requirement already satisfied: ptyprocess>=0.5 in ./.venv/lib/python3.8/site-packages (from pexpect>4.3->IPython->line-profiler->-r requirements.txt.devops (line 11)) (0.7.0)
Requirement already satisfied: wcwidth in ./.venv/lib/python3.8/site-packages (from prompt-toolkit!=3.0.0,!=3.0.1,<3.1.0,>=2.0.0->IPython->line-profiler->-r requirements.txt.devops (line 11)) (0.2.5)
Requirement already satisfied: ipython-genutils in ./.venv/lib/python3.8/site-packages (from traitlets>=4.2->IPython->line-profiler->-r requirements.txt.devops (line 11)) (0.2.0)
exec ./.venv/bin/python devops.py

Executing devops step( 1 ):  make -s black

stdout:  Requirement already satisfied: black in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 1)) (20.8b1)
Requirement already satisfied: mypy in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 2)) (0.812)
Requirement already satisfied: flake8 in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 3)) (3.9.0)
Requirement already satisfied: pre-commit in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 4)) (2.11.1)
Requirement already satisfied: typing-extensions>=3.7.4 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (3.7.4.3)
Requirement already satisfied: appdirs in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (1.4.4)
Requirement already satisfied: typed-ast>=1.4.0 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (1.4.2)
Requirement already satisfied: regex>=2020.1.8 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (2020.11.13)
Requirement already satisfied: pathspec<1,>=0.6 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (0.8.1)
Requirement already satisfied: click>=7.1.2 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (7.1.2)
Requirement already satisfied: mypy-extensions>=0.4.3 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (0.4.3)
Requirement already satisfied: toml>=0.10.1 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (0.10.2)
Requirement already satisfied: mccabe<0.7.0,>=0.6.0 in ./.venv/lib/python3.8/site-packages (from flake8->-r requirements.txt.makefile (line 3)) (0.6.1)
Requirement already satisfied: pycodestyle<2.8.0,>=2.7.0 in ./.venv/lib/python3.8/site-packages (from flake8->-r requirements.txt.makefile (line 3)) (2.7.0)
Requirement already satisfied: pyflakes<2.4.0,>=2.3.0 in ./.venv/lib/python3.8/site-packages (from flake8->-r requirements.txt.makefile (line 3)) (2.3.0)
Requirement already satisfied: cfgv>=2.0.0 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (3.2.0)
Requirement already satisfied: identify>=1.0.0 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (2.1.3)
Requirement already satisfied: pyyaml>=5.1 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (5.4.1)
Requirement already satisfied: virtualenv>=20.0.8 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (20.4.2)
Requirement already satisfied: nodeenv>=0.11.1 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (1.5.0)
Requirement already satisfied: distlib<1,>=0.3.1 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit->-r requirements.txt.makefile (line 4)) (0.3.1)
Requirement already satisfied: six<2,>=1.9.0 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit->-r requirements.txt.makefile (line 4)) (1.15.0)
Requirement already satisfied: filelock<4,>=3.0.0 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit->-r requirements.txt.makefile (line 4)) (3.0.12)

 stderr:  tests/.DS_Store ignored: matches the .gitignore file content
/home1/jso/myob-work/work/aws-cf/git-repo/project-resources/resources/devops/makefile/devops-venv/tests/__init__.py wasn't modified on disk since last run.
/home1/jso/myob-work/work/aws-cf/git-repo/project-resources/resources/devops/makefile/devops-venv/tests/test_src.py wasn't modified on disk since last run.
All done! ✨ 🍰 ✨
2 files left unchanged.

 yes! :Pass Go!!!

Executing devops step( 2 ):  make -s mypy

stdout:  Requirement already satisfied: black in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 1)) (20.8b1)
Requirement already satisfied: mypy in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 2)) (0.812)
Requirement already satisfied: flake8 in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 3)) (3.9.0)
Requirement already satisfied: pre-commit in ./.venv/lib/python3.8/site-packages (from -r requirements.txt.makefile (line 4)) (2.11.1)
Requirement already satisfied: appdirs in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (1.4.4)
Requirement already satisfied: typed-ast>=1.4.0 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (1.4.2)
Requirement already satisfied: mypy-extensions>=0.4.3 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (0.4.3)
Requirement already satisfied: click>=7.1.2 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (7.1.2)
Requirement already satisfied: regex>=2020.1.8 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (2020.11.13)
Requirement already satisfied: pathspec<1,>=0.6 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (0.8.1)
Requirement already satisfied: toml>=0.10.1 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (0.10.2)
Requirement already satisfied: typing-extensions>=3.7.4 in ./.venv/lib/python3.8/site-packages (from black->-r requirements.txt.makefile (line 1)) (3.7.4.3)
Requirement already satisfied: pycodestyle<2.8.0,>=2.7.0 in ./.venv/lib/python3.8/site-packages (from flake8->-r requirements.txt.makefile (line 3)) (2.7.0)
Requirement already satisfied: pyflakes<2.4.0,>=2.3.0 in ./.venv/lib/python3.8/site-packages (from flake8->-r requirements.txt.makefile (line 3)) (2.3.0)
Requirement already satisfied: mccabe<0.7.0,>=0.6.0 in ./.venv/lib/python3.8/site-packages (from flake8->-r requirements.txt.makefile (line 3)) (0.6.1)
Requirement already satisfied: nodeenv>=0.11.1 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (1.5.0)
Requirement already satisfied: identify>=1.0.0 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (2.1.3)
Requirement already satisfied: cfgv>=2.0.0 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (3.2.0)
Requirement already satisfied: virtualenv>=20.0.8 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (20.4.2)
Requirement already satisfied: pyyaml>=5.1 in ./.venv/lib/python3.8/site-packages (from pre-commit->-r requirements.txt.makefile (line 4)) (5.4.1)
Requirement already satisfied: six<2,>=1.9.0 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit->-r requirements.txt.makefile (line 4)) (1.15.0)
Requirement already satisfied: filelock<4,>=3.0.0 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit->-r requirements.txt.makefile (line 4)) (3.0.12)
Requirement already satisfied: distlib<1,>=0.3.1 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit->-r requirements.txt.makefile (line 4)) (0.3.1)
Success: no issues found in 2 source files

 stderr:
 yes! :Pass Go!!!

Executing devops step( 3 ):  pylint src -E -v

stdout:
 stderr:
 yes! :Pass Go!!!

Executing devops step( 4 ):  pytest -v tests

stdout:  ============================= test session starts ==============================
platform linux -- Python 3.8.5, pytest-6.2.2, py-1.10.0, pluggy-0.13.1 -- /usr/bin/python3
cachedir: .pytest_cache
rootdir: /home1/jso/myob-work/work/aws-cf/git-repo/project-resources/resources/devops/makefile/devops-venv
plugins: cov-2.11.1
collecting ... collected 2 items

tests/test_src.py::test_1 PASSED                                         [ 50%]
tests/test_src.py::test_2 PASSED                                         [100%]

============================== 2 passed in 0.03s ===============================

 stderr:
 yes! :Pass Go!!!

Executing devops step( 5 ):  coverage run -m pytest tests

stdout:  ============================= test session starts ==============================
platform linux -- Python 3.8.5, pytest-6.2.2, py-1.10.0, pluggy-0.13.1
rootdir: /home1/jso/myob-work/work/aws-cf/git-repo/project-resources/resources/devops/makefile/devops-venv
plugins: cov-2.11.1
collected 2 items

tests/test_src.py ..                                                     [100%]

============================== 2 passed in 0.03s ===============================

 stderr:
 yes! :Pass Go!!!

Executing devops step( 6 ):  coverage report

stdout:  Name                                                                                     Stmts   Miss  Cover
------------------------------------------------------------------------------------------------------------
/home1/jso/.local/lib/python3.8/site-packages/_pytest/__init__.py                            5      2    60%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/_argcomplete.py                       37     23    38%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/_code/__init__.py                     10      0   100%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/_code/code.py                        699    450    36%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/_code/source.py                      142    104    27%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/_io/__init__.py                        3      0   100%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/_io/saferepr.py                       67     49    27%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/_io/terminalwriter.py                113     40    65%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/_io/wcwidth.py                        25     11    56%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/_version.py                            2      0   100%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/assertion/__init__.py                 84     25    70%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/assertion/rewrite.py                 624    421    33%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/assertion/truncate.py                 52     40    23%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/assertion/util.py                    294    255    13%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/cacheprovider.py                     314    152    52%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/capture.py                           560    214    62%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/compat.py                            162     70    57%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/config/__init__.py                   806    326    60%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/config/argparsing.py                 253     81    68%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/config/exceptions.py                   4      0   100%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/config/findpaths.py                  127     55    57%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/debugging.py                         228    160    30%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/deprecated.py                         16      1    94%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/doctest.py                           351    244    30%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/faulthandler.py                       64     15    77%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/fixtures.py                          833    500    40%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/freeze_support.py                     22     16    27%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/helpconfig.py                        133     91    32%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/hookspec.py                          113     24    79%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/junitxml.py                          373    275    26%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/logging.py                           402    143    64%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/main.py                              461    167    64%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/mark/__init__.py                     141     70    50%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/mark/expression.py                   124     73    41%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/mark/structures.py                   244    121    50%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/monkeypatch.py                       171    102    40%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/nodes.py                             271     99    63%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/nose.py                               22      2    91%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/outcomes.py                           88     44    50%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/pastebin.py                           70     47    33%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/pathlib.py                           342    199    42%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/pytester.py                          894    626    30%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/python.py                            851    459    46%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/python_api.py                        250    172    31%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/recwarn.py                           127     80    37%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/reports.py                           279    161    42%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/runner.py                            299     92    69%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/setuponly.py                          56     34    39%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/setupplan.py                          24      7    71%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/skipping.py                          178     98    45%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/stepwise.py                           68     39    43%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/store.py                              34      5    85%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/terminal.py                          897    427    52%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/threadexception.py                    44      7    84%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/timing.py                              4      0   100%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/tmpdir.py                            106     44    58%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/unittest.py                          243    172    29%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/unraisableexception.py                44      7    84%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/warning_types.py                      49      2    96%
/home1/jso/.local/lib/python3.8/site-packages/_pytest/warnings.py                           63      8    87%
/home1/jso/.local/lib/python3.8/site-packages/iniconfig/__init__.py                        122     99    19%
/home1/jso/.local/lib/python3.8/site-packages/pluggy/__init__.py                             8      2    75%
/home1/jso/.local/lib/python3.8/site-packages/pluggy/_tracing.py                            41     17    59%
/home1/jso/.local/lib/python3.8/site-packages/pluggy/_version.py                             1      0   100%
/home1/jso/.local/lib/python3.8/site-packages/pluggy/callers.py                            125     68    46%
/home1/jso/.local/lib/python3.8/site-packages/pluggy/hooks.py                              175     40    77%
/home1/jso/.local/lib/python3.8/site-packages/pluggy/manager.py                            196     81    59%
/home1/jso/.local/lib/python3.8/site-packages/py/__init__.py                                14      6    57%
/home1/jso/.local/lib/python3.8/site-packages/py/_builtin.py                               112     78    30%
/home1/jso/.local/lib/python3.8/site-packages/py/_code/__init__.py                           0      0   100%
/home1/jso/.local/lib/python3.8/site-packages/py/_code/code.py                             531    408    23%
/home1/jso/.local/lib/python3.8/site-packages/py/_error.py                                  52     35    33%
/home1/jso/.local/lib/python3.8/site-packages/py/_path/__init__.py                           0      0   100%
/home1/jso/.local/lib/python3.8/site-packages/py/_path/common.py                           277    159    43%
/home1/jso/.local/lib/python3.8/site-packages/py/_path/local.py                            694    513    26%
/home1/jso/.local/lib/python3.8/site-packages/py/_vendored_packages/__init__.py              0      0   100%
/home1/jso/.local/lib/python3.8/site-packages/py/_vendored_packages/apipkg/__init__.py     152     55    64%
/home1/jso/.local/lib/python3.8/site-packages/py/_vendored_packages/apipkg/version.py        1      0   100%
/home1/jso/.local/lib/python3.8/site-packages/py/_version.py                                 1      0   100%
/home1/jso/.local/lib/python3.8/site-packages/pytest/__init__.py                            60      0   100%
/home1/jso/.local/lib/python3.8/site-packages/pytest/__main__.py                             3      0   100%
/home1/jso/.local/lib/python3.8/site-packages/pytest/collect.py                             21      5    76%
/home1/jso/.local/lib/python3.8/site-packages/pytest_cov/__init__.py                         1      0   100%
/home1/jso/.local/lib/python3.8/site-packages/pytest_cov/compat.py                          21      7    67%
/home1/jso/.local/lib/python3.8/site-packages/pytest_cov/embed.py                           80     62    22%
/home1/jso/.local/lib/python3.8/site-packages/pytest_cov/plugin.py                         209    145    31%
tests/__init__.py                                                                            0      0   100%
tests/test_src.py                                                                            4      0   100%
/usr/lib/python3/dist-packages/attr/__init__.py                                             22      0   100%
/usr/lib/python3/dist-packages/attr/_compat.py                                              82     41    50%
/usr/lib/python3/dist-packages/attr/_config.py                                               9      4    56%
/usr/lib/python3/dist-packages/attr/_funcs.py                                               79     68    14%
/usr/lib/python3/dist-packages/attr/_make.py                                               694    237    66%
/usr/lib/python3/dist-packages/attr/_version_info.py                                        37     17    54%
/usr/lib/python3/dist-packages/attr/converters.py                                           27     23    15%
/usr/lib/python3/dist-packages/attr/exceptions.py                                           16      4    75%
/usr/lib/python3/dist-packages/attr/filters.py                                              15      9    40%
/usr/lib/python3/dist-packages/attr/validators.py                                          116     54    53%
------------------------------------------------------------------------------------------------------------
TOTAL                                                                                    17360   9388    46%

 stderr:
 yes! :Pass Go!!!

Executing devops step( 7 ):  git checkout -b branch-50f41674-2533-4ca3-bf22-9464afffb931

stdout:
 stderr:  Switched to a new branch 'branch-50f41674-2533-4ca3-bf22-9464afffb931'

 yes! :Pass Go!!!

Executing devops step( 8 ):  git add -A

stdout:
 stderr:
 yes! :Pass Go!!!

Executing devops step( 9 ):  git config user.email "jacky.so@24x7classroom.com"

stdout:
 stderr:
 yes! :Pass Go!!!

Executing devops step( 10 ):  git config user.name "jso"

stdout:
 stderr:
 yes! :Pass Go!!!

Executing devops step( 11 ):  git commit -m "sandbox commit that passesd all local unit tests"

stdout:  [branch-50f41674-2533-4ca3-bf22-9464afffb931 c0dae5b] sandbox commit that passesd all local unit tests
 2 files changed, 80 insertions(+)

 stderr:  [WARNING] The 'rev' field of repo 'https://github.com/ambv/black' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
[WARNING] The 'rev' field of repo 'https://github.com/pre-commit/mirrors-mypy' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
black................................................(no files to check)Skipped
Trim Trailing Whitespace.................................................Passed
Check Yaml...........................................(no files to check)Skipped
Check JSON...........................................(no files to check)Skipped
Flake8...............................................(no files to check)Skipped
Check Toml...........................................(no files to check)Skipped
Check Xml............................................(no files to check)Skipped
mypy.................................................(no files to check)Skipped

 yes! :Pass Go!!!

Executing devops step( 12 ):  git config --list

stdout:  user.email=jacky.so@myob.com
user.name=Jacky So
push.default=simple
http.sslcainfo=/etc/ssl/certs/ca-certificates.crt
http.sslverify=true
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=git@github.com:JackySo-MYOB/devops-venv.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
user.email=jacky.so@24x7classroom.com
user.name=jso
branch.branch-8969bdf6-f56f-4d41-a0d9-3f32679bea80.remote=origin
branch.branch-8969bdf6-f56f-4d41-a0d9-3f32679bea80.merge=refs/heads/branch-8969bdf6-f56f-4d41-a0d9-3f32679bea80
branch.branch-b580dffa-90a1-48d4-b3de-70632217322b.remote=origin
branch.branch-b580dffa-90a1-48d4-b3de-70632217322b.merge=refs/heads/branch-b580dffa-90a1-48d4-b3de-70632217322b
branch.branch-ab761f00-bf75-45e8-9980-815ff3313164.remote=origin
branch.branch-ab761f00-bf75-45e8-9980-815ff3313164.merge=refs/heads/branch-ab761f00-bf75-45e8-9980-815ff3313164
branch.branch-8ade7783-70f0-4e04-a5aa-8696a816fd80.remote=origin
branch.branch-8ade7783-70f0-4e04-a5aa-8696a816fd80.merge=refs/heads/branch-8ade7783-70f0-4e04-a5aa-8696a816fd80
branch.branch-ec7f811f-f2eb-40e5-b115-1ec73183a351.remote=origin
branch.branch-ec7f811f-f2eb-40e5-b115-1ec73183a351.merge=refs/heads/branch-ec7f811f-f2eb-40e5-b115-1ec73183a351
branch.branch-14d4c684-5b9e-4957-b591-0f0f80ad11f3.remote=origin
branch.branch-14d4c684-5b9e-4957-b591-0f0f80ad11f3.merge=refs/heads/branch-14d4c684-5b9e-4957-b591-0f0f80ad11f3
branch.branch-d98139e6-b597-4736-a363-c1bc2d9b7ce2.remote=origin
branch.branch-d98139e6-b597-4736-a363-c1bc2d9b7ce2.merge=refs/heads/branch-d98139e6-b597-4736-a363-c1bc2d9b7ce2
branch.branch-ac6637b2-4352-4bc7-8774-bd6245c42703.remote=origin
branch.branch-ac6637b2-4352-4bc7-8774-bd6245c42703.merge=refs/heads/branch-ac6637b2-4352-4bc7-8774-bd6245c42703
branch.branch-6acd8e7c-e29f-424f-bea0-489857a48f07.remote=origin
branch.branch-6acd8e7c-e29f-424f-bea0-489857a48f07.merge=refs/heads/branch-6acd8e7c-e29f-424f-bea0-489857a48f07
branch.branch-c8dd379f-6492-4fd7-9509-bbc801fb2e58.remote=origin
branch.branch-c8dd379f-6492-4fd7-9509-bbc801fb2e58.merge=refs/heads/branch-c8dd379f-6492-4fd7-9509-bbc801fb2e58
branch.branch-7ffa99cc-c44b-4634-b2d9-b24985a9b710.remote=origin
branch.branch-7ffa99cc-c44b-4634-b2d9-b24985a9b710.merge=refs/heads/branch-7ffa99cc-c44b-4634-b2d9-b24985a9b710
branch.branch-1453c113-d233-4ad2-84a3-19cf478d5446.remote=origin
branch.branch-1453c113-d233-4ad2-84a3-19cf478d5446.merge=refs/heads/branch-1453c113-d233-4ad2-84a3-19cf478d5446
branch.branch-6fe8381c-6e0f-4683-8475-b6acecb53e39.remote=origin
branch.branch-6fe8381c-6e0f-4683-8475-b6acecb53e39.merge=refs/heads/branch-6fe8381c-6e0f-4683-8475-b6acecb53e39
branch.branch-eb237a06-df71-46dd-aa6f-417613c34e05.remote=origin
branch.branch-eb237a06-df71-46dd-aa6f-417613c34e05.merge=refs/heads/branch-eb237a06-df71-46dd-aa6f-417613c34e05
branch.branch-7262786b-2135-4e1b-8c56-85984f448902.remote=origin
branch.branch-7262786b-2135-4e1b-8c56-85984f448902.merge=refs/heads/branch-7262786b-2135-4e1b-8c56-85984f448902
branch.branch-dbfc970f-648a-45ce-9a63-be4bb56dfe52.remote=origin
branch.branch-dbfc970f-648a-45ce-9a63-be4bb56dfe52.merge=refs/heads/branch-dbfc970f-648a-45ce-9a63-be4bb56dfe52
branch.branch-0ab5788b-bc1f-4823-84a3-7133c303493a.remote=origin
branch.branch-0ab5788b-bc1f-4823-84a3-7133c303493a.merge=refs/heads/branch-0ab5788b-bc1f-4823-84a3-7133c303493a

 stderr:
 yes! :Pass Go!!!

Executing devops step( 13 ):  git push -u origin branch-50f41674-2533-4ca3-bf22-9464afffb931

stdout:  Branch 'branch-50f41674-2533-4ca3-bf22-9464afffb931' set up to track remote branch 'branch-50f41674-2533-4ca3-bf22-9464afffb931' from 'origin'.

 stderr:  remote:
remote: Create a pull request for 'branch-50f41674-2533-4ca3-bf22-9464afffb931' on GitHub by visiting:
remote:      https://github.com/JackySo-MYOB/devops-venv/pull/new/branch-50f41674-2533-4ca3-bf22-9464afffb931
remote:
To github.com:JackySo-MYOB/devops-venv.git
 * [new branch]      branch-50f41674-2533-4ca3-bf22-9464afffb931 -> branch-50f41674-2533-4ca3-bf22-9464afffb931

 yes! :Pass Go!!!

Executing devops step( 14 ):  git log --graph --oneline --decorate

stdout:  * c0dae5b (HEAD -> branch-50f41674-2533-4ca3-bf22-9464afffb931, origin/branch-50f41674-2533-4ca3-bf22-9464afffb931) sandbox commit that passesd all local unit tests
* e75111d (origin/branch-dbfc970f-648a-45ce-9a63-be4bb56dfe52, origin/branch-0ab5788b-bc1f-4823-84a3-7133c303493a, branch-dbfc970f-648a-45ce-9a63-be4bb56dfe52, branch-0ab5788b-bc1f-4823-84a3-7133c303493a) sandbox commit that passesd all local unit tests
* 9ee6b19 (origin/branch-ec7f811f-f2eb-40e5-b115-1ec73183a351, origin/branch-eb237a06-df71-46dd-aa6f-417613c34e05, origin/branch-d98139e6-b597-4736-a363-c1bc2d9b7ce2, origin/branch-c8dd379f-6492-4fd7-9509-bbc801fb2e58, origin/branch-ac6637b2-4352-4bc7-8774-bd6245c42703, origin/branch-7ffa99cc-c44b-4634-b2d9-b24985a9b710, origin/branch-7262786b-2135-4e1b-8c56-85984f448902, origin/branch-6fe8381c-6e0f-4683-8475-b6acecb53e39, origin/branch-6acd8e7c-e29f-424f-bea0-489857a48f07, origin/branch-14d4c684-5b9e-4957-b591-0f0f80ad11f3, origin/branch-1453c113-d233-4ad2-84a3-19cf478d5446, branch-ec7f811f-f2eb-40e5-b115-1ec73183a351, branch-eb237a06-df71-46dd-aa6f-417613c34e05, branch-d98139e6-b597-4736-a363-c1bc2d9b7ce2, branch-c8dd379f-6492-4fd7-9509-bbc801fb2e58, branch-ac6637b2-4352-4bc7-8774-bd6245c42703, branch-7ffa99cc-c44b-4634-b2d9-b24985a9b710, branch-7262786b-2135-4e1b-8c56-85984f448902, branch-6fe8381c-6e0f-4683-8475-b6acecb53e39, branch-6acd8e7c-e29f-424f-bea0-489857a48f07, branch-14d4c684-5b9e-4957-b591-0f0f80ad11f3, branch-1453c113-d233-4ad2-84a3-19cf478d5446) sandbox commit that passesd all local unit tests
* 86318f9 (origin/branch-8ade7783-70f0-4e04-a5aa-8696a816fd80, branch-8ade7783-70f0-4e04-a5aa-8696a816fd80) sandbox commit that passesd all local unit tests
* d2af116 (origin/branch-ab761f00-bf75-45e8-9980-815ff3313164, branch-ab761f00-bf75-45e8-9980-815ff3313164) sandbox commit that passesd all local unit tests
* 033f0fa (origin/branch-b580dffa-90a1-48d4-b3de-70632217322b, branch-b580dffa-90a1-48d4-b3de-70632217322b) sandbox commit that passesd all local unit tests
* 30d6f0b (origin/branch-8969bdf6-f56f-4d41-a0d9-3f32679bea80, main, branch-8969bdf6-f56f-4d41-a0d9-3f32679bea80) Check pre-commit for mypc
* a863ed8 Pre-commit test for check-yaml
* 02e45eb (origin/main, origin/HEAD) Add pre-commit
* 1fb0d3f Try pre-commit again after black fixed and reformatted
* 767bca6 (origin/branch-4d6454d9-2ada-465b-a5ae-3c8f4aa6e304) sandbox commit that passesd all local unit tests
* f0c0084 First version
* 556988a first commit

 stderr:
 yes! :Pass Go!!!

```

#### Merge new branch to Main/Master
```bash
$ make branch2main
Switched to branch 'main'
Your branch is ahead of 'origin/main' by 2 commits.
  (use "git push" to publish your local commits)
Updating 30d6f0b..7a8c0a1
Fast-forward
 .coverage                                              | Bin 77824 -> 77824 bytes
 .pre-commit-config.yaml                                |   8 +-
 Makefile                                               |  12 ++
 README.md                                              | 679 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 devops.py                                              |  92 +++++++-------
 main.py.error                                          |  22 ++++
 pre-commit-config.flake8                               |  15 +++
 requirements.txt                                       |   1 +
 requirements.txt.devops                                |   3 +-
 requirements.txt.makefile                              |   2 +
 tests/__pycache__/__init__.cpython-38.pyc              | Bin 163 -> 244 bytes
 tests/__pycache__/test_src.cpython-38-pytest-6.2.2.pyc | Bin 710 -> 791 bytes
 12 files changed, 788 insertions(+), 46 deletions(-)
 create mode 100644 main.py.error
 create mode 100644 pre-commit-config.flake8
[WARNING] The 'rev' field of repo 'https://github.com/ambv/black' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
[WARNING] The 'rev' field of repo 'https://github.com/pre-commit/mirrors-mypy' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
black................................................(no files to check)Skipped
Trim Trailing Whitespace.............................(no files to check)Skipped
Check Yaml...........................................(no files to check)Skipped
Check JSON...........................................(no files to check)Skipped
Flake8...............................................(no files to check)Skipped
Check Toml...........................................(no files to check)Skipped
Check Xml............................................(no files to check)Skipped
mypy.................................................(no files to check)Skipped
On branch main
Your branch is ahead of 'origin/main' by 9 commits.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
Total 0 (delta 0), reused 0 (delta 0)
To github.com:JackySo-MYOB/devops-venv.git
   02e45eb..7a8c0a1  main -> main
```

### Pre-commit check

#### Pre-commit configuration

```bash
repos:
  - repo: https://github.com/ambv/black
    rev: stable
    hooks:
      - id: black
        language_version: python3.8
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v2.3.0
    hooks:
      - id: trailing-whitespace
      - id: flake8
      - id: check-yaml
      - id: check-json
      - id: check-toml
```

#### Refresh pre-commit configuration

```bash
$ make pre-commit
Requirement already satisfied: pre-commit in ./.venv/lib/python3.8/site-packages (2.11.1)
Requirement already satisfied: virtualenv>=20.0.8 in ./.venv/lib/python3.8/site-packages (from pre-commit) (20.4.2)
Requirement already satisfied: cfgv>=2.0.0 in ./.venv/lib/python3.8/site-packages (from pre-commit) (3.2.0)
Requirement already satisfied: nodeenv>=0.11.1 in ./.venv/lib/python3.8/site-packages (from pre-commit) (1.5.0)
Requirement already satisfied: toml in ./.venv/lib/python3.8/site-packages (from pre-commit) (0.10.2)
Requirement already satisfied: pyyaml>=5.1 in ./.venv/lib/python3.8/site-packages (from pre-commit) (5.4.1)
Requirement already satisfied: identify>=1.0.0 in ./.venv/lib/python3.8/site-packages (from pre-commit) (2.1.3)
Requirement already satisfied: filelock<4,>=3.0.0 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit) (3.0.12)
Requirement already satisfied: appdirs<2,>=1.4.3 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit) (1.4.4)
Requirement already satisfied: distlib<1,>=0.3.1 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit) (0.3.1)
Requirement already satisfied: six<2,>=1.9.0 in ./.venv/lib/python3.8/site-packages (from virtualenv>=20.0.8->pre-commit) (1.15.0)
pre-commit installed at .git/hooks/pre-commit
```

#### Example: Add YAML file to check for pre-commit

```bash
$ git add nginx-ingress-name-routing.yaml
$ git commit -m 'Pre-commit test for check-yaml'
[ERROR] Your pre-commit configuration is unstaged.
`git add .pre-commit-config.yaml` to fix this.
$ git add .pre-commit-config.yaml
$ git commit -m 'Pre-commit test for check-yaml'
[WARNING] The 'rev' field of repo 'https://github.com/ambv/black' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
black................................................(no files to check)Skipped
Trim Trailing Whitespace.................................................Passed
Flake8...............................................(no files to check)Skipped
Check Yaml...............................................................Passed
Check JSON...........................................(no files to check)Skipped
Check Toml...........................................(no files to check)Skipped
Check Xml............................................(no files to check)Skipped
[main a863ed8] Pre-commit test for check-yaml
 2 files changed, 34 insertions(+)
 create mode 100644 nginx-ingress-name-routing.yaml

```

#### Example: Add mypy check to pre-commit

```bash

repos:
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: '' ## Add when needs
    hooks:
      - id: mypy

```

```bash
$ git add .pre-commit-config.yaml

$ git commit -m 'Check pre-commit for mypc'
[WARNING] Unstaged files detected.
[INFO] Stashing unstaged files to /home1/jso/.cache/pre-commit/patch1615784496.
[WARNING] The 'rev' field of repo 'https://github.com/ambv/black' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
[WARNING] The 'rev' field of repo 'https://github.com/pre-commit/mirrors-mypy' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
[INFO] Initializing environment for https://github.com/pre-commit/mirrors-mypy.
[INFO] Installing environment for https://github.com/pre-commit/mirrors-mypy.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
black................................................(no files to check)Skipped
Trim Trailing Whitespace.................................................Passed
Flake8...............................................(no files to check)Skipped
Check Yaml...............................................................Passed
Check JSON...........................................(no files to check)Skipped
Check Toml...........................................(no files to check)Skipped
Check Xml............................................(no files to check)Skipped
mypy.................................................(no files to check)Skipped
[INFO] Restored changes from /home1/jso/.cache/pre-commit/patch1615784496.
[main 30d6f0b] Check pre-commit for mypc
 1 file changed, 4 insertions(+)
```

### Troubleshooting

#### Example: Flake8 error in pre-commit

##### pre-commit failed in flake8 check

```bash
Executing devops step( 11 ):  git commit -m "sandbox commit that passesd all local unit tests"

stdout:
 stderr:  [WARNING] The 'rev' field of repo 'https://github.com/ambv/black' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
[WARNING] The 'rev' field of repo 'https://github.com/pre-commit/mirrors-mypy' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
black....................................................................Passed
Trim Trailing Whitespace.................................................Passed
Flake8...................................................................Failed
- hook id: flake8
- exit code: 1

devops.py:25:80: E501 line too long (87 > 79 characters)
devops.py:48:80: E501 line too long (86 > 79 characters)
devops.py:107:80: E501 line too long (86 > 79 characters)

Check Yaml...........................................(no files to check)Skipped
Check JSON...........................................(no files to check)Skipped
Check Toml...........................................(no files to check)Skipped
Check Xml............................................(no files to check)Skipped
mypy.....................................................................Passed

 Failed!  git commit -m "sandbox commit that passesd all local unit tests" 1
```

##### Add configuration to pre-commit to extend flake8 length check

```diff
$ git diff HEAD^ HEAD .pre-commit-config.yaml
diff --git a/.pre-commit-config.yaml b/.pre-commit-config.yaml
index ec4fb04..8aae1bc 100644
--- a/.pre-commit-config.yaml
+++ b/.pre-commit-config.yaml
@@ -8,9 +8,13 @@ repos:
     rev: v2.3.0
     hooks:
       - id: trailing-whitespace
-      - id: flake8
       - id: check-yaml
       - id: check-json
+      # flake8
+      - id: flake8
+        args: # arguments to configure flake8
+        # Override default length=79
+          - "--max-line-length=99"
       - id: check-toml
       - id: check-xml
   - repo: https://github.com/pre-commit/mirrors-mypy
```

##### Re-run to validate fix
```bash
Executing devops step( 11 ):  git commit -m "sandbox commit that passesd all local unit tests"

stdout:  [branch-dbfc970f-648a-45ce-9a63-be4bb56dfe52 e75111d] sandbox commit that passesd all local unit tests
 9 files changed, 139 insertions(+), 47 deletions(-)
 create mode 100644 pre-commit-config.flake8

 stderr:  [WARNING] The 'rev' field of repo 'https://github.com/ambv/black' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
[WARNING] The 'rev' field of repo 'https://github.com/pre-commit/mirrors-mypy' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
black....................................................................Passed
Trim Trailing Whitespace.................................................Passed
Check Yaml...............................................................Passed
Check JSON...........................................(no files to check)Skipped
Flake8...................................................................Passed
Check Toml...........................................(no files to check)Skipped
Check Xml............................................(no files to check)Skipped
mypy.....................................................................Passed

 yes! :Pass Go!!!


```

### pyforest - Automatic import for python and ipython: demostrate to run common DS codes and on-demand to install modules need.
#### Alternatively, you can pre-install all needed modules in advance - Precaution: It will consume hugh diskspace for modules and long time running

```bash
$  make pre-install-pyforest

```

#### Check what is going to auto-import

```bash
$  make check-pyforest
python3 -m venv ./.venv
./.venv/bin/python -m pip install --upgrade pip setuptools wheel
Collecting pip
  Using cached pip-21.0.1-py3-none-any.whl (1.5 MB)
Collecting setuptools
  Using cached setuptools-54.1.2-py3-none-any.whl (785 kB)
Collecting wheel
  Using cached wheel-0.36.2-py2.py3-none-any.whl (35 kB)
Installing collected packages: pip, setuptools, wheel
  Attempting uninstall: pip
    Found existing installation: pip 20.0.2
    Uninstalling pip-20.0.2:
      Successfully uninstalled pip-20.0.2
  Attempting uninstall: setuptools
    Found existing installation: setuptools 44.0.0
    Uninstalling setuptools-44.0.0:
      Successfully uninstalled setuptools-44.0.0
Successfully installed pip-21.0.1 setuptools-54.1.2 wheel-0.36.2
./.venv/bin/pip install -r requirements.txt
Collecting black
  Using cached black-20.8b1-py3-none-any.whl
Collecting mypy
  Using cached mypy-0.812-cp38-cp38-manylinux2010_x86_64.whl (22.5 MB)
Collecting flake8
  Using cached flake8-3.9.0-py2.py3-none-any.whl (73 kB)
Collecting pre-commit
  Using cached pre_commit-2.11.1-py2.py3-none-any.whl (187 kB)
Collecting console
  Using cached console-0.9906-py2.py3-none-any.whl (93 kB)
Collecting pyfiglet
  Using cached pyfiglet-0.8.post1-py2.py3-none-any.whl (865 kB)
Collecting typing-extensions>=3.7.4
  Using cached typing_extensions-3.7.4.3-py3-none-any.whl (22 kB)
Collecting pathspec<1,>=0.6
  Using cached pathspec-0.8.1-py2.py3-none-any.whl (28 kB)
Collecting typed-ast>=1.4.0
  Using cached typed_ast-1.4.2-cp38-cp38-manylinux1_x86_64.whl (774 kB)
Collecting toml>=0.10.1
  Using cached toml-0.10.2-py2.py3-none-any.whl (16 kB)
Collecting regex>=2020.1.8
  Using cached regex-2021.3.17-cp38-cp38-manylinux2014_x86_64.whl (737 kB)
Collecting appdirs
  Using cached appdirs-1.4.4-py2.py3-none-any.whl (9.6 kB)
Collecting mypy-extensions>=0.4.3
  Using cached mypy_extensions-0.4.3-py2.py3-none-any.whl (4.5 kB)
Collecting click>=7.1.2
  Using cached click-7.1.2-py2.py3-none-any.whl (82 kB)
Collecting ezenv>=0.92
  Using cached ezenv-0.92-py2.py3-none-any.whl (10 kB)
Collecting mccabe<0.7.0,>=0.6.0
  Using cached mccabe-0.6.1-py2.py3-none-any.whl (8.6 kB)
Collecting pyflakes<2.4.0,>=2.3.0
  Using cached pyflakes-2.3.0-py2.py3-none-any.whl (68 kB)
Collecting pycodestyle<2.8.0,>=2.7.0
  Using cached pycodestyle-2.7.0-py2.py3-none-any.whl (41 kB)
Collecting cfgv>=2.0.0
  Using cached cfgv-3.2.0-py2.py3-none-any.whl (7.3 kB)
Collecting virtualenv>=20.0.8
  Using cached virtualenv-20.4.3-py2.py3-none-any.whl (7.2 MB)
Collecting identify>=1.0.0
  Using cached identify-2.1.3-py2.py3-none-any.whl (98 kB)
Collecting nodeenv>=0.11.1
  Using cached nodeenv-1.5.0-py2.py3-none-any.whl (21 kB)
Collecting pyyaml>=5.1
  Using cached PyYAML-5.4.1-cp38-cp38-manylinux1_x86_64.whl (662 kB)
Collecting six<2,>=1.9.0
  Using cached six-1.15.0-py2.py3-none-any.whl (10 kB)
Collecting distlib<1,>=0.3.1
  Using cached distlib-0.3.1-py2.py3-none-any.whl (335 kB)
Collecting filelock<4,>=3.0.0
  Using cached filelock-3.0.12-py3-none-any.whl (7.6 kB)
Installing collected packages: six, filelock, distlib, appdirs, virtualenv, typing-extensions, typed-ast, toml, regex, pyyaml, pyflakes, pycodestyle, pathspec, nodeenv, mypy-extensions, mccabe, identify, ezenv, click, cfgv, pyfiglet, pre-commit, mypy, flake8, console, black
Successfully installed appdirs-1.4.4 black-20.8b1 cfgv-3.2.0 click-7.1.2 console-0.9906 distlib-0.3.1 ezenv-0.92 filelock-3.0.12 flake8-3.9.0 identify-2.1.3 mccabe-0.6.1 mypy-0.812 mypy-extensions-0.4.3 nodeenv-1.5.0 pathspec-0.8.1 pre-commit-2.11.1 pycodestyle-2.7.0 pyfiglet-0.8.post1 pyflakes-2.3.0 pyyaml-5.4.1 regex-2021.3.17 six-1.15.0 toml-0.10.2 typed-ast-1.4.2 typing-extensions-3.7.4.3 virtualenv-20.4.3
touch ./.venv/bin/.initialized-with-Makefile.venv
Collecting pyforest
  Using cached pyforest-1.0.3-py2.py3-none-any.whl
Installing collected packages: pyforest
Successfully installed pyforest-1.0.3
['import os', 'import sys', 'import pandas as pd', 'import datetime as dt', 'import seaborn as sns', 'import altair as alt', 'from pathlib import Path', 'import lightgbm as lgb', 'from sklearn.ensemble import RandomForestClassifier', 'from sklearn.preprocessing import OneHotEncoder', 'import statistics', 'from openpyxl import load_workbook', 'import tqdm', 'import matplotlib as mpl', 'import pydot', 'from sklearn.model_selection import train_test_split', 'import numpy as np', 'from sklearn.feature_extraction.text import TfidfVectorizer', 'import dash', 'from sklearn import svm', 'import glob', 'import spacy', 'import re', 'import matplotlib.pyplot as plt', 'import tensorflow as tf', 'import bokeh', 'from sklearn.ensemble import GradientBoostingRegressor', 'import awswrangler as wr', 'from sklearn.ensemble import GradientBoostingClassifier', 'import keras', 'import pickle', 'from sklearn.manifold import TSNE', 'import plotly.graph_objs as go', 'from dask import dataframe as dd', 'import plotly as py', 'from pyspark import SparkContext', 'import plotly.express as px', 'from sklearn.ensemble import RandomForestRegressor', 'import nltk', 'import sklearn', 'import xgboost as xgb', 'import gensim']

[]
```

#### Run IPYTHON with pyforest
$  make pyforest
python3 -m venv ./.venv
./.venv/bin/python -m pip install --upgrade pip setuptools wheel
Collecting pip
  Using cached pip-21.0.1-py3-none-any.whl (1.5 MB)
Collecting setuptools
  Using cached setuptools-54.1.2-py3-none-any.whl (785 kB)
Collecting wheel
  Using cached wheel-0.36.2-py2.py3-none-any.whl (35 kB)
Installing collected packages: pip, setuptools, wheel
  Attempting uninstall: pip
    Found existing installation: pip 20.0.2
    Uninstalling pip-20.0.2:
      Successfully uninstalled pip-20.0.2
  Attempting uninstall: setuptools
    Found existing installation: setuptools 44.0.0
    Uninstalling setuptools-44.0.0:
      Successfully uninstalled setuptools-44.0.0
Successfully installed pip-21.0.1 setuptools-54.1.2 wheel-0.36.2
./.venv/bin/pip install -r requirements.txt
Collecting black
  Using cached black-20.8b1-py3-none-any.whl
Collecting mypy
  Using cached mypy-0.812-cp38-cp38-manylinux2010_x86_64.whl (22.5 MB)
Collecting flake8
  Using cached flake8-3.9.0-py2.py3-none-any.whl (73 kB)
Collecting pre-commit
  Using cached pre_commit-2.11.1-py2.py3-none-any.whl (187 kB)
Collecting console
  Using cached console-0.9906-py2.py3-none-any.whl (93 kB)
Collecting pyfiglet
  Using cached pyfiglet-0.8.post1-py2.py3-none-any.whl (865 kB)
Collecting appdirs
  Using cached appdirs-1.4.4-py2.py3-none-any.whl (9.6 kB)
Collecting typing-extensions>=3.7.4
  Using cached typing_extensions-3.7.4.3-py3-none-any.whl (22 kB)
Collecting mypy-extensions>=0.4.3
  Using cached mypy_extensions-0.4.3-py2.py3-none-any.whl (4.5 kB)
Collecting regex>=2020.1.8
  Using cached regex-2021.3.17-cp38-cp38-manylinux2014_x86_64.whl (737 kB)
Collecting click>=7.1.2
  Using cached click-7.1.2-py2.py3-none-any.whl (82 kB)
Collecting pathspec<1,>=0.6
  Using cached pathspec-0.8.1-py2.py3-none-any.whl (28 kB)
Collecting toml>=0.10.1
  Using cached toml-0.10.2-py2.py3-none-any.whl (16 kB)
Collecting typed-ast>=1.4.0
  Using cached typed_ast-1.4.2-cp38-cp38-manylinux1_x86_64.whl (774 kB)
Collecting ezenv>=0.92
  Using cached ezenv-0.92-py2.py3-none-any.whl (10 kB)
Collecting pyflakes<2.4.0,>=2.3.0
  Using cached pyflakes-2.3.0-py2.py3-none-any.whl (68 kB)
Collecting pycodestyle<2.8.0,>=2.7.0
  Using cached pycodestyle-2.7.0-py2.py3-none-any.whl (41 kB)
Collecting mccabe<0.7.0,>=0.6.0
  Using cached mccabe-0.6.1-py2.py3-none-any.whl (8.6 kB)
Collecting nodeenv>=0.11.1
  Using cached nodeenv-1.5.0-py2.py3-none-any.whl (21 kB)
Collecting virtualenv>=20.0.8
  Using cached virtualenv-20.4.3-py2.py3-none-any.whl (7.2 MB)
Collecting identify>=1.0.0
  Using cached identify-2.1.3-py2.py3-none-any.whl (98 kB)
Collecting cfgv>=2.0.0
  Using cached cfgv-3.2.0-py2.py3-none-any.whl (7.3 kB)
Collecting pyyaml>=5.1
  Using cached PyYAML-5.4.1-cp38-cp38-manylinux1_x86_64.whl (662 kB)
Collecting six<2,>=1.9.0
  Using cached six-1.15.0-py2.py3-none-any.whl (10 kB)
Collecting filelock<4,>=3.0.0
  Using cached filelock-3.0.12-py3-none-any.whl (7.6 kB)
Collecting distlib<1,>=0.3.1
  Using cached distlib-0.3.1-py2.py3-none-any.whl (335 kB)
Installing collected packages: six, filelock, distlib, appdirs, virtualenv, typing-extensions, typed-ast, toml, regex, pyyaml, pyflakes, pycodestyle, pathspec, nodeenv, mypy-extensions, mccabe, identify, ezenv, click, cfgv, pyfiglet, pre-commit, mypy, flake8, console, black
Successfully installed appdirs-1.4.4 black-20.8b1 cfgv-3.2.0 click-7.1.2 console-0.9906 distlib-0.3.1 ezenv-0.92 filelock-3.0.12 flake8-3.9.0 identify-2.1.3 mccabe-0.6.1 mypy-0.812 mypy-extensions-0.4.3 nodeenv-1.5.0 pathspec-0.8.1 pre-commit-2.11.1 pycodestyle-2.7.0 pyfiglet-0.8.post1 pyflakes-2.3.0 pyyaml-5.4.1 regex-2021.3.17 six-1.15.0 toml-0.10.2 typed-ast-1.4.2 typing-extensions-3.7.4.3 virtualenv-20.4.3
touch ./.venv/bin/.initialized-with-Makefile.venv
Collecting pyforest
  Using cached pyforest-1.0.3-py2.py3-none-any.whl
Installing collected packages: pyforest
Successfully installed pyforest-1.0.3
Launch IPYTHON - install missing module by run ! .venv/bin/pip install -U <module>
make[1]: Entering directory '/home1/jso/myob-work/work/aws-cf/git-repo/project-resources/project/JackySo/devops-venv'
./.venv/bin/pip install --upgrade ipython
Collecting ipython
  Using cached ipython-7.21.0-py3-none-any.whl (784 kB)
Collecting pygments
  Using cached Pygments-2.8.1-py3-none-any.whl (983 kB)
Collecting jedi>=0.16
  Using cached jedi-0.18.0-py2.py3-none-any.whl (1.4 MB)
Collecting pexpect>4.3
  Using cached pexpect-4.8.0-py2.py3-none-any.whl (59 kB)
Collecting decorator
  Using cached decorator-4.4.2-py2.py3-none-any.whl (9.2 kB)
Collecting prompt-toolkit!=3.0.0,!=3.0.1,<3.1.0,>=2.0.0
  Using cached prompt_toolkit-3.0.17-py3-none-any.whl (367 kB)
Collecting backcall
  Using cached backcall-0.2.0-py2.py3-none-any.whl (11 kB)
Collecting traitlets>=4.2
  Using cached traitlets-5.0.5-py3-none-any.whl (100 kB)
Requirement already satisfied: setuptools>=18.5 in ./.venv/lib/python3.8/site-packages (from ipython) (54.1.2)
Collecting pickleshare
  Using cached pickleshare-0.7.5-py2.py3-none-any.whl (6.9 kB)
Collecting parso<0.9.0,>=0.8.0
  Using cached parso-0.8.1-py2.py3-none-any.whl (93 kB)
Collecting ptyprocess>=0.5
  Using cached ptyprocess-0.7.0-py2.py3-none-any.whl (13 kB)
Collecting wcwidth
  Using cached wcwidth-0.2.5-py2.py3-none-any.whl (30 kB)
Collecting ipython-genutils
  Using cached ipython_genutils-0.2.0-py2.py3-none-any.whl (26 kB)
Installing collected packages: wcwidth, ptyprocess, parso, ipython-genutils, traitlets, pygments, prompt-toolkit, pickleshare, pexpect, jedi, decorator, backcall, ipython
Successfully installed backcall-0.2.0 decorator-4.4.2 ipython-7.21.0 ipython-genutils-0.2.0 jedi-0.18.0 parso-0.8.1 pexpect-4.8.0 pickleshare-0.7.5 prompt-toolkit-3.0.17 ptyprocess-0.7.0 pygments-2.8.1 traitlets-5.0.5 wcwidth-0.2.5
touch .venv/bin/ipython
exec ./.venv/bin/ipython
Python 3.8.5 (default, Jan 27 2021, 15:41:15)
Type 'copyright', 'credits' or 'license' for more information
IPython 7.21.0 -- An enhanced Interactive Python. Type '?' for help.

In [1]: from pyforest import *

In [2]: data = [['bhagesh',23],['Bob',12],['Clarke',13]]
   ...: df = pd.DataFrame(data,columns=['Name','Age'])
   ...: print(df)
---------------------------------------------------------------------------
ModuleNotFoundError                       Traceback (most recent call last)
<ipython-input-2-88df09541cfe> in <module>
      1 data = [['bhagesh',23],['Bob',12],['Clarke',13]]
----> 2 df = pd.DataFrame(data,columns=['Name','Age'])
      3 print(df)

~/myob-work/work/aws-cf/git-repo/project-resources/project/JackySo/devops-venv/.venv/lib/python3.8/site-packages/pyforest/_importable.py in __getattr__(self, attribute)
     68     # called for undefined attribute and returns the attribute of the imported module
     69     def __getattr__(self, attribute):
---> 70         self.__maybe_import__()
     71         return eval(f"{self.__imported_name__}.{attribute}")
     72

~/myob-work/work/aws-cf/git-repo/project-resources/project/JackySo/devops-venv/.venv/lib/python3.8/site-packages/pyforest/_importable.py in __maybe_import__(self)
     35     def __maybe_import__(self):
     36         self.__maybe_import_complementary_imports__()
---> 37         exec(self.__import_statement__, globals())
     38         # Attention: if the import fails, the next lines will not be reached
     39         self.__was_imported__ = True

~/myob-work/work/aws-cf/git-repo/project-resources/project/JackySo/devops-venv/.venv/lib/python3.8/site-packages/pyforest/_importable.py in <module>

ModuleNotFoundError: No module named 'pandas'

In [3]: ! .venv/bin/pip install -U pandas
Collecting pandas
  Using cached pandas-1.2.3-cp38-cp38-manylinux1_x86_64.whl (9.7 MB)
Collecting numpy>=1.16.5
  Using cached numpy-1.20.1-cp38-cp38-manylinux2010_x86_64.whl (15.4 MB)
Collecting pytz>=2017.3
  Using cached pytz-2021.1-py2.py3-none-any.whl (510 kB)
Collecting python-dateutil>=2.7.3
  Using cached python_dateutil-2.8.1-py2.py3-none-any.whl (227 kB)
Requirement already satisfied: six>=1.5 in ./.venv/lib/python3.8/site-packages (from python-dateutil>=2.7.3->pandas) (1.15.0)
Installing collected packages: pytz, python-dateutil, numpy, pandas
Successfully installed numpy-1.20.1 pandas-1.2.3 python-dateutil-2.8.1 pytz-2021.1

In [4]: data = [['bhagesh',23],['Bob',12],['Clarke',13]]
   ...: df = pd.DataFrame(data,columns=['Name','Age'])
   ...: print(df)
<IPython.core.display.Javascript object>
      Name  Age
0  bhagesh   23
1      Bob   12
2   Clarke   13

In [5]: plt.plot(df.Name,df.Age)
---------------------------------------------------------------------------
ModuleNotFoundError                       Traceback (most recent call last)
<ipython-input-5-560c341cb557> in <module>
----> 1 plt.plot(df.Name,df.Age)

~/myob-work/work/aws-cf/git-repo/project-resources/project/JackySo/devops-venv/.venv/lib/python3.8/site-packages/pyforest/_importable.py in __getattr__(self, attribute)
     68     # called for undefined attribute and returns the attribute of the imported module
     69     def __getattr__(self, attribute):
---> 70         self.__maybe_import__()
     71         return eval(f"{self.__imported_name__}.{attribute}")
     72

~/myob-work/work/aws-cf/git-repo/project-resources/project/JackySo/devops-venv/.venv/lib/python3.8/site-packages/pyforest/_importable.py in __maybe_import__(self)
     35     def __maybe_import__(self):
     36         self.__maybe_import_complementary_imports__()
---> 37         exec(self.__import_statement__, globals())
     38         # Attention: if the import fails, the next lines will not be reached
     39         self.__was_imported__ = True

~/myob-work/work/aws-cf/git-repo/project-resources/project/JackySo/devops-venv/.venv/lib/python3.8/site-packages/pyforest/_importable.py in <module>

ModuleNotFoundError: No module named 'matplotlib'

In [6]: ! .venv/bin/pip install -U matplotlib
Collecting matplotlib
  Using cached matplotlib-3.3.4-cp38-cp38-manylinux1_x86_64.whl (11.6 MB)
Requirement already satisfied: numpy>=1.15 in ./.venv/lib/python3.8/site-packages (from matplotlib) (1.20.1)
Collecting pillow>=6.2.0
  Using cached Pillow-8.1.2-cp38-cp38-manylinux1_x86_64.whl (2.2 MB)
Requirement already satisfied: python-dateutil>=2.1 in ./.venv/lib/python3.8/site-packages (from matplotlib) (2.8.1)
Collecting cycler>=0.10
  Using cached cycler-0.10.0-py2.py3-none-any.whl (6.5 kB)
Collecting pyparsing!=2.0.4,!=2.1.2,!=2.1.6,>=2.0.3
  Using cached pyparsing-2.4.7-py2.py3-none-any.whl (67 kB)
Collecting kiwisolver>=1.0.1
  Using cached kiwisolver-1.3.1-cp38-cp38-manylinux1_x86_64.whl (1.2 MB)
Requirement already satisfied: six in ./.venv/lib/python3.8/site-packages (from cycler>=0.10->matplotlib) (1.15.0)
Installing collected packages: pyparsing, pillow, kiwisolver, cycler, matplotlib
Successfully installed cycler-0.10.0 kiwisolver-1.3.1 matplotlib-3.3.4 pillow-8.1.2 pyparsing-2.4.7

In [7]: plt.plot(df.Name,df.Age)
<IPython.core.display.Javascript object>
Out[7]: [<matplotlib.lines.Line2D at 0x7ff505e6faf0>]

In [8]: exit
make[1]: Leaving directory '/home1/jso/myob-work/work/aws-cf/git-repo/project-resources/project/JackySo/devops-venv'

```
