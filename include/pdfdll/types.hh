#ifndef TYPES_H
#define TYPES_H

typedef void (__stdcall *progress_proc_t)(const wchar_t*, int);

typedef void (__stdcall *msg_proc_t)(const char*);

typedef struct _SplitOptions_t {
    wchar_t* filein;
    wchar_t* dirout;
    wchar_t* prefixout;
    bool forcereplace;
    bool delsource;
    unsigned long maxsize;
    bool catchprogress;
    bool success;
    progress_proc_t progressproc;
    msg_proc_t msgproc;
} SplitOptions_t, *SplitOptions_p;

#endif  //TYPES_H