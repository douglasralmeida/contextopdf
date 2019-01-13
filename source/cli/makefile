# Makefile do módulo PdfCLI

DEFS=-D_UNICODE -DUNICODE -D_WIN32_WINNT=0x0600

LDLIBS=-lpdfhandler

PROJECTNAME=pdfc
BINDIR=../../bin
INCDIR=../../include
LIBDIR=../../lib
OBJDIR=../../obj
OBJFILES=pdfcli.o
OBJECTS=$(addprefix $(OBJDIR)/, $(OBJFILES))
RESDIR=res

CXXFLAGS=-c -Wall -Wextra -Wpedantic $(DEFS) -I$(INCDIR)/
DBGFLAGS=
LDFLAGS=-municode -L$(LIBDIR)

$(OBJDIR)/%.o: %.cc
	@(echo. && echo Compilando $<...)
	$(CXX) $(DBGFLAGS) $(CXXFLAGS) $< -o $@

$(PROJECTNAME).exe: $(OBJECTS)
	@(echo. && echo Gerando biblioteca $@...)
	$(CXX) $(LDFLAGS) -o $(BINDIR)/$@ $^ $(LDLIBS)

all: $(PROJECTNAME).exe