# Makefile do módulo PdfHandler

DEFS=-D_UNICODE -DUNICODE -D_WIN32_WINNT=0x0600
DBGFLAGS=-ggdb -fno-inline -fno-omit-frame-pointer

LDLIBS=-lqpdf

PROJECTNAME=pdfhandler
BINDIR=../../bin
INCDIR=../../include
LIBDIR=../../lib
OBJDIR=../../obj
OBJFILES=splitbysize.o pdfhandler.o
OBJECTS=$(addprefix $(OBJDIR)/, $(OBJFILES))
RESDIR=res

CXXFLAGS=-fpic -c -Wall -Wextra -Wpedantic $(DEFS) -I$(INCDIR)/
DBGFLAGS=-DBUILD_DLL
LDFLAGS=-municode -shared -L$(LIBDIR)

$(OBJDIR)/%.o: %.cc
	@(echo. && echo Compilando $<...)
	$(CXX) $(DBGFLAGS) $(CXXFLAGS) $< -o $@

$(PROJECTNAME).dll: $(OBJECTS)
	@(echo. && echo Gerando biblioteca $@...)
	$(CXX) $(LDFLAGS) -o $(BINDIR)/$@ $^ $(LDLIBS) -Wl,--out-implib,$(LIBDIR)/lib$@.a

all: $(PROJECTNAME).dll