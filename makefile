# Makefile

OBJFILES=pdfprocessor.o pdfhandler.o pdfcli.o
SOURCEDIR=source
PROJS=pdfhandler cli

#### Secao das regras ####
%:
	$(MAKE) -C $(SOURCEDIR)/$@ BINDIR=$(BINDIR)

all: $(PROJS)

.PHONY: all

clean:
	@echo Executando limpeza...
	del /q $(addprefix $(OBJDIR)\, $(OBJFILES))
	del /q $(BINDIR)\pdfhandler.dll
	del /q $(BINDIR)\pdfc.exe