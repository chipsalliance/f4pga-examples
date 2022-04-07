Building the documentation
##########################

To build Sphinx documentation, you need at least Python 3.6.
You will also need to install Sphinx v3.3.0 and additional dependencies, which you can get with ``pip``::

   pip install -r docs/requirements.txt

Next, just run::

   make -C docs html

The output will be found in the ``docs/_build/html`` directory.
