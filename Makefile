PROJ_NAME = my_own_forth

fmt:
	dune build @fmt --auto-promote

build:
	dune build

run:
	dune exec $(PROJ_NAME)