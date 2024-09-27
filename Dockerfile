FROM rocker/tidyverse:latest

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libxt-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libtiff5-dev \
    libcairo2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages('tidyverse', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('ggplot2', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('readr', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('rmarkdown', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('dplyr', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('tidyr', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('knitr', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('data.table', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('devtools', repos='https://cloud.r-project.org/')"

# Optionally install additional tools (e.g., git, vim)
RUN apt-get update && apt-get install -y git vim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy your project files into the container
COPY . /usr/src/app

# Set the command to run Makefile when the container starts
CMD ["make", "all"]