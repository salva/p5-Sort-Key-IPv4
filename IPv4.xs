/* -*- Mode: C -*- */

#define PERL_NO_GET_CONTEXT 1

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"


MODULE = Sort::Key::IPv4		PACKAGE = Sort::Key::IPv4		
PROTOTYPES: DISABLE

UV
ipv4_to_uv(ipv4=NULL)
    char *ipv4
PREINIT:
    int i;
CODE:
    if (!ipv4)
        ipv4 = SvPV_nolen(DEFSV);
    RETVAL = 0;
    for (i = 0; i < 4; i++) {
        int v = 0;
        char *s = ipv4;
        while (*s >= '0' && *s <= '9') {
            v = v * 10 + (*s - '0');
            if (v > 255)
                Perl_croak(aTHX_ "value out of range for IPv4 octet");
            s++;
        }
        if (s == ipv4 || *s != (i == 3 ? '\0' : '.'))
            Perl_croak(aTHX_ "bad IPv4 value");
        ipv4 = s + 1;
        RETVAL = (RETVAL << 8) + v;
    }
OUTPUT:
    RETVAL
