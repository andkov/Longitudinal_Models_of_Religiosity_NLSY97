<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<title>Reproducible Research</title>





<style type="text/css">
body, td {
   font-family: sans-serif;
   background-color: white;
   font-size: 13px;
}

body {
  max-width: 800px;
  margin: auto;
  line-height: 20px;
}

tt, code, pre {
   font-family: 'DejaVu Sans Mono', 'Droid Sans Mono', 'Lucida Console', Consolas, Monaco, monospace;
}

h1 { 
   font-size:2.2em; 
}

h2 { 
   font-size:1.8em; 
}

h3 { 
   font-size:1.4em; 
}

h4 { 
   font-size:1.0em; 
}

h5 { 
   font-size:0.9em; 
}

h6 { 
   font-size:0.8em; 
}

a:visited {
   color: rgb(50%, 0%, 50%);
}

pre, img {
  max-width: 100%;
}

pre code {
   display: block; padding: 0.5em;
}

code {
  font-size: 92%;
  border: 1px solid #ccc;
}

code[class] {
  background-color: #F8F8F8;
}

table, td, th {
  border: none;
}

blockquote {
   color:#666666;
   margin:0;
   padding-left: 1em;
   border-left: 0.5em #EEE solid;
}

hr {
   height: 0px;
   border-bottom: none;
   border-top-width: thin;
   border-top-style: dotted;
   border-top-color: #999999;
}

@media print {
   * { 
      background: transparent !important; 
      color: black !important; 
      filter:none !important; 
      -ms-filter: none !important; 
   }

   body { 
      font-size:12pt; 
      max-width:100%; 
   }
       
   a, a:visited { 
      text-decoration: underline; 
   }

   hr { 
      visibility: hidden;
      page-break-before: always;
   }

   pre, blockquote { 
      padding-right: 1em; 
      page-break-inside: avoid; 
   }

   tr, img { 
      page-break-inside: avoid; 
   }

   img { 
      max-width: 100% !important; 
   }

   @page :left { 
      margin: 15mm 20mm 15mm 10mm; 
   }
     
   @page :right { 
      margin: 15mm 10mm 15mm 20mm; 
   }

   p, h2, h3 { 
      orphans: 3; widows: 3; 
   }

   h2, h3 { 
      page-break-after: avoid; 
   }
}
</style>



</head>

<body>
<p>&lt;!DOCTYPE html&gt;
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/></p>

<p><title>Reproducible Research</title></p>

<style type="text/css">
body, td {
   font-family: sans-serif;
   background-color: white;
   font-size: 13px;
}

body {
  max-width: 800px;
  margin: auto;
  line-height: 20px;
}

tt, code, pre {
   font-family: 'DejaVu Sans Mono', 'Droid Sans Mono', 'Lucida Console', Consolas, Monaco, monospace;
}

h1 { 
   font-size:2.2em; 
}

h2 { 
   font-size:1.8em; 
}

h3 { 
   font-size:1.4em; 
}

h4 { 
   font-size:1.0em; 
}

h5 { 
   font-size:0.9em; 
}

h6 { 
   font-size:0.8em; 
}

a:visited {
   color: rgb(50%, 0%, 50%);
}

pre, img {
  max-width: 100%;
}

pre code {
   display: block; padding: 0.5em;
}

code {
  font-size: 92%;
  border: 1px solid #ccc;
}

code[class] {
  background-color: #F8F8F8;
}

table, td, th {
  border: none;
}

blockquote {
   color:#666666;
   margin:0;
   padding-left: 1em;
   border-left: 0.5em #EEE solid;
}

hr {
   height: 0px;
   border-bottom: none;
   border-top-width: thin;
   border-top-style: dotted;
   border-top-color: #999999;
}

@media print {
   * { 
      background: transparent !important; 
      color: black !important; 
      filter:none !important; 
      -ms-filter: none !important; 
   }

   body { 
      font-size:12pt; 
      max-width:100%; 
   }
       
   a, a:visited { 
      text-decoration: underline; 
   }

   hr { 
      visibility: hidden;
      page-break-before: always;
   }

   pre, blockquote { 
      padding-right: 1em; 
      page-break-inside: avoid; 
   }

   tr, img { 
      page-break-inside: avoid; 
   }

   img { 
      max-width: 100% !important; 
   }

   @page :left { 
      margin: 15mm 20mm 15mm 10mm; 
   }
     
   @page :right { 
      margin: 15mm 10mm 15mm 20mm; 
   }

   p, h2, h3 { 
      orphans: 3; widows: 3; 
   }

   h2, h3 { 
      page-break-after: avoid; 
   }
}
</style>

<p></head></p>

<p><body></p>

<p>&lt;!DOCTYPE html&gt;
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/></p>

<p><title>Reproducible Research</title></p>

<style type="text/css">
body, td {
   font-family: sans-serif;
   background-color: white;
   font-size: 13px;
}

body {
  max-width: 800px;
  margin: auto;
  line-height: 20px;
}

tt, code, pre {
   font-family: 'DejaVu Sans Mono', 'Droid Sans Mono', 'Lucida Console', Consolas, Monaco, monospace;
}

h1 { 
   font-size:2.2em; 
}

h2 { 
   font-size:1.8em; 
}

h3 { 
   font-size:1.4em; 
}

h4 { 
   font-size:1.0em; 
}

h5 { 
   font-size:0.9em; 
}

h6 { 
   font-size:0.8em; 
}

a:visited {
   color: rgb(50%, 0%, 50%);
}

pre, img {
  max-width: 100%;
}

pre code {
   display: block; padding: 0.5em;
}

code {
  font-size: 92%;
  border: 1px solid #ccc;
}

code[class] {
  background-color: #F8F8F8;
}

table, td, th {
  border: none;
}

blockquote {
   color:#666666;
   margin:0;
   padding-left: 1em;
   border-left: 0.5em #EEE solid;
}

hr {
   height: 0px;
   border-bottom: none;
   border-top-width: thin;
   border-top-style: dotted;
   border-top-color: #999999;
}

@media print {
   * { 
      background: transparent !important; 
      color: black !important; 
      filter:none !important; 
      -ms-filter: none !important; 
   }

   body { 
      font-size:12pt; 
      max-width:100%; 
   }
       
   a, a:visited { 
      text-decoration: underline; 
   }

   hr { 
      visibility: hidden;
      page-break-before: always;
   }

   pre, blockquote { 
      padding-right: 1em; 
      page-break-inside: avoid; 
   }

   tr, img { 
      page-break-inside: avoid; 
   }

   img { 
      max-width: 100% !important; 
   }

   @page :left { 
      margin: 15mm 20mm 15mm 10mm; 
   }
     
   @page :right { 
      margin: 15mm 10mm 15mm 20mm; 
   }

   p, h2, h3 { 
      orphans: 3; widows: 3; 
   }

   h2, h3 { 
      page-break-after: avoid; 
   }
}
</style>

<p></head></p>

<p><body></p>

<p>###################################</p>

<h3>Reproducible Research</h3>

<p>###################################</p>

<h1>Importing the raw data from the NLS Investigator download object</h1>

<p>###################################</p>

<h1>Clear memory from previous runs</h1>

<p>base::rm(list=base::ls(all=TRUE))</p>

<p>#####################################</p>

<h2>@knitr LoadData</h2>

<p>###################################</p>

<h1>Load the necessary packages.</h1>

<p>base::require(base)
base::require(knitr)
base::require(markdown)
base::require(testit)
base::require(plyr)
base::require(reshape2)
base::require(stringr)</p>

<p>#################################</p>

<h3>Declaration of objects</h3>

<h1>Variables, which values that DON&#39;T change with time - time invariant (TI) variables</h1>

<p>TIvars&lt;-c(&ldquo;sample&rdquo;, &ldquo;id&rdquo;, &ldquo;sex&rdquo;,&ldquo;race&rdquo;, &ldquo;bmonth&rdquo;,&ldquo;byear&rdquo;,  &#39;attendPR&#39;, &ldquo;relprefPR&rdquo;, &ldquo;relraisedPR&rdquo;)</p>

<p>###########################</p>

<h3>Import the data</h3>

<p>pathDir&lt;-file.path(getwd()) # define path for project root directory</p>

<h1>Links to the data source</h1>

<p>tagset&lt;-c(&ldquo;NLSY97_Religiosity_20042014&rdquo;) #&ldquo;Database_ResponseOfInterest_DateOfDownload&rdquo;
pathDataFolder&lt;-file.path(&ldquo;./Data/Extracts&rdquo;,tagset)
pathDataSource&lt;-file.path(pathDataFolder,paste0(tagset,&ldquo;.csv&rdquo;)) 
pathDataSourceLabels&lt;-file.path(pathDataFolder,paste0(tagset,&ldquo;.dct&rdquo;))</p>

<h1>reading in the data</h1>

<p>dsSource&lt;-read.csv(pathDataSource,header=TRUE, skip=0,sep=&ldquo;,&rdquo;)
varOrig&lt;-ncol(dsSource) # Original number of variables in the NLS download
dsSource[&ldquo;T6650500&rdquo;]&lt;-NULL # Remove version number for cleaner dataset</p>

<h1>NLSY97 variable id are linked to the descriptive label in the file dictionary file &ldquo;NLSY97_Religiosity_20042014.dtc&rdquo;</h1>

<p>dsSourceLabels&lt;-read.csv(pathDataSourceLabels,header=TRUE, skip=0,nrow=varOrig, sep=&ldquo;&rdquo;)
dsSourceLabels$X.&lt;-NULL
dsSourceLabels&lt;-rename(dsSourceLabels,replace=c(&ldquo;infile&rdquo;=&ldquo;RNUM&rdquo;,&ldquo;dictionary&rdquo;=&ldquo;VARIABLE_TITLE&rdquo;)) # rename to match NLS Web Investigator format
dsSourceLabels&lt;-dsSourceLabels[dsSourceLabels$RNUM!=&ldquo;T6650500&rdquo;,] # remove version number from list of variables
dsSourceLabels&lt;-arrange(dsSourceLabels,VARIABLE_TITLE) # sort by Variable Title
write.table(dsSourceLabels, &ldquo;./Data/ItemMapping/dsSourceLabels.csv&rdquo;, sep=&ldquo;,&rdquo;)</p>

<p>############################</p>

<h2>@knitr TweakData</h2>

<h1>Using renaming template &ldquo;NLSY97_Religiosity_20042014.xlsx&rdquo; located in &ldquo;Documentation\data&rdquo; folder</h1>

<h1>rename the native variable names of NLSY97 (left) into custom chosen names for programming convenience (right)</h1>

<p>dsSource&lt;-rename(dsSource, c(
  &ldquo;R0323900&rdquo;=&ldquo;famrel_1997&rdquo;,
  &ldquo;R2165200&rdquo;=&ldquo;famrel_1998&rdquo;,
  &ldquo;R3483100&rdquo;=&ldquo;famrel_1999&rdquo;,
  &ldquo;R4881300&rdquo;=&ldquo;famrel_2000&rdquo;,
  &ldquo;S2977900&rdquo;=&ldquo;internet_2003&rdquo;,
  &ldquo;S4676700&rdquo;=&ldquo;internet_2004&rdquo;,
  &ldquo;S6308900&rdquo;=&ldquo;internet_2005&rdquo;,
  &ldquo;S8329800&rdquo;=&ldquo;internet_2006&rdquo;,
  &ldquo;T0737600&rdquo;=&ldquo;internet_2007&rdquo;,
  &ldquo;T2779700&rdquo;=&ldquo;internet_2008&rdquo;,
  &ldquo;T4494400&rdquo;=&ldquo;internet_2009&rdquo;,
  &ldquo;T6141400&rdquo;=&ldquo;internet_2010&rdquo;,
  &ldquo;T7635300&rdquo;=&ldquo;internet_2011&rdquo;,
  &ldquo;R1193900&rdquo;=&ldquo;agemon_1997&rdquo;,
  &ldquo;R2553400&rdquo;=&ldquo;agemon_1998&rdquo;,
  &ldquo;R3876200&rdquo;=&ldquo;agemon_1999&rdquo;,
  &ldquo;R5453600&rdquo;=&ldquo;agemon_2000&rdquo;,
  &ldquo;R7215900&rdquo;=&ldquo;agemon_2001&rdquo;,
  &ldquo;S1531300&rdquo;=&ldquo;agemon_2002&rdquo;,
  &ldquo;S2000900&rdquo;=&ldquo;agemon_2003&rdquo;,
  &ldquo;S3801000&rdquo;=&ldquo;agemon_2004&rdquo;,
  &ldquo;S5400900&rdquo;=&ldquo;agemon_2005&rdquo;,
  &ldquo;S7501100&rdquo;=&ldquo;agemon_2006&rdquo;,
  &ldquo;T0008400&rdquo;=&ldquo;agemon_2007&rdquo;,
  &ldquo;T2011000&rdquo;=&ldquo;agemon_2008&rdquo;,
  &ldquo;T3601400&rdquo;=&ldquo;agemon_2009&rdquo;,
  &ldquo;T5201300&rdquo;=&ldquo;agemon_2010&rdquo;,
  &ldquo;T6651200&rdquo;=&ldquo;agemon_2011&rdquo;,
  &ldquo;R1194100&rdquo;=&ldquo;ageyear_1997&rdquo;,
  &ldquo;R2553500&rdquo;=&ldquo;ageyear_1998&rdquo;,
  &ldquo;R3876300&rdquo;=&ldquo;ageyear_1999&rdquo;,
  &ldquo;R5453700&rdquo;=&ldquo;ageyear_2000&rdquo;,
  &ldquo;R7216000&rdquo;=&ldquo;ageyear_2001&rdquo;,
  &ldquo;S1531400&rdquo;=&ldquo;ageyear_2002&rdquo;,
  &ldquo;S2001000&rdquo;=&ldquo;ageyear_2003&rdquo;,
  &ldquo;S3801100&rdquo;=&ldquo;ageyear_2004&rdquo;,
  &ldquo;S5401000&rdquo;=&ldquo;ageyear_2005&rdquo;,
  &ldquo;S7501200&rdquo;=&ldquo;ageyear_2006&rdquo;,
  &ldquo;T0008500&rdquo;=&ldquo;ageyear_2007&rdquo;,
  &ldquo;T2011100&rdquo;=&ldquo;ageyear_2008&rdquo;,
  &ldquo;T3601500&rdquo;=&ldquo;ageyear_2009&rdquo;,
  &ldquo;T5201400&rdquo;=&ldquo;ageyear_2010&rdquo;,
  &ldquo;T6651300&rdquo;=&ldquo;ageyear_2011&rdquo;,
  &ldquo;R1235800&rdquo;=&ldquo;sample&rdquo;,
  &ldquo;S0919700&rdquo;=&ldquo;todo_2002&rdquo;,
  &ldquo;S6317100&rdquo;=&ldquo;todo_2005&rdquo;,
  &ldquo;T2782200&rdquo;=&ldquo;todo_2008&rdquo;,
  &ldquo;T7637800&rdquo;=&ldquo;todo_2011&rdquo;,
  &ldquo;R4893900&rdquo;=&ldquo;happy_2000&rdquo;,
  &ldquo;S0921100&rdquo;=&ldquo;happy_2002&rdquo;,
  &ldquo;S4682200&rdquo;=&ldquo;happy_2004&rdquo;,
  &ldquo;S8332600&rdquo;=&ldquo;happy_2006&rdquo;,
  &ldquo;T2782900&rdquo;=&ldquo;happy_2008&rdquo;,
  &ldquo;T6144000&rdquo;=&ldquo;happy_2010&rdquo;,
  &ldquo;R4893600&rdquo;=&ldquo;nervous_2000&rdquo;,
  &ldquo;S0920800&rdquo;=&ldquo;nervous_2002&rdquo;,
  &ldquo;S4681900&rdquo;=&ldquo;nervous_2004&rdquo;,
  &ldquo;S8332300&rdquo;=&ldquo;nervous_2006&rdquo;,
  &ldquo;T2782600&rdquo;=&ldquo;nervous_2008&rdquo;,
  &ldquo;T6143700&rdquo;=&ldquo;nervous_2010&rdquo;,
  &ldquo;R4893700&rdquo;=&ldquo;calm_2000&rdquo;,
  &ldquo;S0920900&rdquo;=&ldquo;calm_2002&rdquo;,
  &ldquo;S4682000&rdquo;=&ldquo;calm_2004&rdquo;,
  &ldquo;S8332400&rdquo;=&ldquo;calm_2006&rdquo;,
  &ldquo;T2782700&rdquo;=&ldquo;calm_2008&rdquo;,
  &ldquo;T6143800&rdquo;=&ldquo;calm_2010&rdquo;,
  &ldquo;R4894000&rdquo;=&ldquo;depressed_2000&rdquo;,
  &ldquo;S0921200&rdquo;=&ldquo;depressed_2002&rdquo;,
  &ldquo;S4682300&rdquo;=&ldquo;depressed_2004&rdquo;,
  &ldquo;S8332700&rdquo;=&ldquo;depressed_2006&rdquo;,
  &ldquo;T2783000&rdquo;=&ldquo;depressed_2008&rdquo;,
  &ldquo;T6144100&rdquo;=&ldquo;depressed_2010&rdquo;,
  &ldquo;R4893800&rdquo;=&ldquo;blue_2000&rdquo;,
  &ldquo;S0921000&rdquo;=&ldquo;blue_2002&rdquo;,
  &ldquo;S4682100&rdquo;=&ldquo;blue_2004&rdquo;,
  &ldquo;S8332500&rdquo;=&ldquo;blue_2006&rdquo;,
  &ldquo;T2782800&rdquo;=&ldquo;blue_2008&rdquo;,
  &ldquo;T6143900&rdquo;=&ldquo;blue_2010&rdquo;,
  &ldquo;R0552400&rdquo;=&ldquo;attendPR&rdquo;,
  &ldquo;R4893400&rdquo;=&ldquo;attend_2000&rdquo;,
  &ldquo;R6520100&rdquo;=&ldquo;attend_2001&rdquo;,
  &ldquo;S0919300&rdquo;=&ldquo;attend_2002&rdquo;,
  &ldquo;S2987800&rdquo;=&ldquo;attend_2003&rdquo;,
  &ldquo;S4681700&rdquo;=&ldquo;attend_2004&rdquo;,
  &ldquo;S6316700&rdquo;=&ldquo;attend_2005&rdquo;,
  &ldquo;S8331500&rdquo;=&ldquo;attend_2006&rdquo;,
  &ldquo;T0739400&rdquo;=&ldquo;attend_2007&rdquo;,
  &ldquo;T2781700&rdquo;=&ldquo;attend_2008&rdquo;,
  &ldquo;T4495000&rdquo;=&ldquo;attend_2009&rdquo;,
  &ldquo;T6143400&rdquo;=&ldquo;attend_2010&rdquo;,
  &ldquo;T7637300&rdquo;=&ldquo;attend_2011&rdquo;,
  &ldquo;S1225400&rdquo;=&ldquo;computer_2002&rdquo;,
  &ldquo;T1049900&rdquo;=&ldquo;computer_2007&rdquo;,
  &ldquo;T3145100&rdquo;=&ldquo;computer_2008&rdquo;,
  &ldquo;T4565400&rdquo;=&ldquo;computer_2009&rdquo;,
  &ldquo;T6209600&rdquo;=&ldquo;computer_2010&rdquo;,
  &ldquo;T7707000&rdquo;=&ldquo;computer_2011&rdquo;,
  &ldquo;S1225500&rdquo;=&ldquo;tv_2002&rdquo;,
  &ldquo;T1050000&rdquo;=&ldquo;tv_2007&rdquo;,
  &ldquo;T3145200&rdquo;=&ldquo;tv_2008&rdquo;,
  &ldquo;T4565500&rdquo;=&ldquo;tv_2009&rdquo;,
  &ldquo;T6209700&rdquo;=&ldquo;tv_2010&rdquo;,
  &ldquo;T7707100&rdquo;=&ldquo;faith_2011&rdquo;,
  &ldquo;T2782400&rdquo;=&ldquo;faith_2008&rdquo;,
  &ldquo;T7638000&rdquo;=&ldquo;bmonth&rdquo;,
  &ldquo;R0536401&rdquo;=&ldquo;bmonth&rdquo;,
  &ldquo;R0536402&rdquo;=&ldquo;byear&rdquo;,
  &ldquo;R1482600&rdquo;=&ldquo;race&rdquo;,
  &ldquo;R0536300&rdquo;=&ldquo;sex&rdquo;,
  &ldquo;R0000100&rdquo;=&ldquo;id&rdquo;,
  &ldquo;T2111500&rdquo;=&ldquo;bornagain_2008&rdquo;,
  &ldquo;T6759400&rdquo;=&ldquo;bornagain_2011&rdquo;,
  &ldquo;S0919600&rdquo;=&ldquo;decisions_2002&rdquo;,
  &ldquo;S6317000&rdquo;=&ldquo;decisions_2005&rdquo;,
  &ldquo;T2782100&rdquo;=&ldquo;decisions_2008&rdquo;,
  &ldquo;T7637700&rdquo;=&ldquo;decisions_2011&rdquo;,
  &ldquo;S0919500&rdquo;=&ldquo;obeyed_2002&rdquo;,
  &ldquo;S6316900&rdquo;=&ldquo;obeyed_2005&rdquo;,
  &ldquo;T2782000&rdquo;=&ldquo;obeyed_2008&rdquo;,
  &ldquo;T7637600&rdquo;=&ldquo;obeyed_2011&rdquo;,
  &ldquo;S5532800&rdquo;=&ldquo;relpref_2005&rdquo;,
  &ldquo;T2111400&rdquo;=&ldquo;relpref_2008&rdquo;,
  &ldquo;T6759300&rdquo;=&ldquo;relpref_2011&rdquo;,
  &ldquo;S0919400&rdquo;=&ldquo;values_2002&rdquo;,
  &ldquo;S6316800&rdquo;=&ldquo;values_2005&rdquo;,
  &ldquo;T2781900&rdquo;=&ldquo;values_2008&rdquo;,
  &ldquo;T7637500&rdquo;=&ldquo;values_2011&rdquo;,
  &ldquo;S0919800&rdquo;=&ldquo;pray_2002&rdquo;,
  &ldquo;S6317200&rdquo;=&ldquo;pray_2005&rdquo;,
  &ldquo;T2782300&rdquo;=&ldquo;pray_2008&rdquo;,
  &ldquo;T7637900&rdquo;=&ldquo;pray_2011&rdquo;,
  &ldquo;R0552300&rdquo;=&ldquo;relprefPR&rdquo;,
  &ldquo;R0552200&rdquo;=&ldquo;relraisedPR&rdquo;</p>

<p>))</p>

<h1>head(dsSource[,c(&ldquo;id&rdquo;,&ldquo;relprefPR&rdquo;)],20)</h1>

<h1>Remove illegal values. See codebook for description of missingness</h1>

<p>illegal&lt;-as.integer(c(-5:-1,997,998,999))
SourceVariables&lt;-names(dsSource)</p>

<p>for( variable in SourceVariables ){
    dsSource[,variable]=ifelse(dsSource[,variable] %in% c(-5:-1),NA,dsSource[,variable])</p>

<p>}</p>

<h1>recode negativale worded question so that :  1 - more religious, 0 - less religious</h1>

<p>for (item in c(&ldquo;todo&rdquo;,&ldquo;values&rdquo;)){
  for (year in c(2002,2005,2008,2011)){
  itemyear&lt;-(paste0(item , &ldquo;_&rdquo; , year))
  dsSource[,itemyear]=ifelse( (dsSource[,itemyear] %in% c(1)) , 0 ,ifelse((dsSource[,itemyear] %in% c(0)),1,NA))
}
}</p>

<h1>Include only records with a valid birth year</h1>

<p>dsSource &lt;- dsSource[dsSource$byear %in% 1980:1984, ]</p>

<p>#Include only records with a valid ID
dsSource &lt;- dsSource[dsSource$id != &ldquo;V&rdquo;, ]
dsSource$id &lt;- as.integer(dsSource$id)</p>

<h1>remove all but one dataset</h1>

<h1>rm(list=setdiff(ls(), &ldquo;dsSource&rdquo;))</h1>

<p>#################################</p>

<h2>Preparing the common Long dataset</h2>

<p>ds&lt;-dsSource</p>

<h2>id.vars declares MEASURED variables (as opposed to RESPONSE variable)</h2>

<p>dsLong &lt;- reshape2::melt(ds, id.vars=TIvars)</p>

<p>##############
head(dsLong[dsLong$id==1,],20)</p>

<h1>create varaible &ldquo;year&rdquo; by stripping the automatic ending in TV variables&#39; names</h1>

<h2>?? How to read off 4 characters from right with reshape/plyr?</h2>

<p>dsLong$year&lt;-str_sub(dsLong$variable,-4,-1) </p>

<h1>the automatic ending in TV variables&#39; names</h1>

<h1>?? how to automate the creation of strings?</h1>

<p>timepattern&lt;-c(&ldquo;_1997&rdquo;, &ldquo;_1998&rdquo;, &ldquo;_1999&rdquo;, &ldquo;_2000&rdquo;, &ldquo;_2001&rdquo;, &ldquo;_2002&rdquo;, &ldquo;_2003&rdquo;, &ldquo;_2004&rdquo;, &ldquo;_2005&rdquo;, &ldquo;_2006&rdquo;,&ldquo;_2007&rdquo;, &ldquo;_2008&rdquo;, &ldquo;_2009&rdquo;, &ldquo;_2010&rdquo;, &ldquo;_2011&rdquo;)</p>

<h1>Strip off the automatic ending</h1>

<p>for (i in timepattern){
dsLong$variable &lt;- gsub(pattern=i, replacement=&ldquo;&rdquo;, x=dsLong$variable) 
}</p>

<h1>Convert to a number.</h1>

<p>dsLong$year &lt;- as.integer(dsLong$year) </p>

<h1>reorder for easier inspection</h1>

<p>dsLong&lt;-dsLong[with(dsLong, order(id,variable)), ] # alternative sorting to plyr</p>

<h1>view the long data for one person</h1>

<p>print(dsLong[dsLong$id==1,]) </p>

<p>##############################</p>

<h2>Create individual long datasets, one per TV variable</h2>

<h2>?? how to loop over the dataset?</h2>

<h2>Time invariant (TI) variables are :</h2>

<p>print (TIvars)</p>

<h2>Time variant (TV) variables are :</h2>

<p>TVvars&lt;-unique(dsLong$variable)</p>

<h1>TVvars&lt;-c(&ldquo;attend&rdquo;,&ldquo;tv&rdquo;) # to test on a few variables</h1>

<h1>Create a long (L) dataset (ds) with time invariant (TI) variables</h1>

<p>dsLTI&lt;-subset(dsLong,subset=(dsLong$variable==&ldquo;agemon&rdquo;)) # agemon because it has 1997:2011
dsLTI&lt;-rename(dsLTI,replace=c(&ldquo;value&rdquo;=&ldquo;agemon&rdquo;))
dsLTI&lt;-dsLTI[c(TIvars,&ldquo;year&rdquo;)] # select only TI variables</p>

<h2>Strip off each TV from dsLong to merge later</h2>

<p>for ( i in TVvars){
dstemp&lt;-subset(dsLong,subset=(dsLong$variable==i))
dstemp&lt;-rename(dstemp,replace=c(&ldquo;value&rdquo;=i))
dstemp&lt;-dstemp[c(&ldquo;id&rdquo;,&ldquo;year&rdquo;,i)]
dsLTI&lt;-merge(x=dsLTI,y=dstemp,by=c(&ldquo;id&rdquo;,&ldquo;year&rdquo;),all.x=TRUE)
}</p>

<h2>Merging datasets</h2>

<h1>Outer join: merge(x = df1, y = df2, by = &ldquo;CustomerId&rdquo;, all = TRUE)</h1>

<h1>Left outer: merge(x = df1, y = df2, by = &ldquo;CustomerId&rdquo;, all.x=TRUE)</h1>

<h1>Right outer: merge(x = df1, y = df2, by = &ldquo;CustomerId&rdquo;, all.y=TRUE)</h1>

<h1>Cross join: merge(x = df1, y = df2, by = NULL)</h1>

<h1>OPTIONAL. Order variables in dsL to match the order in &ldquo;NLSY97_Religiosity_20042012.xlsx&rdquo;</h1>

<p>dsL_order&lt;-c(&ldquo;sample&rdquo;  ,&ldquo;id&rdquo;    ,&ldquo;sex&rdquo;  ,&ldquo;race&rdquo; ,&ldquo;bmonth&rdquo;   ,&ldquo;byear&rdquo;    ,&ldquo;attendPR&rdquo; ,&ldquo;relprefPR&rdquo;    ,&ldquo;relraisedPR&rdquo;  ,&ldquo;year&rdquo;,&ldquo;agemon&rdquo;    ,&ldquo;ageyear&rdquo;  ,&ldquo;famrel&rdquo;   ,&ldquo;attend&rdquo;   ,&ldquo;values&rdquo;   ,&ldquo;todo&rdquo; ,&ldquo;obeyed&rdquo;   ,&ldquo;pray&rdquo; ,&ldquo;decisions&rdquo;    ,&ldquo;relpref&rdquo;  ,&ldquo;bornagain&rdquo;    ,&ldquo;faith&rdquo;    ,&ldquo;calm&rdquo; ,&ldquo;blue&rdquo; ,&ldquo;happy&rdquo;    ,&ldquo;depressed&rdquo;    ,&ldquo;nervous&rdquo;  ,&ldquo;tv&rdquo;   ,&ldquo;computer&rdquo; ,&ldquo;internet&rdquo;)
dsL&lt;-dsLTI[dsL_order]</p>

<p>print(dsL[dsLong$id==1,]) 
pathdsL &lt;- file.path(getwd(),&ldquo;Data/Derived/dsL.csv&rdquo;)
write.csv(dsL,pathdsL,  row.names=FALSE)</p>

<h1># remove all but one dataset</h1>

<p>rm(list=setdiff(ls(), c(&ldquo;TIvars&rdquo;,&ldquo;TVvars&rdquo;,&ldquo;dsL&rdquo;)))</p>

<p></body></p>

<p></html></p>

<p></body></p>

<p></html></p>

</body>

</html>
