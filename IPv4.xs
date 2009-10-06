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
    SV *ipv4
PREINIT:
    int i;
    STRLEN len;
    char *str;
    char *top;
CODE:
    if (!ipv4)
        ipv4 = DEFSV;
    str = SvPV(ipv4, len);
    top = str + len;
    RETVAL = 0;
    for (i = 0; i < 4; i++) {
        int v = 0;
        char *p = str;
        while (p < top && *p >= '0' && *p <= '9') {
            v = v * 10 + (*p - '0');
            if (v > 255)
                Perl_croak(aTHX_ "value out of range for IPv4 octet");
            p++;
        }
        if (p == str ||    /* empty octet        */
	    ((i < 3)
	     ? (p >= top || /* finish too soon    */
		*p != '.')  /* dot expected       */
	     : p < top))    /* rubbish at the end */
	    Perl_croak(aTHX_ "bad IPv4 value %s", SvPV_nolen(ipv4));
        str = p + 1;
        RETVAL = (RETVAL << 8) + v;
    }
OUTPUT:
    RETVAL
