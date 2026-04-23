#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    261261b.PRG                                          *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 26.1b na 26.1d
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

   IF File( 'param.mem' )
      RESTORE FROM param ADDITIVE
   ENDIF

   dbfInicjujDane()

   IF wersja_db < 2614

      ? 'Aktualizacja struktury danych...'
      dbfUtworzTabele( 'REJS', 'rejs.tym' )
      dbfImportujDaneTym('', 'TYM')
      dbCloseAll()

      ? 'Aktualizowanie danych...'
      SELECT 1
      DO WHILE ! Dostep( 'REJS' )
      ENDDO

      rejs->( dbGoTop() )
      DO WHILE ! rejs->( Eof() )
         IF rejs->del == '+'
            IF Empty( rejs->dataks )
               rejs->( dbRLock() )
               rejs->dataks := hb_Date( Val( param_rok ), Val( rejs->mc ), Val( rejs->dzien ) )
               rejs->( dbRUnlock() )
               rejs->( dbCommit() )
            ENDIF
         ENDIF
         rejs->( dbSkip() )
      ENDDO

      dbCloseAll()

      ? 'Indeksowanie...'
      dbfIdxREJS()

      dbCloseAll()

      wersja_db := 2614
      SAVE ALL LIKE wersja_db TO wersjadb

   ENDIF

   RETURN

/*----------------------------------------------------------------------*/
