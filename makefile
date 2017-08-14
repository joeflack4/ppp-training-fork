PYTHON=./env/bin/python3
SRC=./pmix/
TEST=./test/

.PHONY: lint tags ltags test all lint_all codestyle docstyle server serve lint_src lint_test doctest doc docs code linters_all code_src code_test doc_src doc_test

# Batched Commands
all: linters_all test_all
lint: lint_src code_src doc_src
linters_all: doc code lint_all

# Pylint Only
PYLINT_BASE =${PYTHON} -m pylint --output-format=colorized --reports=n
lint_all: lint_src lint_test
lint_src:
	${PYLINT_BASE} ${SRC}
lint_test:
	${PYLINT_BASE} ${TEST}

# PyCodeStyle Only
PYCODESTYLE_BASE=${PYTHON} -m pycodestyle
codestyle: codestyle_src codestyle_test
code_src: codestyle_src
code_test: codestyle_test
code: codestyle
codestyle_src:
	${PYCODESTYLE_BASE} ${SRC}
codestyle_test:
	 ${PYCODESTYLE_BASE} ${TEST}

# PyDocStyle Only
PYDOCSTYLE_BASE=${PYTHON} -m pydocstyle
docstyle: docstyle_src docstyle_test
doc_src: docstyle_src
doc_test: docstyle_test
doc: docstyle
docs: docstyle
docstyle_src:
	${PYDOCSTYLE_BASE} ${SRC}
docstyle_test:
	${PYDOCSTYLE_BASE} ${TEST}

# Text Editor Commands
TAGS_BASE=ctags -R --python-kinds=-i
tags:
	${TAGS_BASE} .
ltags:
	${TAGS_BASE} ${SRC}


# Testing
test_all: unittest doctest
unittest: test
test:
	${PYTHON} -m unittest discover -v
doctest:
	${PYTHON} -m test.test_ppp --doctests-only


# Application Management
serve:server
server:
	gunicorn pmaapi.__main__:APP
