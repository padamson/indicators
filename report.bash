#!/bin/bash

./gold-oil-ratio.bash
cd reports
report=`ls -t *.eps | head -1`
cd ..
echo "inserting $report into report"
sed "s/GOLD-OIL-RATIO-EPS/$report/" templates/report.tex > report.tex
make
make pdf
datetime=`date +%H%M.%S-%m-%d-%Y`
mv report.pdf reports/report-$datetime.pdf
make clean
rm report.tex
