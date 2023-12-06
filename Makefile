PROJ_NAME = my_own_forth

.PHONY: fmt test build run

fmt:
	dune build @fmt --auto-promote

build:
	dune build

run:
	dune exec $(PROJ_NAME)

test:
	dune runtest --auto-promote