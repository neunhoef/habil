# Makefile for Max's habilitation thesis.

all:	habil.pdf

habil.pdf:	*.tex matmulF2_all.pdf matmulF7_all.pdf matmulF243_all.pdf \
		matmulF17_all.pdf grease.pstex_t matmulF2grease.pdf \
		matmulF2grease_scaled.pdf matmulF3_all.pdf comptree.pdf \
		habil.bib matmulF2_all.bb matmulF7_all.bb matmulF243_all.bb \
		matmulF17_all.bb matmulF2grease.bb matmulF2grease_scaled.bb \
		matmulF3_all.bb comptree.bb
	texer --pdf

# habil.pdf:	habil.dvi
# 	dvipdfm habil

habil.dvi:	*.tex matmulF2_all.pdf matmulF7_all.pdf matmulF243_all.pdf \
		matmulF17_all.pdf grease.pstex_t matmulF2grease.pdf \
		matmulF2grease_scaled.pdf matmulF3_all.pdf comptree.pdf \
		habil.bib matmulF2_all.bb matmulF7_all.bb matmulF243_all.bb \
		matmulF17_all.bb matmulF2grease.bb matmulF2grease_scaled.bb \
		matmulF3_all.bb comptree.bb
	texer

clean:
	rm -rf *.log habil.pdf habil.dvi *.aux *.bbl *.blg *.brf *.toc *.lot \
	       *.lof *.ps *.bibmd5sums *.out *.idx *.ind *.ilg *_low.eps \
	       *_all.eps *.eps grease.pstex grease.pstex_t \
	       grease_pstex.pdf comptree.pdf matmulF2_all.pdf *.bb \
	       matmulF2grease.pdf matmulF2grease_scaled.pdf matmulF3_all.pdf

matmulF2_all.eps:	matmulF2.dat plotF2.py
	plotF2.py

matmulF2_all.pdf:	matmulF2_all.eps
	epstopdf matmulF2_all.eps

matmulF2_all.bb:	matmulF2_all.eps
	grep Bounding matmulF2_all.eps >matmulF2_all.bb

matmulF3_all.eps:	matmulF3.dat plotF3.py
	plotF3.py

matmulF3_all.pdf:	matmulF3_all.eps
	epstopdf matmulF3_all.eps

matmulF3_all.bb:	matmulF3_all.eps
	grep Bounding matmulF3_all.eps >matmulF3_all.bb

matmulF7_all.eps:	matmulF7.dat plotF7.py
	plotF7.py

matmulF7_all.pdf:	matmulF7_all.eps
	epstopdf matmulF7_all.eps

matmulF7_all.bb:	matmulF7_all.eps
	grep Bounding matmulF7_all.eps >matmulF7_all.bb

matmulF243_all.eps:	matmulF243.dat plotF243.py
	plotF243.py

matmulF243_all.pdf:	matmulF243_all.eps
	epstopdf matmulF243_all.eps

matmulF243_all.bb:	matmulF243_all.eps
	grep Bounding matmulF243_all.eps >matmulF243_all.bb

matmulF2grease.eps:	matmulF2grease.dat plotF2grease.py
	plotF2grease.py

matmulF2grease.pdf:	matmulF2grease.eps
	epstopdf matmulF2grease.eps

matmulF2grease.bb:	matmulF2grease.eps
	grep Bounding matmulF2grease.eps >matmulF2grease.bb

matmulF2grease_scaled.pdf:	matmulF2grease_scaled.eps
	epstopdf matmulF2grease_scaled.eps

matmulF2grease_scaled.bb:	matmulF2grease_scaled.eps
	grep Bounding matmulF2grease_scaled.eps >matmulF2grease_scaled.bb

matmulF17_all.eps:	matmulF17.dat plotF17.py
	plotF17.py

matmulF17_all.pdf:	matmulF17_all.eps
	epstopdf matmulF17_all.eps

matmulF17_all.bb:	matmulF17_all.eps
	grep Bounding matmulF17_all.eps >matmulF17_all.bb

grease.pstex_t:	grease.fig
	fig2dev -L pstex grease.fig grease.pstex
	fig2dev -L pstex_t grease.fig grease.pstex_t
	cp grease.pstex grease_pstex.eps
	epstopdf grease_pstex.eps
	grep Bounding grease_pstex.eps >grease_pstex.bb

comptree.eps:	comptree.fig
	fig2dev -L eps comptree.fig comptree.eps

comptree.pdf:	comptree.eps
	epstopdf comptree.eps

comptree.bb:	comptree.eps
	grep Bounding comptree.eps >comptree.bb
