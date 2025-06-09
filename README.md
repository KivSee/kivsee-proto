# kivsee-proto

protobuf definitions for the Kivsee led show platform

## How to generate code

This repo uses [buf](https://buf.build/) for managing and generating protobuf code.

For nanopb, buf is not able to parse ".options" file which we use, thus we generate the files manually.

## Usage with Makefile targets

The following `make` targets are available:

- `make generate`

  Generates code for all plugins specified in `buf.gen.yaml` using Docker. Output is placed in the `gen/` directory.

- `make clean`

  Removes the generated `gen/` directory and all generated code.

## Example output structure

- `gen/nanopb/` - nanopb generated code
- (other language outputs can be configured in `buf.gen.yaml`)

## Consume as CMake library

The nanopb generated files can be consumed with CMake.
To test building the CMake static library, run:

- `make build-cmake`
