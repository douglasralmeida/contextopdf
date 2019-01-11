#ifndef DLLFUNC_H
#define DLLFUNC_H

#include <cstdlib>
#include "pdfdll/types.hh"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BUILD_DLL
#define FUNC_DLL __declspec(dllexport)
#else
#define FUNC_DLL __declspec(dllimport)
#endif

void __stdcall FUNC_DLL splitBySize(SplitOptions_p splitop);

#ifdef __cplusplus
}
#endif

#endif  //DLLFUNC_H