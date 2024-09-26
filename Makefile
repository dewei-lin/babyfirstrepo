.PHONY: clean

clean:
	rm -f data/distinct_case.csv data/unique_case.csv
	rm -f logs/*
	rm -f figures/*

logs/logs_output1.txt figures/plot1.png figures/plot2.png data/distinct_case.csv data/unique_case.csv: \
  data/NYC_Dog_Licensing_Dataset_%.csv analysis1.R
	Rscript analysis1.R $*

logs/logs_output2.txt figures/plot3: data/unique_case.csv analysis2.R
	Rscript analysis2.R data/unique_case.csv

report.html: report.Rmd logs/logs_output1.txt logs/logs_output2.txt figures/plot1.png figures/plot2.png figures/plot3
	Rscript -e "rmarkdown::render('report.Rmd')"




