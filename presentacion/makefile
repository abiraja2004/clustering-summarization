default: presentacion.pdf

%.tex: %.md
	pandoc -o $@ $< -t beamer --standalone

%.pdf: %.md
	pandoc -o $@ $< -t beamer --latex-engine=xelatex
