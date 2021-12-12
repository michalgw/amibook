#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    214215.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 21.4 na 21.5
*****************************************************************************
FUNCTION Main()

   LOCAL aDane
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
   if ! File( 'ossrej.dbf' )
      dbfUtworzTabele( 'OSSREJ', 'ossrej.dbf' )
   endif
   if ! File( 'tab_vatue.dbf' )
      dbfUtworzTabele( 'TAB_VATUE', 'tab_vatue.dbf' )
   endif
   if ! File( 'viudokor.dbf' )
      dbfUtworzTabele( 'VIUDOKOR', 'viudokor.dbf' )
   endif
   dbCloseAll()

   ? 'Dodawanie danych...'
   dbUseArea( .T., , 'tab_vatue', , .F. )
   IF tab_vatue->( RecCount() ) == 0
      AEval({ ;
         { 'kraj' => 'AT', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 13, 'stawka_c' => 10, 'stawka_d' => 0 }, ;
         { 'kraj' => 'BE', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 12, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'BG', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 9, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'CY', 'oddnia' => d"2021-01-01", 'stawka_a' => 19, 'stawka_b' => 9, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'CZ', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 15, 'stawka_c' => 10, 'stawka_d' => 0 }, ;
         { 'kraj' => 'DE', 'oddnia' => d"2021-01-01", 'stawka_a' => 19, 'stawka_b' => 7, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'DK', 'oddnia' => d"2021-01-01", 'stawka_a' => 25, 'stawka_b' => 0, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'EE', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 9, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'EL', 'oddnia' => d"2021-01-01", 'stawka_a' => 24, 'stawka_b' => 13, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'ES', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 10, 'stawka_c' => 0, 'stawka_d' => 4 }, ;
         { 'kraj' => 'FI', 'oddnia' => d"2021-01-01", 'stawka_a' => 24, 'stawka_b' => 14, 'stawka_c' => 10, 'stawka_d' => 0 }, ;
         { 'kraj' => 'FR', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 10, 'stawka_c' => 5.5, 'stawka_d' => 2.1 }, ;
         { 'kraj' => 'HR', 'oddnia' => d"2021-01-01", 'stawka_a' => 25, 'stawka_b' => 13, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'HU', 'oddnia' => d"2021-01-01", 'stawka_a' => 27, 'stawka_b' => 18, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'IE', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 13.5, 'stawka_c' => 9, 'stawka_d' => 4.8 }, ;
         { 'kraj' => 'IE', 'oddnia' => d"2021-03-01", 'stawka_a' => 23, 'stawka_b' => 13.5, 'stawka_c' => 9, 'stawka_d' => 4.8 }, ;
         { 'kraj' => 'IT', 'oddnia' => d"2021-01-01", 'stawka_a' => 22, 'stawka_b' => 10, 'stawka_c' => 5, 'stawka_d' => 4.8 }, ;
         { 'kraj' => 'LT', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 9, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'LU', 'oddnia' => d"2021-01-01", 'stawka_a' => 17, 'stawka_b' => 8, 'stawka_c' => 0, 'stawka_d' => 3 }, ;
         { 'kraj' => 'LV', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 12, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'MT', 'oddnia' => d"2021-01-01", 'stawka_a' => 18, 'stawka_b' => 7, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'NL', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 9, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'PT', 'oddnia' => d"2021-01-01", 'stawka_a' => 23, 'stawka_b' => 13, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'RO', 'oddnia' => d"2021-01-01", 'stawka_a' => 19, 'stawka_b' => 9, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'SE', 'oddnia' => d"2021-01-01", 'stawka_a' => 25, 'stawka_b' => 12, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'SI', 'oddnia' => d"2021-01-01", 'stawka_a' => 22, 'stawka_b' => 9.5, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'SK', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 10, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'UK', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 5, 'stawka_c' => 0, 'stawka_d' => 0 } }, ;
         { | aPoz |
            tab_vatue->( dbAppend() )
            tab_vatue->del := '+'
            hb_HEval( aPoz, { | cKey, xValue |
               tab_vatue->&cKey := xValue
            } )
            tab_vatue->( dbCommit() )
         } )
   ENDIF

   ? 'Indeksowanie...'
   dbfIdxOSSREJ()
   dbfIdxTAB_VATUE()
   dbfIdxVIUDOKOR()
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
