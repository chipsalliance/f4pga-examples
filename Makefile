include scripts/make/conda.mk

README.rst: README.src.rst eos-s3/README.rst xc7/README.rst | $(CONDA_ENV_PYTHON)
	@rm -f README.rst
	$(IN_CONDA_ENV) rst_include include README.src.rst - > README.rst
