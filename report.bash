#!/bin/bash

#./gold-oil-ratio.bash
cd plots
cciplot=`ls -t cci*.eps | head -1`
cotplot=`ls -t cot*.eps | head -1`
dollarplot=`ls -t dollar*.eps | head -1`
eemplot=`ls -t eem*.eps | head -1`
gorplot=`ls -t gold-oil-ratio*.eps | head -1`
maplot=`ls -t ma*.eps | head -1`
peplot=`ls -t pe*.eps | head -1`
uiplot=`ls -t ui*.eps | head -1`
cd ..
mkdir -p scratch
cd scratch
i=1
cp ../templates/report.tex report.1
for file in $cciplot $cotplot $dollarplot $eemplot $gorplot $maplot $peplot $uiplot; do
  echo "inserting $file into report"
  sed "s/PLOT$i/$file/" report.1 > report.2
  mv report.2 report.1
  #sed "s/GOLD-OIL-RATIO-EPS/$plot/" templates/report.tex > report.tex
  i=`expr $i + 1`
done
mv report.1 report.tex
cp ../Makefile .
make
make pdf
datetime=`date +%H%M.%S-%m-%d-%Y`
mkdir -p ../reports
mv report.pdf ../reports/report-$datetime.pdf
make clean
rm report.tex
cd ..

