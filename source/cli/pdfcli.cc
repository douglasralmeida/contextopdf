#include "pdfdll/dllfunc.hh"
#include <iostream>
#include <stdio.h>

void __cdecl exibirmsg(const char* msg) {
    std::cerr << "pdfcli error: " << msg << std::endl;
}

void showhelp() {
    std::wcerr << L"Usage: pdfc sbs <file in.pdf> <file out prefix> <max size in KB>" << std::endl;
}

int wmain(int argc, wchar_t* argv[]) {
    SplitOptions_t splitop;
    wchar_t currentpath[FILENAME_MAX];

    if (argc < 5) {
        std::wcerr << L"param error." << std::endl;
        showhelp();
        return 1;
    }
    _wgetcwd(currentpath, sizeof(currentpath));
    wcsncat(currentpath, L"\\", 1);

    splitop.filein = argv[2];
    splitop.prefixout = argv[3];
    splitop.dirout = currentpath;
    splitop.forcereplace = true;
    splitop.delsource = true;
    splitop.maxsize = (unsigned)_wtol(argv[4]);
    splitop.catchprogress = false;
    splitop.msgproc = &exibirmsg;

    splitBySize(&splitop);
    if (splitop.success)
        return 0;
    else
        return 1;
}