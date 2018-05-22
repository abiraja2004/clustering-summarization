EXE=$(patsubst %.md, %.pdf, $(wildcard *.md))

default: $(EXE)

%.pdf: %.md
	pandoc $< -o $@ --filter pandoc-citeproc

%.tex: %.md
	pandoc $< -o $@ --filter pandoc-citeproc
