DC700CL:   Pgm   /*  Weekly refresh of documentation x-ref files  */

/*  Clear the field xref file  */

ClrPfm DCFXRFP
MonMsg cpf0000

ClrPfm DCFXRFP
MonMsg cpf0000

/*  Rebuild IBM outfiles  */
Call dc090cl Parm('Y' 'Y' 'Y' 'Y' 'Y')

/*  Update procedure/module xref file  */
ClrPfm dcprocp
Call dc250

/*  Rebuild called-to-calling pgm xref file  */
Call dc111cl

/*  Rebuild extended file name xref files  */
Call dc120cl

/*  Rebuild file where-used xref file  */
Call dc145cl

/*  Rebuild menu calls xref file  */
Call dc050cl

/*  Update pgm descriptions in DCPGPGP if still missing  */
Call dc018

/*  Update file/field list and field prefix file  */
Call dc080cl

/*  Update the usage history file  */
Call dc721cl

EndPgm
