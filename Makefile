
.PHONY: all clean
clean:
	@rm -rf gen

.PHONY: generate
generate: clean
	docker run --rm -v $(PWD):/workspace -w /workspace bufbuild/buf:1.54 generate
	docker build -t nanopb-proto-gen ./gen-nanopb && docker run --rm -v $(PWD):/proto -v $(PWD)/gen/nanopb:/gen nanopb-proto-gen /proto/kivsee/proto/render/v1/segments.proto /proto/kivsee/proto/render/v1/functions.proto /proto/kivsee/proto/render/v1/effects.proto /proto/kivsee/proto/render/v1/animation.proto

.PHONY: lint
lint:
	docker run --rm -v $(PWD):/workspace -w /workspace bufbuild/buf:1.54 lint

.PHONY: build-cmake
build-cmake:
	mkdir -p build
	cmake -S . -B build
	cmake --build build
	