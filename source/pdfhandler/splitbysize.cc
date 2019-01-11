#include <cstdio>
#include <fstream>
#include <stdexcept>
#include "pdfdll/splitbysize.hh"

SplitBySize::SplitBySize(SplitOptions_p splitop) {
    pdfinfile = splitop->filein;
    dirout = splitop->dirout;
    prefixout = splitop->prefixout;
    delsource = splitop->delsource;
    forcereplace = splitop->forcereplace;
    maxsize = splitop->maxsize * 1024;
    pdfno = 0;
    openPdf();
}

SplitBySize::~SplitBySize() {
    delete &inpdf;
}

void SplitBySize::buildPdf(QPDF* pdf) {
    unsigned long filesize;
    Buffer* buffer;
    
    QPDFWriter outpdfw(*pdf);
    outpdfw.setOutputMemory();
    outpdfw.setObjectStreamMode(qpdf_o_generate);
    outpdfw.write();
    buffer = outpdfw.getBuffer();
    filesize = buffer->getSize();
    saveFile(buffer->getBuffer(), filesize);
}

size_t SplitBySize::getPdfSize(QPDF* pdf) {
    QPDFWriter outpdfw(*pdf);

    outpdfw.setOutputMemory();
    outpdfw.setObjectStreamMode(qpdf_o_generate);
    outpdfw.write();
    return outpdfw.getBuffer()->getSize();
}

void SplitBySize::openPdf() {
    char* buffer;
    FILE* file;
    size_t length;

    if ((file = _wfopen(pdfinfile.c_str(), L"rb")) == NULL)
        throw std::runtime_error("file_notread");
    fseek (file, 0, SEEK_END);
    length = ftell(file);
    fseek(file, 0, SEEK_SET);
    buffer = (char*)malloc(length);
    if (!buffer)
        throw std::runtime_error("mem_notalloc");
    fread(buffer, 1, length, file);
    fclose(file);
    inpdf.processMemoryFile("pdf file", buffer, length);
}

void SplitBySize::removeLastPage(QPDF* pdf) {
    std::vector<QPDFPageObjectHelper> pages = QPDFPageDocumentHelper(*pdf).getAllPages();
    std::vector<QPDFPageObjectHelper>::iterator iter = pages.end();
    iter--;
    QPDFPageObjectHelper& pageToRemove(*iter);
    QPDFPageDocumentHelper(*pdf).removePage(pageToRemove);
}

void SplitBySize::run() {
    int pageno;
    std::vector<QPDFPageObjectHelper>::iterator iter;
    std::vector<QPDFPageObjectHelper> pages;
    unsigned long filesize;

    pages = QPDFPageDocumentHelper(inpdf).getAllPages();
    iter = pages.begin();
    while (true) {
        QPDF outpdf;

        outpdf.emptyPDF();
        filesize = 0;
        pageno = 0;
        while (filesize < maxsize) {
            QPDFPageObjectHelper& page(*iter);
            QPDFPageDocumentHelper(outpdf).addPage(page, false);
            pageno++;
            filesize = getPdfSize(&outpdf);
            iter++;
            if (iter == pages.end())
                break;
        }
        if (filesize >= maxsize) {
            removeLastPage(&outpdf);
            if (--pageno > 0)
                buildPdf(&outpdf);
            else
                throw std::runtime_error("pdf_onepageoutofrange");
            iter--;
            continue;
        } else if (filesize > 0)
            buildPdf(&outpdf);
    }
}

void SplitBySize::saveFile(unsigned char const* buff, size_t size) {
    std::wstring filename;
    FILE* file;

    filename = dirout + prefixout + std::to_wstring(++pdfno) + L".pdf";
    if ((file = _wfopen(filename.c_str(), L"wb")) == NULL)
        throw std::runtime_error("file_notcreate");
    if (fwrite((const char*)buff, sizeof(char), size, file) != size)
        throw std::runtime_error("file_notwrite");
    fclose(file);
}