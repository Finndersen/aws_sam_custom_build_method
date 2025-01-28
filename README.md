# Custom SAM Build Method for Multi-lambda Monorepo 

A basic project template to demonstrate a custom AWS ASM build method which allows each Lambda to only contain the source code it needs.

## Issue with Standard build method

In you have a project involving multiple Lambda functions with shared code, having a structure like:

```
my-project/
├── src/
│   ├── function_a/
│   ├── function_b/
│   └── shared/
├── tests/
├── requirements.txt
└── sam-template.yaml
```
And with a SAM resource configuration like:
```yaml
Resources:
  LambdaA:
    Type: AWS::Serverless::Function
    Properties:
      Handler: function_a.app.lambda_handler
      Runtime: python3.11
      CodeUri: src/

  ...
```
The standard AWS SAM build method will package all the source code into each Lambda, meaning each Lambda will contain code it does not need, and will have a new version published even when its own relevant code has not changed.
Example build output:
```
build/
├── LambdaA/
│   ├── function_a/
│   ├── function_b/     # This is not needed
│   ├── shared/
│   └── <dependencies>
├── LambdaB/
│   ├── function_a/     # This is not needed
│   ├── function_b/
│   ├── shared/
│   └── <dependencies>
```

## Solution

AWS SAM supports defining [custom build logic](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/building-custom-runtimes.html) using Makefile commands. 
This project includes an example custom build process which only includes the necessary source code in each Lambda, so the build output will look like:

```
build/
├── LambdaA/
│   ├── function_a/
│   ├── shared/
│   └── <dependencies>
├── LambdaB/
│   ├── function_b/
│   ├── shared/
│   └── <dependencies>
```

## Usage

To run default build method:
```bash
sam build --template sam-template-basic.yaml --manifest requirements.txt
```

To run custom build method:
```bash
sam build --template sam-template-custom.yaml
```

## Limitations
This setup involves a single set of dependencies for all Lambdas, so this may result in a Lambda being built with dependencies it does not need.
The dependencies are downloaded only once for efficiency and copied for each Lambda so this may not be a big deal, but it should also be possible to extend this solution to support Lambda-specific dependencies if required. 