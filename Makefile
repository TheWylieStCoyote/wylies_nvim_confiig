.PHONY: all fmt-check fmt syntax selene

all: fmt-check syntax selene

fmt-check:
	stylua --check .

fmt:
	stylua .

syntax:
	find . -name "*.lua" -not -path "./.git/*" | xargs luac -p

selene:
	selene --display-style=rich lua/
