# Detect OS
ifeq ($(OS),Windows_NT)
    RM_CMD = if exist gen rmdir /s /q gen
    MKDIR_CMD = if not exist build mkdir build
else
    RM_CMD = rm -rf gen
    MKDIR_CMD = mkdir -p build
endif

.PHONY: all clean generate generate-windows
clean:
	@$(RM_CMD)

.PHONY: generate
generate: clean
	docker run --rm -v $(PWD):/workspace -w /workspace bufbuild/buf:1.54 generate
	docker build -t nanopb-proto-gen ./gen-nanopb && docker run --rm -v $(PWD):/proto -v $(PWD)/gen/nanopb:/gen nanopb-proto-gen /proto/kivsee/proto/render/v1/segments.proto /proto/kivsee/proto/render/v1/functions.proto /proto/kivsee/proto/render/v1/effects.proto /proto/kivsee/proto/render/v1/animation.proto

generate-windows:
	cmd /c "docker run --rm -v "%cd%:/workspace" -w /workspace bufbuild/buf:1.54 generate"
	cmd /c "docker build -t nanopb-proto-gen ./gen-nanopb && docker run --rm -v "%cd%:/proto" -v "%cd%/gen/nanopb:/gen" nanopb-proto-gen /proto/kivsee/proto/render/v1/segments.proto /proto/kivsee/proto/render/v1/functions.proto /proto/kivsee/proto/render/v1/effects.proto /proto/kivsee/proto/render/v1/animation.proto"

.PHONY: lint
lint:
	docker run --rm -v $(PWD):/workspace -w /workspace bufbuild/buf:1.54 lint

.PHONY: build-cmake
build-cmake:
	$(MKDIR_CMD)
	cmake -S . -B build
	cmake --build build
