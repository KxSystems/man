/
title: makefile for man.q
author: stephen@kx.com
date: 2019.12.29
\

tf:{read0`$":texts/",x,".txt"}			/ text from

s2l:{ / strings to list
  s:{"\"",x,"\""}each ssr[;"\\";"\\\\"]each x;
  s[0]:"(",s[0];
  "  ",/:s,'";)"where(count[s]-1),1 }

s,:("/ man.q ",string .z.d;"";"\\d .man";"")

s,:tf"head" 

/ operators by glyph
s,:("";"/operators by glyph")
s,:enlist"d,:{x!\"ref/\",/:y}. flip\" \"vs/:cmb each"
s,:s2l tf"glyphs"

/ operators by name
s,:("";"/operators by name")
s,:enlist"d,:{x!\"ref/\",/:d4s'[x],\\:\"/\"}lower"
s,:s2l tf"operators"

/ reserved words
s,:("";"/reserved words")
s,:enlist"d,:{x!\"ref/\",/:x}string asc .Q.res,key[`.q]except`ww"

/ namespaces
s,:("";"/namespaces")
s,:enlist"d,:(lower string`.h`.j`.Q`.z)!\"ref/dot\",/:\"hjqz\""

/ cmd-line options
s,:("";"/cmd-line options")
s,:enlist"d,:{x[;0 1]!\"basics/cmdline/#\",/:lower x}d4s each"
s,:s2l tf"cmdline"

/ system commands
s,:("";"/system commands")
s,:enlist"niq:(\"**\";csv)0:"
s,:s2l read0`:texts/syscmds.csv
s,:enlist"d,:first[niq]!\"basics/syscmds/#\",/:{d4s cmb trim except[;\"\\\\&/\"]x}each lower\" \"sv/:flip niq"

/ special pages
s,:("";"/special pages")
s,:enlist"d,:(!). flip{\" \"vs cmb trim x}each"
s,:s2l tf"special"

s,:("";"\\d .";"")

s,:tf"tail"

/ write man.q
`:man.q  0: s
exit 0