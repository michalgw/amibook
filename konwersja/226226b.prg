#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    226226b.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 22.6a na 22.6b
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

   IF wersja_db < 2262

      ? 'Indeksowanie...'
      dbfIdxPRAC()
      dbfIdxEDEKLAR()
      dbCloseAll()

      ? 'Aktualizacja danych...'

      SELECT 1
      DO WHILE .NOT. Dostep( 'EDEKLAR' )
      ENDDO

      SELECT 2
      DO WHILE .NOT. Dostep( 'PRAC' )
      ENDDO

      edeklar->( dbGoTop() )
      DO WHILE ! edeklar->( Eof() )
         IF Val( edeklar->osoba ) > 0
            prac->( dbGoto( Val( edeklar->osoba ) ) )
            IF prac->del == '+' .AND. prac->firma == edeklar->firma
               edeklar->( dbRLock() )
               edeklar->osoba := Str( prac->id, 3 )
               edeklar->( dbCommit() )
               edeklar->( dbUnlock() )
            ENDIF
         ENDIF
         edeklar->( dbSkip() )
      ENDDO

      dbCloseAll()

      wersja_db := 2262
      SAVE ALL LIKE wersja_db TO wersjadb

   ENDIF

   IF wersja_db < 2270

      ? 'Aktualizacja struktury danych...'
      dbfUtworzTabele( 'SPOLKA', 'spolka.tym' )
      dbfUtworzTabele( 'UMOWY', 'umowy.tym' )
      dbfImportujDaneTym('', 'TYM')
      dbCloseAll()

      ? 'Indeksowanie...'
      dbfIdxSPOLKA()
      dbfIdxUMOWY()
      dbCloseAll()

      wersja_db := 2270
      SAVE ALL LIKE wersja_db TO wersjadb

   ENDIF

   RETURN

/*----------------------------------------------------------------------*/
