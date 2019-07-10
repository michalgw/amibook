#include "directry.ch"
#require hbwin.ch
#include "hblang.ch" 
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    170171.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 17.0 na 17.1
*****************************************************************************
FUNCTION Main()
   LOCAL nX, nY
   PUBLIC cN, cM
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT('PL')
   hb_cdpSelect('PL852')
   SetMode(25, 80)
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )
   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele('EWID', 'ewid.tym')
   dbfUtworzTabele('OPER', 'oper.tym')
   dbfUtworzTabele('REJS', 'rejs.tym')
   dbfUtworzTabele('REJZ', 'rejz.tym')
   dbfUtworzTabele('ROZR', 'rozr.tym')
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()
   ? 'Indeksowanie danych...'
   dbfIdxEWID()
   dbfIdxOPER()
   dbfIdxREJS()
   dbfIdxREJZ()
   dbfIdxROZR()

   ? 'Aktualizacja konfiguracji...'
   IF File( 'rejszuep.mem' )
      RESTORE FROM rejszuep ADDITIVE
      IF Type( 'rspz_0108' ) <> 'C'
         cM := '08'
         FOR nX := 1 TO 10
            cN := StrTran( Str( nX, 2 ), ' ', '0' )
            rspz_&cN&cM = 'T'
         NEXT
         SAVE ALL LIKE rspz_* TO rejszuep
      ENDIF      
   ENDIF
   RELEASE ALL LIKE rspz_*
   IF File( 'rejzpzze.mem' )
      RESTORE FROM rejzpzze ADDITIVE
      IF Type( 'rspz_0108' ) <> 'C'
         cM := '08'
         FOR nX := 1 TO 10
            cN := StrTran( Str( nX, 2 ), ' ', '0' )
            rspz_&cN&cM = 'T'
         NEXT
         SAVE ALL LIKE rspz_* TO rejzpzze
      ENDIF      
   ENDIF
   RELEASE ALL LIKE rspz_*
   IF File( 'rejzsze.mem' )
      RESTORE FROM rejzsze ADDITIVE
      IF Type( 'rspz_0108' ) <> 'C'
         cM := '08'
         FOR nX := 1 TO 10
            cN := StrTran( Str( nX, 2 ), ' ', '0' )
            rspz_&cN&cM = 'T'
         NEXT
         SAVE ALL LIKE rspz_* TO rejzsze
      ENDIF      
   ENDIF
   RELEASE ALL LIKE rspz_*

   RETURN
