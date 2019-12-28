/ man.q 2019.12.28

\d .man

cmb:{x where 1b,1_(or)prior" "<>x}      / collapse multiple blanks
d4s:{@[x;where" "=x;:;"-"]}             / dash for space

HELP:"about/man/"                       / man "help"
ROOT:"https://code.kx.com/q/"           / documentation site

/operators by glyph
d,:{x!"ref/",/:y}. flip" "vs/:cmb each
  ("@   overloads/#at";
  "\\   overloads/#backslash";
  "#   overloads/#hash";
  ".   overloads/#dot";
  "$   overloads/#dollar";
  "!   overloads/#bang";
  "?   overloads/#query";
  "'   overloads/#quote";
  "':  overloads/#quotecolon";
  "/   overloads/#slash";
  "_   overloads/#underscore";
  "+   add";
  "-   subtract";
  "*   multiply";
  "%   divide";
  "=   equal";
  "<>  not-equal";
  "<   less-than";
  ">=  less-than";
  ">=  greater-than";
  "<=  greater-than";
  "&   lesser";
  "|   greater";
  "~   match";
  "^   fill";
  ",   join";
  "/:  maps/#each-left-and-each-right";
  "\\:  maps/#each-left-and-each-right")

/operators by name
d,:{x!"ref/",/:d4s'[x],\:"/"}lower
  ("Add";
  "Amend";
  "Apply";
  "Index";
  "Trap";
  "Cast";
  "Coalesce";
  "Compose";
  "Cond";
  "Cut";
  "Deal";
  "Roll";
  "Permute";
  "Delete";
  "Display";
  "Dict";
  "Divide";
  "Display";
  "Dynamic Load";
  "Drop";
  "Enkey";
  "Unkey";
  "Enumerate";
  "Enumeration";
  "Enum Extend";
  "Equal";
  "Exec";
  "File Binary";
  "File Text";
  "Fill";
  "Find";
  "Flip Splayed";
  "Greater";
  "Greater Than";
  "Identity";
  "Null";
  "Join";
  "Less Than";
  "Lesser";
  "Match";
  "Matrix Multiply";
  "Multiply";
  "Not Equal";
  "Pad";
  "Select";
  "Set Attribute";
  "Simple Exec";
  "Signal";
  "Subtract";
  "Take";
  "Tok";
  "Update";
  "Vector Conditional";
  "Over";
  "Scan";
  "Each Right";
  "Each Left";
  "Each";
  "Each Parallel";
  "Each Prior";
  "Case";
  "Compose")

/reserved words
d,:{x!"ref/",/:x}string asc key[`.q]except`ww

/namespaces
d,:(lower string`.h`.j`.Q`.z)!"ref/dot",/:"hjqz"

/cmd-line options
d,:{x[;0 1]!"basics/cmdline/#",/:lower x}d4s each
  ("-b blocked";
  "-c console size";
  "-C HTTP size";
  "-e error traps";
  "-E TLS Server Mode";
  "-g garbage collection";
  "-l log updates";
  "-L log sync";
  "-m memory domain";
  "-o UTC offset";
  "-p listening port";
  "-P display precision";
  "-q quiet mode";
  "-r replicate";
  "-s slaves";
  "-t timer ticks";
  "-T timeout";
  "-u disable syscmds";
  "-u usr-pwd local";
  "-U usr-pwd";
  "-w memory";
  "-W start week";
  "-z date format")

/system commands
niq:("**";csv)0:
  ("\\,abort";
  "\\a,tables";
  "\\b,views";
  "\\B,pending views";
  "\\c,console size";
  "\\c,change directory";
  "\\C,HTTP size";
  "\\d,directory";
  "\\e,error trap clients";
  "\\f,functions";
  "\\g,garbage collection mode";
  "\\l,load file or directory";
  "\\o,offset from UTC";
  "\\p,listening port";
  "\\P,precision";
  "\\r,replication master";
  "\\r,rename";
  "\\s,number of slaves";
  "\\S,random seed";
  "\\t,timer";
  "\\T,timeout";
  "\\t,time and space";
  "\\u,reload user password file";
  "\\v,variables";
  "\\w,workspace";
  "\\W,week offset";
  "\\x,expunge";
  "\\z,date parsing";
  "\\1 & \\2,redirect";
  "\\_,hide q code";
  "\\,terminate";
  "\\,toggle q/k";
  "\\\\,quit")
d,:first[niq]!"basics/syscmds/#",/:{d4s cmb trim except[;"\\&/"]x}each lower" "sv/:flip niq

/special pages
d,:(!). flip{" "vs cmb trim x}each
  ("adverbs    ref/iterators";
  "cmdline    basics/cmdline";
  "errors     basics/errors/";
  "datatypes  basics/datatypes";
  "debug      basics/debug";
  "help       about/man";
  "internal   basics/internal";
  "interfaces interfaces";
  "iterators  ref/iterators";
  "kb         kb";
  "syscmds    basics/syscmds";
  "wp         wp")

\d .

man:{[x]
  if[10<>type str:(),x;'`type];                                 / string?
  if[trim[str]~"--list";                                        / --list option
    m:{(1+max count each x)$'x}key .man.d;                      /   keys
    f:(system"c")[1] div count first m;                         /   fold
    1 raze(raze each f cut m),'"\n";                            /   list
    :""];
  / syscmds and cmd-line options case sensitive
  str:("j"$not first[x]in"\\-")lower/str;                       
  url:.man.ROOT,{$[count x;x;.man.HELP]}.man.d str;             / URL
  cmd:"mwl"!("open";"start";"xdg-open");                        / OS command
  system(cmd first string .z.o)," ",url;                        / in browser
  url }
\

Usage examples:

man "$"               / operator glyph
man "enum extend"     / operator name
man "read0"           / keyword
man ".z"              / namespace
man "-b"              / command-line option
man "\\b"             / system command

Special pages:

man "cmdline"         / command-line options
man "errors"
man "datatypes"
man "debug"
man "help"
man "interfaces"
man "internal"
man "iterators"
man "kb"              / Knowledge Base
man "syscmds"         / system commands
man "wp"              / White Papers

All arguments:

man "--list"
