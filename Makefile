
all: arara

md:
	./bin/markdown.sh

bibtex:
	bibtex DP_Smolik_Jaroslav_2018

diagrams:
	./bin/diagrams.sh

glossaries:
	makeglossaries DP_Smolik_Jaroslav_2018

arara: md diagrams
	make pdf
	make bibtex
	make glossaries
	make pdf
	make pdf

pdf: md
	xelatex -shell-escape -8bit DP_Smolik_Jaroslav_2018.tex
