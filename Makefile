.PHONY: clean ensure_logs ensure_figures all

# Ensure that the logs directory exists
ensure_logs:
	mkdir -p logs

# Ensure that the figures directory exists
ensure_figures:
	mkdir -p figures

clean:
	rm -f data/distinct_case.csv data/unique_case.csv
	rm -rf logs/*
	rm -rf figures/*
	rm -f report.html

all: report.html


data/distinct_case.csv: data/source_data.csv analysis1.R utils.R
	Rscript analysis1.R

figures/plot1: data/source_data.csv analysis1.R utils.R
	Rscript analysis1.R

figures/plot2: data/source_data.csv analysis1.R utils.R
	Rscript analysis1.R

data/unique_case.csv: data/source_data.csv analysis1.R utils.R
	Rscript analysis1.R

logs/logs_output1: data/source_data.csv analysis1.R utils.R
	Rscript analysis1.R

figures/plot3: data/unique_case.csv analysis2.R
	Rscript analysis2.R

logs/logs_output2: data/unique_case.csv analysis2.R
	Rscript analysis2.R

report.html: figures/plot1 figures/plot2 figures/plot3 logs/logs_output1 logs/logs_output2
	Rscript -e "rmarkdown::render('report.Rmd', output_file='report.html')"





