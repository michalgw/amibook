#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    215215e.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 21.5 na 21.5e
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
   dbfUtworzTabele( 'ETATY', 'etaty.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxETATY()
   dbCloseAll()

/*
   ? 'Aktualizacja danych'
   SELECT 1
   DO WHILE ! DostepEx( 'PRAC' )
   ENDDO
   SetInd( 'PRAC' )

   SELECT 2
   DO WHILE ! DostepEx( 'ETATY' )
   ENDDO
   SetInd( 'ETATY' )

   prac->( dbSetOrder( 1 ) )
   prac->( dbSeek( "+" ) )
   etaty->( dbSetOrder( 1 ) )
   DO WHILE ! prac->( Eof() ) .AND. prac->del == "+"
      IF etaty->( dbSeek( "+" + prac->firma + Str( prac->( RecNo() ), 5 ) ) )
         DO WHILE ! etaty->( Eof() ) .AND. etaty->del == '+' .AND. etaty->firma == prac->firma .AND. etaty->ident == Str( prac->( RecNo() ), 5 )
            etaty->odliczenie := prac->odliczenie
            etaty->( dbCommit() )
            etety->( dbSkip()
         ENDDO
      ENDIF
      prac->( dbSkip() )
   ENDDO
   dbCloseAll()
*/

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
