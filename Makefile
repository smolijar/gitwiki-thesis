
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

clean:
	rm -f DP_Smolik_Jaroslav_2018.aux
	rm -f DP_Smolik_Jaroslav_2018.lof
	rm -f DP_Smolik_Jaroslav_2018.log
	rm -f DP_Smolik_Jaroslav_2018.out
	rm -f DP_Smolik_Jaroslav_2018.pdf
	rm -f DP_Smolik_Jaroslav_2018.toc
	rm -f DP_Smolik_Jaroslav_2018.bbl
	rm -f DP_Smolik_Jaroslav_2018.blg
	rm -f DP_Smolik_Jaroslav_2018.fdb_latexmk
	rm -f DP_Smolik_Jaroslav_2018.fls
	rm -f DP_Smolik_Jaroslav_2018.lol
	rm -f DP_Smolik_Jaroslav_2018.acn
	rm -f DP_Smolik_Jaroslav_2018.acr
	rm -f DP_Smolik_Jaroslav_2018.alg
	rm -f DP_Smolik_Jaroslav_2018.glg
	rm -f DP_Smolik_Jaroslav_2018.glo
	rm -f DP_Smolik_Jaroslav_2018.gls
	rm -f DP_Smolik_Jaroslav_2018.glsdefs
	rm -f DP_Smolik_Jaroslav_2018.ist