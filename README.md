# Kiota AL Samples

This repository showcases the use of the [Kiota](https://github.com/microsoft/kiota) code generator for generating AL (Application Language) clients from OpenAPI definitions. It is based on a fork of the Kiota repository maintained in [SimonOfHH/kiota](https://github.com/SimonOfHH/kiota) (branch: `kiota-al`). The goal is to explore how Kiota can be extended to support AL, the language used in Microsoft Dynamics 365 Business Central.

## Overview

The repository contains examples of generated AL clients for various APIs, demonstrating how Kiota can be used to automate the creation of strongly-typed clients for AL developers. These samples are early prototypes and are intended to provide a foundation for further development and experimentation.

## Structure

The repository is organized as follows:

- **`petstore-sample/`**: Contains a sample AL client generated from the [PetStore API](https://petstore3.swagger.io/). This demonstrates the basic capabilities of the Kiota AL generator.
- **...**: more to come ...

## Getting Started

To generate your own AL client using this repository:

1. Clone the [SimonOfHH/kiota](https://github.com/SimonOfHH/kiota) repository and switch to the `kiota-al` branch.
2. Use the modified Kiota generator to process an OpenAPI definition and generate AL code.
3. Follow the instructions in the sample folders to set up and test the generated clients.

## Notes

- This repository is a work in progress and is not production-ready.
- Contributions and feedback are welcome to help improve the AL client generation process.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.