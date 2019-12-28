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


Usage
-----

### Examples
    man "$"               / operator glyph
    man "enum extend"     / operator name
    man "read0"           / keyword
    man ".z"              / namespace
    man "-b"              / command-line option
    man "\\b"             / system command
    man ""                / reference card

### Special pages
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

### All arguments
    man "--list"


See also <https://code.kx.com/q/about/man/>

A project of the [Kx Librarian](mailto:librarian@kx.com)