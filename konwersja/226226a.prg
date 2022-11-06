#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    224224a.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 22.4 na 22.4a
*****************************************************************************
FUNCTION Main()

   LOCAL aDane, cFirma, cSpolka
   PUBLIC param_rok

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   dbfInicjujDane()

   ? 'Aktualizacja struktury danych...'
   dbfUtworzTabele( 'FIRMA', 'firma.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxFIRMA()
   dbCloseAll()

   ? 'Aktualizacja danych...'

   SELECT 1
   DO WHILE .NOT. Dostep( 'FIRMA' )
   ENDDO
   SetInd( 'FIRMA' )
   SET ORDER TO 1

   SELECT 2
   DO WHILE .NOT. Dostep( 'SPOLKA' )
   ENDDO
   SetInd( 'SPOLKA' )
   SET ORDER TO 1

   SELECT 3
   DO WHILE .NOT. Dostep( 'DANE_MC' )
   ENDDO
   SetInd( 'DANE_MC' )
   SET ORDER TO 1

   firma->( dbSeek( '+' ) )
   DO WHILE ! firma->( Eof() ) .AND. firma->del == '+'
      cFirma := Str( firma->( RecNo() ), 3 )
      spolka->( dbSeek( '+' + cFirma ) )
      DO WHILE ! spolka->( Eof() ) .AND. spolka->firma == cFirma
         cSpolka := Str( spolka->( RecNo() ), 5 )
         aDane := { { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 } }
         dane_mc->( dbSeek( '+' + cSpolka ) )
         DO WHILE ! dane_mc->( Eof() ) .AND. dane_mc->ident == cSpolka
            IF dane_mc->mc_wuz > 0
               aDane[ dane_mc->mc_wuz ][ 1 ] := aDane[ dane_mc->mc_wuz ][ 1 ] + dane_mc->war5_wuz
            ENDIF
            IF dane_mc->mc_wue > 0
               aDane[ dane_mc->mc_wue ][ 2 ] := aDane[ dane_mc->mc_wue ][ 2 ] + dane_mc->war5_wue
            ENDIF
            IF dane_mc->mc_wur > 0
               aDane[ dane_mc->mc_wur ][ 2 ] := aDane[ dane_mc->mc_wur ][ 2 ] + dane_mc->war5_wur
            ENDIF
            IF dane_mc->mc_wuc > 0
               aDane[ dane_mc->mc_wuc ][ 2 ] := aDane[ dane_mc->mc_wuc ][ 2 ] + dane_mc->war5_wuc
            ENDIF
            IF dane_mc->mc_wuw > 0
               aDane[ dane_mc->mc_wuw ][ 2 ] := aDane[ dane_mc->mc_wuw ][ 2 ] + dane_mc->war5_wuw
            ENDIF
            dane_mc->( dbSkip() )
         ENDDO
         dane_mc->( dbSeek( '+' + cSpolka ) )
         DO WHILE ! dane_mc->( Eof() ) .AND. dane_mc->ident == cSpolka
            dane_mc->( dbRLock() )
            dane_mc->zdrowie := aDane[ Val( dane_mc->mc ) ][ 1 ]
            dane_mc->skladki := aDane[ Val( dane_mc->mc ) ][ 2 ]
            dane_mc->( dbUnlock() )
            dane_mc->( dbSkip() )
         ENDDO
         dane_mc->( dbCommit() )
         spolka->( dbSkip() )
      ENDDO
      firma->( dbSkip() )
   ENDDO

   dbCloseAll()

   RETURN

/*----------------------------------------------------------------------*/
