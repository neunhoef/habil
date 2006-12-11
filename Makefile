# Makefile for Max's habilitation thesis.

all:	habil.pdf

habil.pdf:	habil.dvi
	dvipdfm habil

habil.dvi:	*.tex *.eps matmulF2_all.eps grease.pstex_t
	texer --pdf

clean:
	rm -rf *.log habil.pdf habil.dvi *.aux *.bbl *.blg *.brf *.toc *.lot \
	       *.lof *.ps *.bibmd5sums *.out *.idx *.ind *.ilg

matmulF2_all.eps:	matmulF2.dat plotF2.py
	plotF2.py

grease.pstex_t:	grease.fig
	fig2dev -L pstex grease.fig
	fig2dev -L pstex_t grease.fig

