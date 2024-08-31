#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    241242.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 24.1 na 24.2
*****************************************************************************
FUNCTION Main()

   LOCAL aDane, cFirma, cSpolka
   PUBLIC wersja_db := 0

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   IF File( 'wersjadb.mem' )
      RESTORE FROM wersjadb ADDITIVE
   ENDIF

   dbfInicjujDane()

   IF wersja_db < 2420

      ? 'Tworzenie nowych tablic...'
      IF ! File( 'zuskodnie.dbf' )
         dbfUtworzTabele( 'ZUSKODNIE', 'zuskodnie.dbf' )
         dbfIdxZUSKODNIE()
         dbCloseAll()

         ? 'Aktualizacja danych'
         aDane := { ;
            { "   ", "brak" }, ;
            { "111", "urlop bezpˆatny" }, ;
            { "121", "urlop wychowawczy udzielony na podstawie art. 186 p 1 Kodeksu pracy" }, ;
            { "122", "urlop wychowawczy udzielony na podstawie art. 186 p 2 kp" }, ;
            { "131", "urlop opiekunczy w rozumieniu art. 1731 kp" }, ;
            { "151", "okres usprawiedliwionej nieobecno˜ci w pracy, bez prawa do wynagrodzenia l" }, ;
            { "152", "okres nieusprawiedliwionej nieobecno˜ci w pracy" }, ;
            { "212", "zasiˆek wyr¢wnawczy z ubezpieczenia chorobowego" }, ;
            { "214", "zasiˆek wyr¢wnawczy z ubezpieczenia wypadkowego" }, ;
            { "215", "wyr¢wnanie zasiˆku wyr¢wnawczego z ubezpieczenia chorobowego" }, ;
            { "216", "wyr¢wnanie zasiˆku wyr¢wnawczego z ubezpieczenia wypadkowego" }, ;
            { "311", "zasiˆek macierzyäski z ubezpieczenia chorobowego" }, ;
            { "312", "zasiˆek opiekuäczy z ubezpieczenia chorobowego" }, ;
            { "313", "zasiˆek chorobowy z ubezpieczenia chorobowego" }, ;
            { "314", "zasiˆek chorobowy z ubezpieczenia wypadkowego" }, ;
            { "315", "wyr¢wnanie zasiˆku macierzyäskiego z ubezpieczenia chorobowego" }, ;
            { "316", "wyr¢wnanie zasiˆku opiekuäczego z ubezpieczenia chorobowego" }, ;
            { "317", "wyr¢wnanie zasiˆku chorobowego z ubezpieczenia chorobowego" }, ;
            { "318", "wyr¢wnanie zasiˆku chorobowego z ubezpieczenia wypadkowego" }, ;
            { "321", "˜wiadczenie rehabilitacyjne z ubezpieczenia chorobowego" }, ;
            { "322", "˜wiadczenie rehabilitacyjne z ubezpieczenia wypadkowego" }, ;
            { "323", "wyr¢wnanie ˜wiadczenia rehabilitacyjnego z ubezpieczenia chorobowego" }, ;
            { "324", "wyr¢wnanie ˜wiadczenia rehabilitacyjnego z ubezpieczenia wypadkowego" }, ;
            { "331", "wynagr. za czas niez. do pracy z pow. choroby, finansowane pracodawca" }, ;
            { "332", "wynagr. za czas niez. do pracy z pow. choroby, finansowane FG—P" }, ;
            { "335", "wyr¢wn. wynagr. za czas niezdol. do pracy z pow. choroby, fin. pracodawca" }, ;
            { "336", "wyr¢wn. wynagr. za czas niezdol. do pracy z pow. choroby, fin. FG—P" }, ;
            { "337", "zasiˆek macierzynski z ubezpieczenia chorobowego  art.4 ust.3 04-11-2016" }, ;
            { "338", "zasiˆek macierzynski z ubezpieczenia chorobowego art. 1821 p.4 lub 183 p.5" }, ;
            { "339", "wyrownanie zasiˆku macierzynskiego z ubezpieczenia chorobowego art.4 u.3" }, ;
            { "340", "wyrownanie zasiˆku macierzynskiego z ubezpieczenia chorobowego a.1821a p.4" }, ;
            { "350", "inne ˜wiadczenia/przerwy" } }

         dbUseArea( .T., , 'zuskodnie', , .F. )
         zuskodnie->( dbSetIndex( 'zuskodnie' ) )
         AEval( aDane, { | aPoz |
            dbAppend()
            zuskodnie->kod := aPoz[ 1 ]
            zuskodnie->nazwa := aPoz[ 2 ]
            dbCommit()
         } )
         dbCloseAll()
      ENDIF

      ? 'Aktualizacja struktury danych...'
      dbfUtworzTabele( 'NIEOBEC', 'nieobec.tym' )
      dbfImportujDaneTym('', 'TYM')
      dbCloseAll()

      ? 'Indeksowanie...'
      dbfIdxPRAC()
      dbCloseAll()

      wersja_db := 2420
      SAVE ALL LIKE wersja_db TO wersjadb

   ENDIF

   RETURN

/*----------------------------------------------------------------------*/
