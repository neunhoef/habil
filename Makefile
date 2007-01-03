# Makefile for Max's habilitation thesis.

all:	habil.pdf

habil.pdf:	habil.dvi
	dvipdfm habil

habil.dvi:	*.tex matmulF2_all.eps matmulF7_all.eps grease.pstex_t
	texer

clean:
	rm -rf *.log habil.pdf habil.dvi *.aux *.bbl *.blg *.brf *.toc *.lot \
	       *.lof *.ps *.bibmd5sums *.out *.idx *.ind *.ilg *_low.eps \
	       *_all.eps

matmulF2_all.eps:	matmulF2.dat plotF2.py
	plotF2.py

matmulF7_all.eps:	matmulF7.dat plotF7.py
	plotF7.py

grease.pstex_t:	grease.fig
	fig2dev -L pstex grease.fig grease.pstex
	fig2dev -L pstex_t grease.fig grease.pstex_t

