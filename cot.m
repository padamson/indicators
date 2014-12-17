(* ::Package:: *)

Import["TwoAxisDateListPlot.m"];
commodities = {"oil", "corn", "wheat", "beans"};
etfs = {"USO", "CORN", "WEAT", "SOYB"};
(* edit next line, i <= 4, to include corn, wheat, and soybean CoT plots *)
For[i=1,i<=1,i++,
  datafile = StringJoin[$InitialDirectory, "/scratch/cot_", commodities[[i]], ".csv"];
  data = Import[datafile, "DateStringFormat" -> {"Year", "-", "Month", "-", "Day"}];
  data2 = Table[{data[[i, 2]], 100*N[(data[[i, 4]] - data[[i, 5]])/data[[i, 3]]]}, {i, Length[data]}];
  etfdata = FinancialData[etfs[[i]], data2[[Length[data2], 1]]];
  (*
  etfplot = DateListPlot[etfdata, Joined -> True, PlotStyle -> Blue, 
    ImagePadding -> 50, Frame -> {True, True, True, False}, 
    FrameStyle -> {Automatic, Blue, Automatic, Automatic}, 
    FrameLabel -> {"Date", etfs[[i]],
    StringJoin["Confidence of Traders (CoT) and ", etfs[[i]], " ETF Price"]}, ImageSize -> 500];
  cbotplot = DateListPlot[data2, 
    Joined -> True, 
    Epilog -> Line[{{data2[[1, 1]], 0}, {data2[[Length[data2], 1]], 0}}], 
    PlotStyle -> Red, ImagePadding -> 50, Axes -> False, 
    Frame -> {False, False, False, True}, 
    FrameTicks -> {None, None, None, All}, 
    FrameStyle -> {Automatic, Automatic, Automatic, Red}, 
    ImageSize -> 500, FrameLabel -> {"", "", "", "CoT"}];
  *)
  cotplot = TwoAxisDateListPlot[etfdata,data2,ImageSize->600,
    FrameLabel -> {"", Style["USO ETF", Red, Bold], "", Style["Confidence of Traders", Black, Bold]},
    PlotStyle -> {{Thick, Black}, {Thick, Red}}
  ];
  date = DateString[{"Hour24", "Minute", ".", "Second", "-", "MonthShort", "-", "Day", "-", "Year"}];
  filename = StringJoin[$InitialDirectory,"/plots/cot-", etfs[[i]], "-", date, ".eps"];
  (*Export[filename, Overlay[{etfplot, cbotplot}, ImageSize -> 500]]*)
  Export[filename, cotplot]
]
Exit[];

