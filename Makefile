
all: arara

md:
	./bin/markdown.sh

bibtex:
	bibtex DP_Smolik_Jaroslav_2018

arara: md
	make pdf
	make bibtex
	make pdf
	make pdf

pdf: md
	xelatex DP_Smolik_Jaroslav_2018.tex
