#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    201202.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 20.1 na 20.2
*****************************************************************************
FUNCTION Main()

   PUBLIC param_rok

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   dbfInicjujDane()

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele( 'REJS', 'rejs.tym' )
   dbfUtworzTabele( 'REJZ', 'rejz.tym' )
   dbfUtworzTabele( 'SUMA_MC', 'suma_mc.tym' )
   dbfUtworzTabele( 'DANE_MC', 'dane_mc.tym' )
   dbfUtworzTabele( 'SPOLKA', 'spolka.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxREJS()
   dbfIdxREJZ()
   dbfIdxSUMA_MC()
   dbfIdxDANE_MC()
   dbfIdxSPOLKA()
   dbCloseAll()

   RETURN

FUNCTION DodajBackslash(cSciezka)
   cSciezka = AllTrim(cSciezka)
   IF Len(cSciezka) == 0
      RETURN cSciezka
   ENDIF
   IF SubStr(cSciezka, Len(cSciezka), 1) <> '\'
      cSciezka = cSciezka + '\'
   ENDIF
   RETURN cSciezka


/*----------------------------------------------------------------------*/
