# Makefile

#### Secao dos cabecalhos ####
##PROJECTNAME=definido no arquivo .bat
##CXX=definido no arquivo .bat
DEFS=-D_UNICODE -D_WIN32_WINNT=0x0600
# Comandos para usar no DEFS
# -D_UNICODE -DUNICODE		Adicona suporte a Unicode.
# -D_WIN32_WINNT=0x0600		O aplicativo requer Windows Vista ou superior.

CXXFLAGS=-c -Wall -Wextra -Wpedantic $(DEFS) -Iinclude/

LIBS=-lqpdf
LDFLAGS=-Llib#-mwindows -municode
BINDIR=bin
OBJDIR=obj
OBJFILES=pdfhandler.o
OBJECTS=$(addprefix $(OBJDIR)/, $(OBJFILES))
RESDIR=res
SOURCEDIR=source
TESTDIR=test

#### Secao das regras ####
$(OBJDIR)/%.o: $(SOURCEDIR)/pdfhandler/%.cc
	@(echo. && echo Compilando $<...)
	$(CXX) $(DBGFLAGS) $(CXXFLAGS) $< -o $@

$(PROJECTNAME).exe: $(OBJECTS)
	@(echo. && echo Gerando executavel...)
	$(CXX) $(LDFLAGS) -o $(BINDIR)/$@ $^ $(LIBS)

all: clean $(PROJECTNAME).exe

clean:
	@echo Executando limpeza...
	del /q $(addprefix $(OBJDIR)\, $(OBJFILES))
	del /q $(BINDIR)\$(PROJECTNAME).exe