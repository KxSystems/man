/ man.q 2019.12.30
/ constants 
.man.GS:"https://google.com/search?q=site:code.kx.com+"     / Google Search
.man.ROOT:"https://code.kx.com/q/"                          / documentation site

.man.cmb:{x where 1b,1_(or)prior" "<>x}                     / collapse multiple blanks
.man.d4s:{@[x;where" "=x;:;"-"]}                            / dash for space
.man.dc:{[u;s]{y[0]!x,/:y 1}[u,"/#";]("**";csv)0:s}         / dict from CSV 
.man.rc:{(x,y,z)(y,x,z)?z}[.Q.A;.Q.a;]                      / reverse case
.man.TEST:0b                                                / test flag

.man.man:{[x]
  if[10<>type str:(),x;'`type];                             / string?
  if[trim[str]~"--list";                                    / --list option
    m:{(1+max count each x)$'x}key .man.d;                  /   keys
    f:(system"c")[1] div count first m;                     /   fold
    1 raze(raze each f cut m),'"\n";                        /   list
    :""];
  cs:".\\-";                                                / ns, cmd, cmd-line
  str:$[first[str]in cs;str;lower str];                     / case sensitive?
  rtf:(.man.d lower 2#;.man.d .man.rc;0#);                  / retry fns
  retry:(rtf where 1 2 1)cs?first str;                      / retry fn
  url:$[count u:.man.d str; .man.ROOT,u;                    / OK
        count u:retry str;  .man.ROOT,u;                    /   retry
                            .man.GS,str ];                  /   Google
  cmd:"mwlsv"!("open";"start";"xdg-open")where 1 1 3;       / OS command
  if[not .man.TEST;system(cmd first string .z.o)," ",url];  / in browser
  url }

.man.cases:(
  ("$"           ; "ref/overloads/#dollar");
  ("Enum Extend" ; "ref/enum-extend/");
  ("read0"       ; "ref/read0");
  (".Q"          ; "ref/dotq");
  (".Q.bt"       ; "ref/dotq/#qbt-backtrace");
  (".h.br"       ; "ref/doth/#hbr-linebreak");
  (".j.j"        ; "ref/dotj/#jj-serialize");
  (".z.u"        ; "ref/dotz/#zu-user-id");
  (".z.T"        ; "ref/dotz/#zt-zt-zd-zd-timedate-shortcuts");
  (".z.Z"        ; "ref/dotz/#zz-local-datetime");
  ("-C"          ; "basics/cmdline/#-c-http-size");
  ("\\b"         ; "basics/syscmds/#b-views");
  (""            ; "ref/");
  ("cmdline"     ; "basics/cmdline");
  ("error"       ; "basics/errors/");
  ("errors"      ; "basics/errors/");
  ("datatypes"   ; "basics/datatypes");
  ("debug"       ; "basics/debug");
  ("interfaces"  ; "interfaces");
  ("internal"    ; "basics/internal");
  ("iterators"   ; "ref/iterators");
  ("kb"          ; "kb");
  ("syscmds"     ; "basics/syscmds");
  ("wp"          ; "wp");
  ("--help"      ; "about/man") )

.man.testall:{
  .man.TEST:1b;                                             / no browser call
  ok:.'[{(.man.ROOT,y)~man x};.man.cases;0];                / results
  .man.TEST:0b;
  $[all ok; `ok; .man.cases[where not ok;0],`fail] }

man:.man.man

/operators by glyph
.man.d,:.[!;]flip" "vs/:.man.cmb each
  ("@   ref/overloads/#at";
  "\\   ref/overloads/#backslash";
  "#   ref/overloads/#hash";
  ".   ref/overloads/#dot";
  "$   ref/overloads/#dollar";
  "!   ref/overloads/#bang";
  "?   ref/overloads/#query";
  "'   ref/overloads/#quote";
  "':  ref/overloads/#quotecolon";
  "/   ref/overloads/#slash";
  "_   ref/overloads/#underscore";
  "+   ref/add";
  "-   ref/subtract";
  "*   ref/multiply";
  "%   ref/divide";
  "=   ref/equal";
  "<>  ref/not-equal";
  "<   ref/less-than";
  ">=  ref/less-than";
  ">=  ref/greater-than";
  "<=  ref/greater-than";
  "&   ref/lesser";
  "|   ref/greater";
  "~   ref/match";
  "^   ref/fill";
  ",   ref/join";
  "/:  ref/maps/#each-left-and-each-right";
  "\\:  ref/maps/#each-left-and-each-right";
  "0   basics/files";
  "1   basics/files";
  "2   basics/files";
  "0:  ref/file-text";
  "1:  ref/file-binary";
  "2:  ref/dynamic-load";
  ":   basics/syntax/#colon";
  "::  ref/identity")

/operators by name
.man.d,:{x!"ref/",/:.man.d4s'[x],\:"/"}lower
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
.man.d,:{x!"ref/",/:x}string asc .Q.res,key[`.q]except`ww

/namespaces (case-sensitive but forgive .q)
.man.d,:{.[!;](".",'x;"ref/dot",/:lower x)}"hjmQqz"

/.h namespace
.man.d,:.man.dc["ref/doth";]
  (".h.br,hbr-linebreak";
  ".h.c0,hc0-web-color";
  ".h.c1,hc1-web-color";
  ".h.cd,hcd-csv-from-data";
  ".h.code,hcode-code-after-tab";
  ".h.ed,hed-excel-from-data";
  ".h.edsn,hedsn-excel-from-tables";
  ".h.fram,hfram-frame";
  ".h.ha,hha-anchor";
  ".h.hb,hhb-anchor-target";
  ".h.hc,hhc-escape-lt";
  ".h.he,hhe-http-400";
  ".h.hn,hhn-http-error";
  ".h.hp,hhp-http-response";
  ".h.hr,hhr-horizontal-rule";
  ".h.ht,hht-marqdown-to-html";
  ".h.hta,hhta-start-tag";
  ".h.htac,hhtac-element";
  ".h.htc,hhtc-element";
  ".h.html,hhtml-document";
  ".h.http,hhttp-hyperlinks";
  ".h.hu,hhu-uri-escape";
  ".h.hug,hhug-uri-map";
  ".h.hy,hhy-http-response";
  ".h.HOME,hhome-webserver-root";
  ".h.iso8601,hiso8601-iso-timestamp";
  ".h.jx,hjx-table";
  ".h.logo,hlogo-kx-logo";
  ".h.nbr,hnbr-no-break";
  ".h.pre,hpre-pre";
  ".h.sa,hsa-style";
  ".h.sb,hsb-style";
  ".h.sc,hsc-uri-safe";
  ".h.td,htd-tsv";
  ".h.text,htext-paragraphs";
  ".h.tx,htx-filetypes";
  ".h.ty,hty-mime-types";
  ".h.uh,huh-uri-unescape";
  ".h.val,hval-value";
  ".h.xd,hxd-xml";
  ".h.xmp,hxmp-xmp";
  ".h.xs,hxs-xml-escape";
  ".h.xt,hxt-json")

/.j namespace
.man.d,:.man.dc["ref/dotj";]
  (".j.j,jj-serialize";
  ".j.jd,jjd-serialize-infinity";
  ".j.k,jk-deserialize")

/.Q namespace
.man.d,:.man.dc["ref/dotq";]
  (".Q.a,qa-lower-case-alphabet";
  ".Q.A,qa-upper-case-alphabet";
  ".Q.addmonths,qaddmonths-.q.addr-ip-address";
  ".Q.bt,qbt-backtrace";
  ".Q.btoa,qbtoa-b64-encode";
  ".Q.bv,qbv-build-vp";
  ".Q.chk,qchk-fill-hdb";
  ".Q.cn,qcn-count-partitioned-table";
  ".Q.Cf,qcf-create-empty-nested-char-file";
  ".Q.D,qd-partitions";
  ".Q.dd,qdd-join-symbols";
  ".Q.def,qdef-.q.dpft-save-table";
  ".Q.dpfts,qdpfts-save-table-with-symtable";
  ".Q.dsftg,qdsftg-load-process-save";
  ".Q.en,qen-enumerate-varchar-cols";
  ".Q.ens,qens-enumerate-against-domain";
  ".Q.f,qf-format";
  ".Q.fc,qfc-parallel-on-cut";
  ".Q.ff,qff-append-columns";
  ".Q.fk,qfk-foreign-key";
  ".Q.fmt,qfmt-format";
  ".Q.fps,qfps-streaming-algorithm";
  ".Q.fs,qfs-streaming-algorithm";
  ".Q.fsn,qfsn-streaming-algorithm";
  ".Q.ft,qft-apply-simple";
  ".Q.fu,qfu-apply-unique";
  ".Q.gc,qgc-garbage-collect";
  ".Q.hdpf,qhdpf-save-tables";
  ".Q.hg,qhg-http-get";
  ".Q.host,qhost-hostname";
  ".Q.hp,qhp-http-post";
  ".Q.id,qid-sanitize";
  ".Q.ind,qind-partitioned-index";
  ".Q.j10,qj10-encode-binhex";
  ".Q.x10,qx10-decode-binhex";
  ".Q.j12,qj12-encode-base64";
  ".Q.x12,qx12-decode-base64";
  ".Q.k,qk-version";
  ".Q.l,ql-load";
  ".Q.M,qm-long-infinity";
  ".Q.MAP,qmap-maps-partitions";
  ".Q.opt,qopt-command-parameters";
  ".Q.par,qpar-locate-partition";
  ".Q.pd,qpd-modified-partition-locations";
  ".Q.pf,qpf-partition-field";
  ".Q.pn,qpn-partition-counts";
  ".Q.pt,qpt-partitioned-tables";
  ".Q.pv,qpv-modified-partition-values";
  ".Q.P,qp-segments";
  ".Q.PD,qpd-partition-locations";
  ".Q.PV,qpv-partition-values";
  ".Q.qp,qqp-is-partitioned";
  ".Q.qt,qqt-is-table";
  ".Q.res,qres-keywords";
  ".Q.s,qs-plain-text";
  ".Q.s1,qs1-string-representation";
  ".Q.sbt,qsbt-string-backtrace";
  ".Q.sha1,qsha1-sha-1-encode";
  ".Q.trp,qtrp-extend-trap";
  ".Q.ts,qts-time-and-space";
  ".Q.ty,qty-type";
  ".Q.u,qu-date-based";
  ".Q.v,qv-value";
  ".Q.V,qv-table-to-dict";
  ".Q.view,qview-subview";
  ".Q.vp,qvp-missing-partitions";
  ".Q.w,qw-memory-stats";
  ".Q.x,qx-non-command-parameters";
  ".Q.Xf,qxf-create-file")

/.z namespace
.man.d,:.man.dc["ref/dotz";]
  (".z.a,za-ip-address";
  ".z.ac,zac-http-auth-from-cookie";
  ".z.b,zb-dependencies";
  ".z.bm,zbm-msg-validator";
  ".z.c,zc-cores";
  ".z.e,ze-tls-connection-status";
  ".z.ex,zex-failed-primitive";
  ".z.exit,zexit-action-on-exit";
  ".z.ey,zey-argument-to-failed-primitive";
  ".z.f,zf-file";
  ".z.h,zh-host";
  ".z.i,zi-pid";
  ".z.K,zk-version";
  ".z.k,zk-release-date";
  ".z.l,zl-license";
  ".z.N,zn-local-timespan";
  ".z.n,zn-utc-timespan";
  ".z.o,zo-os-version";
  ".z.P,zp-local-timestamp";
  ".z.p,zp-utc-timestamp";
  ".z.pc,zpc-close";
  ".z.pd,zpd-peach-handles";
  ".z.pg,zpg-get";
  ".z.ph,zph-http-get";
  ".z.pi,zpi-input";
  ".z.pm,zpm-http-options";
  ".z.po,zpo-open";
  ".z.pp,zpp-http-post";
  ".z.pq,zpq-qcon";
  ".z.ps,zps-set";
  ".z.pw,zpw-validate-user";
  ".z.q,zq-quiet-mode";
  ".z.s,zs-self";
  ".z.ts,zts-timer";
  ".z.u,zu-user-id";
  ".z.vs,zvs-value-set";
  ".z.W,zw-handles";
  ".z.w,zw-handle";
  ".z.wc,zwc-websocket-close";
  ".z.wo,zwo-websocket-open";
  ".z.ws,zws-websockets";
  ".z.X,zx-raw-command-line";
  ".z.x,zx-argv";
  ".z.Z,zz-local-datetime";
  ".z.z,zz-utc-datetime";
  ".z.zd,zzd-zip-defaults";
  ".z.T,zt-zt-zd-zd-timedate-shortcuts";
  ".z.t,zt-zt-zd-zd-timedate-shortcuts";
  ".z.D,zt-zt-zd-zd-timedate-shortcuts";
  ".z.d,zt-zt-zd-zd-timedate-shortcuts")

/cmd-line options
.man.d,:.man.dc["basics/cmdline";]
  ("-b,-b-blocked";
  "-c,-c-console-size";
  "-C,-c-http-size";
  "-e,-e-error-traps";
  "-E,-e-tls-server-mode";
  "-g,-g-garbage-collection";
  "-l,-l-log-updates";
  "-L,-l-log-sync";
  "-m,-m-memory-domain";
  "-o,-o-utc-offset";
  "-p,-p-listening-port";
  "-P,-p-display-precision";
  "-q,-q-quiet-mode";
  "-r,-r-replicate";
  "-s,-s-slaves";
  "-t,-t-timer-ticks";
  "-T,-t-timeout";
  "-u,-u-disable-syscmds";
  "-u,-u-usr-pwd-local";
  "-U,-u-usr-pwd";
  "-w,-w-memory";
  "-W,-w-start-week";
  "-z,-z-date-format")

/system commands
.man.d,:.man.dc["basics/syscmds";]
  ("\\,abort";
  "\\a,a-tables";
  "\\b,b-views";
  "\\B,b-pending-views";
  "\\c,c-console-size";
  "\\c,c-change-directory";
  "\\C,c-http-size";
  "\\d,d-directory";
  "\\e,e-error-trap-clients";
  "\\f,f-functions";
  "\\g,g-garbage-collection-mode";
  "\\l,l-load-file-or-directory";
  "\\o,o-offset-from-utc";
  "\\p,p-listening-port";
  "\\P,p-precision";
  "\\r,r-replication-master";
  "\\r,r-rename";
  "\\s,s-number-of-slaves";
  "\\S,s-random-seed";
  "\\t,t-timer";
  "\\T,t-timeout";
  "\\t,t-time-and-space";
  "\\u,u-reload-user-password-file";
  "\\v,v-variables";
  "\\w,w-workspace";
  "\\W,w-week-offset";
  "\\x,x-expunge";
  "\\z,z-date-parsing";
  "\\1,1-2-redirect";
  "\\2,1-2-redirect";
  "\\_,_-hide-q-code";
  "\\,terminate";
  "\\,toggle-qk";
  "\\\\,quit")

/special pages
.man.d,:.[!;]flip{" "vs .man.cmb trim x}each
  ("adverbs    ref/iterators";
  "cmdline    basics/cmdline";
  "error      basics/errors/";
  "errors     basics/errors/";
  "datatypes  basics/datatypes";
  "debug      basics/debug";
  "--help     about/man";
  "internal   basics/internal";
  "interfaces interfaces";
  "iterators  ref/iterators";
  "joins      basics/joins";
  "kb         kb";
  "syscmds    basics/syscmds";
  "wp         wp")
\

Usage examples:

man "$"               / operator glyph
man "enum extend"     / operator name
man "read0"           / keyword
man ".Q"              / namespace
man ".Q.bt"           / namespace object
man "-C"              / command-line option
man "\\b"             / system command
man ""                / reference card

Special pages:

man "cmdline"         / command-line options
man "errors"
man "datatypes"
man "debug"
man "interfaces"
man "internal"
man "iterators"
man "kb"              / Knowledge Base
man "syscmds"         / system commands
man "wp"              / White Papers

Help:

man "--help"
man "--list"
