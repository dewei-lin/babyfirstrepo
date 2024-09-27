For this submission
=======

To build the R image:

docker build -t bios611-a3-image .

To knit the file:

docker run -v $(pwd):/usr/src/app -it bios611-a3-image

The output:

report.html
