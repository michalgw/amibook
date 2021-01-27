#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    205210.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 20.5 na 21.0
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
   dbfUtworzTabele( 'EWID', 'ewid.tym' )
   dbfUtworzTabele( 'SUMA_MC', 'suma_mc.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxEWID()
   dbfIdxSUMA_MC()
   dbCloseAll()

   ? 'Kopiowanie plik¢w...'
   AEval( { "OLD2020", "OLD2019", "OLD2018", "OLD2017", "OLD2016" }, { | cKatalog |
      IF hb_DirExists( cKatalog ) .AND. hb_FileExists( cKatalog + "\menu.exe" ) .AND. hb_FSize( cKatalog + "\menu.exe" ) > 50000
         BEGIN SEQUENCE
            hb_FCopy( "menu.exe", cKatalog + "\menu.exe" )
         END
      ENDIF
   } )

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
