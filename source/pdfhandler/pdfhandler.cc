#include <stdexcept>
#include <string>
#include "pdfdll/dllfunc.hh"
#include "pdfdll/splitbysize.hh"

void __cdecl splitBySize(SplitOptions_p splitop) {
    try {
        SplitBySize sbs = SplitBySize(splitop);
        sbs.run();
        splitop->success = true;
    }
    catch (std::exception const& e) {
        splitop->success = false;
        (*(splitop->msgproc))(e.what());
    }
}