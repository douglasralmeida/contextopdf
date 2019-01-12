#ifndef TYPES_H
#define TYPES_H

typedef void (__stdcall *callback_proc)(const wchar_t*, int);

typedef struct _SplitOptions_t {
    wchar_t* filein;
    wchar_t* dirout;
    wchar_t* prefixout;
    bool forcereplace;
    bool delsource;
    unsigned long maxsize;
    bool usecallback;
    callback_proc callbackproc;
} SplitOptions_t, *SplitOptions_p;

#endif  //TYPES_H