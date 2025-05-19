
.PHONY: all clean
clean:
	@rm -rf gen

generate:
	docker run --rm -v $(PWD):/workspace -w /workspace bufbuild/buf:1.54 generate
	docker build -t nanopb-proto-gen ./gen-nanopb && docker run --rm -v $(PWD)/kivsee/proto:/proto -v $(PWD)/gen/nanopb:/gen nanopb-proto-gen /proto/segments.proto /proto/functions.proto /proto/effects.proto
