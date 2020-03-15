#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    192193.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 19.5 na 19.6
*****************************************************************************
FUNCTION Main()

   PUBLIC param_rok

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP

   ? "Poprawianie nr NIP..."
   dbfInicjujDane()

/*
   DO WHILE .NOT. DostepPro( "FAKTURY", , .F., ,"FAKTURY" )
   ENDDO
   dbGoTop()
   dbEval( { || nr_ident = StrTran( nr_ident, '-', '' ) } )
   faktury->( dbCloseArea() )

   DO WHILE .NOT. DostepPro( "FAKTURYW", , .F., ,"FAKTURYW" )
   ENDDO
   dbGoTop()
   dbEval( { || nr_ident = StrTran( nr_ident, '-', '' ) } )
   fakturyw->( dbCloseArea() )
*/
   //AltD(1);AltD()
   DO WHILE .NOT. DostepPro( "KONTR", , .F., , "KONTR" )
   ENDDO
   dbGoTop()
   dbEval( { ||
     dbRLock()
     kontr->nr_ident = StrTran( nr_ident, '-', '' )
     dbRUnlock()
   } )
   kontr->( dbCloseArea() )

/*
   DO WHILE .NOT. DostepPro( "OPER", , .F., , "OPER" )
   ENDDO
   dbGoTop()
   dbEval( { || nr_ident = StrTran( nr_ident, '-', '' ) } )
   oper->( dbCloseArea() )

   DO WHILE .NOT. DostepPro( "REJS", , .F., , "REJS" )
   ENDDO
   dbGoTop()
   dbEval( { || nr_ident = StrTran( nr_ident, '-', '' ) } )
   rejs->( dbCloseArea() )

   DO WHILE .NOT. DostepPro( "REJZ", , .F., , "REJZ" )
   ENDDO
   dbGoTop()
   dbEval( { || nr_ident = StrTran( nr_ident, '-', '' ) } )
   rejz->( dbCloseArea() )
*/

   DO WHILE .NOT. DostepPro( "FIRMA", , .F., , "FIRMA" )
   ENDDO
   dbGoTop()
   dbEval( { ||
      dbRLock()
      firma->nip = StrTran( nip, '-', '' )
      dbRUnlock()
    } )
   firma->( dbCloseArea() )

   DO WHILE .NOT. DostepPro( "PRAC", , .F., , "PRAC" )
   ENDDO
   dbGoTop()
   dbEval( { ||
      dbRLock()
      prac->nip = StrTran( nip, '-', '' )
      dbRUnlock()
   } )
   prac->( dbCloseArea() )

   DO WHILE .NOT. DostepPro( "ROZR", , .F., , "ROZR" )
   ENDDO
   dbGoTop()
   dbEval( { ||
      dbRLock()
      rozr->nip = StrTran( nip, '-', '' )
      dbRUnlock()
    } )
   rozr->( dbCloseArea() )

   DO WHILE .NOT. DostepPro( "SPOLKA", , .F., , "SPOLKA" )
   ENDDO
   dbGoTop()
   dbEval( { ||
      dbRLock()
      spolka->nip = StrTran( nip, '-', '' )
      dbRUnlock()
   } )
   spolka->( dbCloseArea() )

   ? "Wykonano..."
   RETURN NIL