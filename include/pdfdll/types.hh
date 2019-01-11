#ifndef TYPES_H
#define TYPES_H

typedef struct _SplitOptions_t {
    wchar_t* filein;
    wchar_t* dirout;
    wchar_t* prefixout;
    bool forcereplace;
    bool delsource;
    unsigned long maxsize;
} SplitOptions_t, *SplitOptions_p;

#endif  //TYPES_H