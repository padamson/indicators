#!/bin/bash

./gold-oil-ratio.bash
cd plots
plot=`ls -t *.eps | head -1`
cd ..
echo "inserting $plot into report"
sed "s/GOLD-OIL-RATIO-EPS/$plot/" templates/report.tex > report.tex
make
make pdf
datetime=`date +%H%M.%S-%m-%d-%Y`
mv report.pdf reports/report-$datetime.pdf
make clean
rm report.tex
