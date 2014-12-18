(* ::Package:: *)

Import["TwoAxisDateListPlot.m"];
begindate = "Jan. 1, 2009"; 
sandpdata = FinancialData["SP500", begindate]; 
golddata = FinancialData["GLD", begindate]; 
oildata = FinancialData["USO", begindate]; 
ratiodata = Thread[{golddata[[All,1]], golddata[[All,2]]/oildata[[All,2]]}]; 
(*LeftPlot[data_, name_, title_, text_] := DateListPlot[data, Joined -> True, 
    PlotStyle -> Blue, ImagePadding -> 50, Frame -> {True, True, True, False}, 
    FrameStyle -> {Automatic, Blue, Automatic, Automatic}, 
    FrameLabel -> {"Date", name, title}, ImageSize -> 500, 
    Prolog -> {Text[Style[text, Medium, Bold, Red], 
       {data[[(Length[data] - Mod[Length[data], 2])/2,1]], 0.8*Min[data[[All,2]]]}, 
       Center]}]; 
RightPlot[data_, name_] := DateListPlot[data, Joined -> True, PlotStyle -> Red, 
    ImagePadding -> 50, Axes -> False, Frame -> {False, False, False, True}, 
    FrameTicks -> {None, None, None, All}, FrameStyle -> 
     {Automatic, Automatic, Automatic, Red}, ImageSize -> 500, 
    FrameLabel -> {"", "", "", name}]; 
sandpplot = LeftPlot[sandpdata, "S&P 500", "S&P 500 Index and GLD/OIL Ratio", 
    "Spike in GLD/OIL ratio indicates drop in S&P 500"]; 
ratioplot = RightPlot[ratiodata, "GLD/OIL"];
sandpRatioPlot = Overlay[{sandpplot, ratioplot}]; 
*)
sandpRatioPlot = TwoAxisDateListPlot[ratiodata,sandpdata,ImageSize->400,
  FrameLabel->{"",Style["S&P 500",Red,Bold],"",Style["GLD/USO",Black,Bold]},
  PlotStyle->{{Thick,Black},{Thick,Red}}
]
date = DateString[{"Hour24", "Minute", ".", "Second", "-", "MonthShort", "-", "Day", 
     "-", "Year"}]; 
filename = StringJoin[$InitialDirectory,"/plots/gold-oil-ratio-", 
    date, ".eps"]; 
Export[filename, sandpRatioPlot]; 
Exit[]
