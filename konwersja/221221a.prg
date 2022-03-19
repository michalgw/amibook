#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    221221a.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 22.1 na 22.1a
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

   ? 'Aktualizacja parametr¢w...'
   IF File( 'param_p.mem' )
      COPY FILE param_p.mem TO bkp\param_p.mem.221
      RESTORE FROM param_p ADDITIVE
      parap_fue := 9.76
      parap_fur := 6.5
      parap_fuz := 0
      parap_fzl := 4.9
      parap_fuc := 0
      parap_ff3 := 0
      parap_ffp := 2.45
      parap_ffg := 0.1
      SAVE TO param_p ALL LIKE parap_*
   ENDIF

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
