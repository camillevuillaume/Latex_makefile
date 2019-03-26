.DELETE_ON_ERROR:

TARGET = main

all: $(TARGET).pdf

.PHONY: clean

clean:
	rm -f *.aux *.log *.bbl *.blg *.brf *.cb *.ind *.idx *.ilg *.inx *.ps *.dvi *.pdf *.toc *.out


%.pdf: %.ps
	ps2pdf $< 

%.ps: %.dvi
	dvi2ps $< 

%.dvi: %.aux %.bbl %.tex
	latex $< 
	while grep 'There were undefined references' $*.log ; do latex $< ; done

%.bbl: %.aux %.tex
	bibtex $< 

%.aux: %.tex
	latex $< 
