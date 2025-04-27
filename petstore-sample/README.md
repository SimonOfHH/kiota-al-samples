# PetStore AL Client

This repository contains the output of the client generation based on the fork in the [SimonOfHH/kiota](https://github.com/SimonOfHH/kiota) repository (branch: `kiota-al`). It is an early prototype and demonstrates the use of the Kiota code generator for generating AL code from an OpenAPI definition.

## API Definition

The client is based on the API definition available at [https://petstore3.swagger.io/](https://petstore3.swagger.io/).

## Launch Configuration

This is the configuration from the launch.json if you want to create it yourself locally.

```json
{
  "name": "Launch AL (Pet Store)",
  "type": "coreclr",
  "request": "launch",
  "preLaunchTask": "build",
  "program": "${workspaceFolder}/src/kiota/bin/Debug/net9.0/kiota.dll",
  "args": [
    "generate",
    "--openapi",
    "https://petstore3.swagger.io/api/v3/openapi.json",
    "--language",
    "al",
    "--clean-output",
    "-o",
    "${workspaceFolder}/samples/PetStore/al",
    "-n",
    "PetStoreAl"
  ],
  "cwd": "${workspaceFolder}/src/kiota",
  "console": "internalConsole",
  "stopAtEntry": false,
  "justMyCode": true
}