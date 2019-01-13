#ifndef SPLITBYSIZE_H
#define SPLITBYSIZE_H

#include "qpdf/QPDF.hh"
#include "qpdf/QPDFPageDocumentHelper.hh"
#include "qpdf/QPDFWriter.hh"
#include "qpdf/QUtil.hh"
#include "qpdf/Pl_Buffer.hh"
#include "pdfdll/types.hh"

class SplitBySize {
        std::wstring pdfinfile;                 //pdf source to read
        std::wstring dirout;                    //directory to write
        std::wstring prefixout;                 //filename prefix to write
        bool delsource;                         //delete de source file
        int pdfno;                              //number of pdf files generated
        bool forcereplace;                      //force pdf write
        unsigned long maxsize;                  //max pdf file size in bytes
        bool catchprogress;
        progress_proc_t progressproc;
        QPDF inpdf;
        long long pagecount;
        void openPdf();
        void buildPdf(QPDF* pdf);
        void delSource();
        void getPageCount();
        size_t getPdfSize(QPDF* pdf);
        void removeLastPage(QPDF* pdf);
        void saveFile(const unsigned char* buff, size_t size);
        void setStatus(std::wstring status, int pos);
    public:
        SplitBySize(SplitOptions_p splitop);
        void run();
};

#endif  //SPLITBYSIZE_H