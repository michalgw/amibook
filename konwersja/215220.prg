#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    215220.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 21.5 na 22.0
*****************************************************************************
FUNCTION Main()

   LOCAL aDane
   PUBLIC param_rok, wersja_db

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )


   param_rok := '2021'
   IF File( 'param.mem' )
      RESTORE FROM param ADDITIVE
   ENDIF

   IF param_rok < '2022'
      ? 'Nieprawidˆowy rok: ' + param_rok
      RETURN
   ENDIF

   wersja_db := 0

   IF File( 'wersjadb.mem' )
      RESTORE FROM wersjadb ADDITIVE
   ENDIF

   dbfInicjujDane()

   ? 'Aktualizacja struktury danych...'
   ERASE tab_doch.cdx
   dbfInicjujDane()
   dbfUtworzTabele( 'TAB_DOCH', 'tab_doch.dbf' )
   dbfUtworzTabele( 'TAB_DOCHUKS', 'tab_dochuks.dbf' )
   dbfUtworzTabele( 'PRAC', 'prac.tym' )
   dbfUtworzTabele( 'ETATY', 'etaty.tym' )
   dbfUtworzTabele( 'EWID', 'ewid.tym' )
   dbfUtworzTabele( 'SUMA_MC', 'suma_mc.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Dodawanie danych...'
   dbUseArea( .T., , 'tab_doch', , .F. )
   IF tab_doch->( RecCount() ) == 0
      AEval({ ;
         { 'podstawa' => 0.0,       'procent' => 17, 'dataod' => 0d20220101 }, ;
         { 'podstawa' => 120000.01, 'procent' => 32, 'dataod' => 0d20220101 } }, ;
         { | aPoz |
            tab_doch->( dbAppend() )
            hb_HEval( aPoz, { | cKey, xValue |
               tab_doch->&cKey := xValue
            } )
            tab_doch->( dbCommit() )
         } )
   ENDIF

   dbCloseAll()

   dbUseArea( .T., , 'tab_dochuks', , .F. )
   IF tab_dochuks->( RecCount() ) == 0
      AEval({ ;
         { 'podstod' => 5701.0,  'podstdo' => 8549.0,  'mnoznik' => 6.68,  'kwota'=> -380.5, 'procent' => 0.17, 'dataod' => 0d20220101 }, ;
         { 'podstod' => 8549.01, 'podstdo' => 11141.0, 'mnoznik' => -7.35, 'kwota'=> 819.08, 'procent' => 0.17, 'dataod' => 0d20220101 } }, ;
         { | aPoz |
            tab_dochuks->( dbAppend() )
            hb_HEval( aPoz, { | cKey, xValue |
               tab_dochuks->&cKey := xValue
            } )
            tab_dochuks->( dbCommit() )
         } )
   ENDIF

   dbCloseAll()

   dbUseArea( .T., ,  'spolka', , .F. )
   spolka->( dbGoTop() )
   DO WHILE ! spolka->( Eof() )
      IF spolka->del == '+'
         spolka->( dbRLock() )
         spolka->param_kw := 5100
         spolka->param_kwd := 0d20220101
         spolka->param_kw2 := 5100
         spolka->( dbCommit() )
         spolka->( dbRUnlock() )
      ENDIF
      spolka->( dbSkip() )
   ENDDO
   spolka->( dbCloseArea() )

   ? 'Indeksowanie...'
   dbfIdxTAB_DOCH()
   dbfIdxTAB_DOCHUKS()
   dbfIdxPRAC()
   dbfIdxETATY()
   dbfIdxEWID()
   dbfIdxSUMA_MC()
   dbCloseAll()

   wersja_db := 2200
   SAVE ALL LIKE wersja_db TO wersjadb

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
