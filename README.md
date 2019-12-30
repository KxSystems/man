man.q
=====

Man pages for the q programming language.

Install
-------

Download `man.q` from this repository and save in `QHOME`. 

```q
q)\l man.q
q)
```

Requirements: kdb+ V3.2+ on macOS, Linux, Windows, or Solaris 11+. 

To have `man.q` loaded with every q session, specify it in environment variable `QINIT`.
For example, an alias for `q` might be:

```bash
$ alias q='export QHOME=~/q/v3.7; export QINIT=$QHOME/man.q; rlwrap -r $QHOME/m64/q'
```


    $ q
    KDB+ 3.7t 2019.12.12 Copyright (C) 1993-2019 Kx Systems
    m64/ 4()core 8192MB sjt mint.local 192.168.0.10 EXPIRE 2020.04.01 stephen@kx.com #55032
    q)man "--help"
    "https://code.kx.com/q/about/man"
    q)


Usage
-----

### Examples
    man "$"               / operator glyph
    man "enum extend"     / operator name
    man "read0"           / keyword
    man ".Q"              / namespace
    man ".Q.bt"           / namespace object
    man "-C"              / command-line option
    man "\\b"             / system command
    man ""                / reference card

### Special pages
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

### Help with `man`
    man "--help"          / help page
    man "--list"          / all arguments

See also <https://code.kx.com/q/about/man/>

A project of the [Kx Librarian](mailto:librarian@kx.com)