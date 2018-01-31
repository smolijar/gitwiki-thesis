
all: pdf

md:
	./bin/markdown.sh

pdf: md
	xelatex DP_Smolik_Jaroslav_2018.tex
