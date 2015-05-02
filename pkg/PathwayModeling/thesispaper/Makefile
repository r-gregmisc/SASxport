#!/bin/sh
default: paper.pdf view

NOWEB= $(wildcard *.Snw ) 

paper.tex: $(NOWEB)
	echo $(NOWEB)
	echo 'Sweave("paper.Snw")' | R --slave --no-save --no-restore

paper.pdf: paper.tex
	pdflatex paper.tex
	pdflatex paper.tex
	pdflatex paper.tex

paper.ps: paper.tex
	latex paper.tex
	latex paper.tex
	latex paper.tex
	dvips paper.dvi

view: paper.pdf
	open paper.pdf