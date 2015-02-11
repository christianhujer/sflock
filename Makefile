# Copyright (C) 2014 Christian Hujer.
# All rights reserved.
# Licensed under GPLv3.
# See file LICENSE in the root directory of this project.


## Specifies the installation prefix (used by install).
PREFIX?=/usr/local/

## Specifies the binary installation directory (used by install).
BINDIR?=$(PREFIX)bin/

## Installation directory for man files.
MANDIR=$(PREFIX)/share/man/

CPPFLAGS:=-MMD
CFLAGS:=-std=gnu99 -W -Wall -pedantic -Werror -fdiagnostics-show-option -Wno-unused-parameter -g

PROGRAMNAME:=sflock

.PHONY: all
## Builds the program.
all: $(PROGRAMNAME)

.PHONY: clean
## Removes the generated files.
clean:
	$(RM) $(PROGRAMNAME) *.[ado]

.PHONY: tags
## Creates a tags file.
tags: $(wildcard *.[ch])
	ctags $^

.PHONY: indent
## Indents the source code.
indent:
	indent -npro -kr -nut -l1000 -c1 $(wildcard *.c)

.PHONY: install
## Installs the program, building it first if not built already.
# The program will be installed by copying it into the directory at the location specified by the BINDIR variable.
# I.e. if BINDIR is /usr/local/bin/, the program will be installed in /usr/local/bin/.
# BINDIR is $(BINDIR).
install: all
	install -d $(BINDIR) $(MANDIR)/man1/
	install -t $(BINDIR) $(PROGRAMNAME)
	install -m 0644 -t $(MANDIR)/man1/ man/makehelp.1

control.Description=sflock - a simple file locking command.
-include makedist/MakeDist.mak

-include makehelp/Help.mak
