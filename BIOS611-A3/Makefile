.PHONY: clean

clean:
	rm -f data/unique_case.csv analysis1.html analysis2.html

data/unique_case.csv: data/source_data.csv analysis1.Rmd
	Rscript -e "rmarkdown::render('analysis1.Rmd')"

analysis2.html: data/unique_case.csv analysis2.Rmd
	Rscript -e "rmarkdown::render('analysis2.Rmd')"
