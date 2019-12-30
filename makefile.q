/
title: makefile for man.q
author: stephen@kx.com
date: 2019.12.30
\

tf:{read0`$":texts/",x}			/ text from file

s2l:{ / strings to list
  s:{"\"",x,"\""}each ssr[;"\\";"\\\\"]each x;
  s[0]:"(",s[0];
  "  ",/:s,'";)"where(count[s]-1),1 }

s,:enlist"/ man.q ",string .z.d  / file creation date

s,:tf"head.txt" 

/ operators by glyph
s,:("";"/operators by glyph")
s,:enlist".man.d,:.[!;]flip\" \"vs/:.man.cmb each"
s,:s2l tf"glyphs.txt"

/ operators by name
s,:("";"/operators by name")
s,:enlist".man.d,:{x!\"ref/\",/:.man.d4s'[x],\\:\"/\"}lower"
s,:s2l tf"operators.txt"

/ reserved words
s,:("";"/reserved words")
s,:enlist".man.d,:{x!\"ref/\",/:x}string asc .Q.res,key[`.q]except`ww"

/ namespaces 
s,:("";"/namespaces (case-sensitive but forgive .q)")
s,:enlist".man.d,:{.[!;](\".\",'x;\"ref/dot\",/:lower x)}\"hjmQqz\""

/namespace objects
s,:("";"/.h namespace")
s,:enlist".man.d,:.man.dc[\"ref/doth\";]"
s,:s2l tf"doth.csv"

s,:("";"/.j namespace")
s,:enlist".man.d,:.man.dc[\"ref/dotj\";]"
s,:s2l tf"dotj.csv"

s,:("";"/.Q namespace")
s,:enlist".man.d,:.man.dc[\"ref/dotq\";]"
s,:s2l tf"dotq.csv"

s,:("";"/.z namespace")
s,:enlist".man.d,:.man.dc[\"ref/dotz\";]"
s,:s2l tf"dotz.csv"

/ cmd-line options
s,:("";"/cmd-line options")
s,:enlist".man.d,:.man.dc[\"basics/cmdline\";]"
s,:s2l tf"cmdline.csv"

/ system commands
s,:("";"/system commands")
s,:enlist".man.d,:.man.dc[\"basics/syscmds\";]"
s,:s2l tf"syscmds.csv"

/ special pages
s,:("";"/special pages")
s,:enlist".man.d,:.[!;]flip{\" \"vs .man.cmb trim x}each"
s,:s2l tf"special.txt"

s,:tf"tail.txt"

/ write man.q
`:man.q  0: s
exit 0