SHELL := /bin/bash

.PHONY: install
install:
	@pip install -r requirements.txt

build-LambdaA: build_dependencies
	./scripts/build_lambda.sh src/function_a

build-LambdaB: build_dependencies
	./scripts/build_lambda.sh src/function_b

build_dependencies:
	./scripts/build_dependencies.sh
