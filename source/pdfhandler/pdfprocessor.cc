#include <qpdf/QPDF.hh>
#include <qpdf/QPDFPageDocumentHelper.hh>
#include <qpdf/QPDFWriter.hh>
#include <qpdf/QUtil.hh>
#include <qpdf/Pl_Buffer.hh>
#include <string>
#include <iostream>
#include <fstream>
#include <cstdlib>

void saveToFile(std::string filename, unsigned char const* buff, size_t size) {
     std::ofstream ofs;

     ofs.open(filename, std::ofstream::binary | std::ofstream::trunc);
     ofs.write((const char*)buff, size);
     ofs.close();
}

size_t getPdfSize(QPDF* pdf) {
    QPDFWriter outpdfw(*pdf);

    outpdfw.setOutputMemory();
    outpdfw.setObjectStreamMode(qpdf_o_generate);
    outpdfw.write();
    return outpdfw.getBuffer()->getSize();
}

void savePdf(std::string filename, QPDF* pdf) {
    size_t filesize;
    Buffer* buffer;
    QPDFWriter outpdfw(*pdf);

    std::cout << "Salvando.." << std::endl;
    outpdfw.setOutputMemory();
    outpdfw.setObjectStreamMode(qpdf_o_generate);
    outpdfw.write();
    buffer = outpdfw.getBuffer();
    filesize = buffer->getSize();
    std::cout << "Tamanho final " << filesize << std::endl;
    saveToFile(filename, buffer->getBuffer(), filesize);
}

static void process(char const* infile, std::string outprefix, size_t limite) {
    int fileno = 0;
    int pageno;
    QPDF inpdf;
    std::vector<QPDFPageObjectHelper>::iterator iter;
    std::string outfile;
    size_t filesize;
    size_t filemax = limite * 1024;
    
    std::cout << "Limite " << filemax << std::endl;

    inpdf.processFile(infile);
    std::vector<QPDFPageObjectHelper> pages = QPDFPageDocumentHelper(inpdf).getAllPages();
    iter = pages.begin();
    while (true) {
        QPDF outpdf;

        outpdf.emptyPDF();
        outfile = outprefix + std::to_string(++fileno) + ".pdf";
        std::cout << "Arquivo " << outfile << std::endl;
        filesize = 0;
        pageno = 0;
        while (filesize < filemax) {
            QPDFPageObjectHelper& page(*iter);
            QPDFPageDocumentHelper(outpdf).addPage(page, false);
            pageno++;
            filesize = getPdfSize(&outpdf);
            std::cout << "Tamanho interm " << filesize << std::endl;
            iter++;
            if (iter == pages.end())
                break;
        }
        if (filesize >= filemax) {
            std::vector<QPDFPageObjectHelper> outpdfpages = QPDFPageDocumentHelper(outpdf).getAllPages();
            std::vector<QPDFPageObjectHelper>::iterator iterToRemove = outpdfpages.end();
            iterToRemove--;
            pageno--;
            QPDFPageObjectHelper& pageToRemove(*iterToRemove);
            QPDFPageDocumentHelper(outpdf).removePage(pageToRemove);
            if (pageno > 0)
                savePdf(outfile, &outpdf);
            else {
                std::cerr << "erro: uma unica pagina já passou do limite máximo. tente reduzir sua resolução." << std::endl;
                exit(EXIT_FAILURE);
            }
            iter--;
            continue;
        } else if (filesize > 0) {
            savePdf(outfile, &outpdf);
        }   
    }
}

int main(int argc, char* argv[]) {
    if (argc < 4) {
      std::cerr << "param error" << std::endl;
      return 2;
    }
    try {
        process(argv[1], argv[2], std::stoi(argv[3]));
    }
    catch (std::exception const& e) {
    
        std::cerr << "pdfsplit" << ": exception: " << e.what() << std::endl;
        return 2;
    }
    return 0;
}