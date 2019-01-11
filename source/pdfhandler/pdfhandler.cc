#include <stdexcept>
#include <string>
#include "pdfdll/dllfunc.hh"
#include "pdfdll/splitbysize.hh"

__stdcall void splitBySize(SplitOptions_p splitop){
    SplitBySize sbs = SplitBySize(splitop);
    
    sbs.run();
};