/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2021  GM Systems Michaˆ Gawrycki (gmsystems.pl)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

************************************************************************/

#require hbwin.ch
#include "hbgtinfo.ch"
#include "hbdyn.ch"

REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
ANNOUNCE HB_GT_SYS
REQUEST HB_GT_WIN_DEFAULT

PROCEDURE Plik( aDane )

   LOCAL nFH

   nFH := FCreate( "_cd.bat" )
   IF nFH >= 0
      AEval( aDane, { | cBuf | FWrite( nFH, cBuf + Chr( 13 ) + Chr( 10 ) ) } )
   ENDIF
   FClose( nFH )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE KomunUr()

   SetColor( "W+/N" )
   CLEAR SCREEN
   @ 13, 0 SAY PadC( "...uruchamiam program...", 80 )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE GShowWindow( lPokaz )

   IF lPokaz
//      IF hb_DynCall( { "IsWindowVisible", "user32.dll", HB_DYN_CALLCONV_STDCALL }, win_P2N( hb_gtInfo( HB_GTI_WINHANDLE ) ) ) <> 0
         hb_DynCall( { "ShowWindow", "user32.dll", HB_DYN_CALLCONV_STDCALL }, win_P2N( hb_gtInfo( HB_GTI_WINHANDLE ) ), 5 )
         hb_DynCall( { "BringWindowToTop", "user32.dll", HB_DYN_CALLCONV_STDCALL }, win_P2N( hb_gtInfo( HB_GTI_WINHANDLE ) ) )
         hb_DynCall( { "SetActiveWindow", "user32.dll", HB_DYN_CALLCONV_STDCALL }, win_P2N( hb_gtInfo( HB_GTI_WINHANDLE ) ) )
  //    ENDIF
   ELSE
      hb_DynCall( { "ShowWindow", "user32.dll", HB_DYN_CALLCONV_STDCALL }, win_P2N( hb_gtInfo( HB_GTI_WINHANDLE ) ), 0 )
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION Main( cParam1, cParam2, cParam3, cParam4 )

   LOCAL nMenu := 1, nI, nIlosc
   LOCAL aLista := { "   0 - Bie¾¥cy rok          " }
   LOCAL aKatalogi, aListaKat := { "" }
   LOCAL lJestGTWVT := .F.

   //AltD(1)
   //AltD()

   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   hb_gtInfo( HB_GTI_PALETTE, { 0x000000, 0x800000, 0x008000, 0x808000, 0x000080, 0x800080, 0x008080, 0xc0c0c0, ;
     0x808080, 0xff0000, 0x00ff00, 0xffff00, 0x0000ff, 0xff00ff, 0x00ffff, 0xffffff } )
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )
   hb_GtInfo( HB_GTI_ALTENTER, .T. )
   hb_gtInfo( HB_GTI_MAXIMIZED, .T. )
   hb_gtInfo( HB_GTI_WINTITLE, "AMi-BOOK - Wyb¢r roku" )
   SET INTENSITY ON
   SET EVENTMASK TO 255
   mSetCursor( .T. )

   aKatalogi := Directory( "OLD2*", "D" )

   ASort( aKatalogi, , , { | x, y | Upper( x[ 1 ] ) > Upper( y[ 1 ] ) } )

   nI := 1
   AEval( aKatalogi, { | aEl |
      IF nI < 10
         AAdd( aLista, "   " + AllTrim( Str( nI ) ) + " - Z katalogu " + aEl[ 1 ] + "   " )
         AAdd( aListaKat, aEl[ 1 ] )
      ENDIF
      nI++
   } )

   FOR nI := 1 TO hb_argc()
      IF Upper( hb_argv( nI ) ) == "//GTWVT"
         lJestGTWVT := .T.
         EXIT
      ENDIF
   NEXT

   IF lJestGTWVT
      GShowWindow( .T. )
   ENDIF

   DO WHILE nMenu > 0

      SetColor( "W+/N" )
      CLEAR SCREEN
      @ 5, 0 SAY PadC( "AMi-BOOK - Wyb¢r roku", 80 )

      nIlosc := Len( aLista )

      SetColor( "W/N" )
      @ 11 + nIlosc, 0 SAY PadC( "Enter - Wybierz   /   ESC - Powr¢t", 80 )

      SetColor( "N/W, N/G" )
      @ 7, 19 CLEAR TO 10 + nIlosc, 59
      @ 8, 21 TO 9 + nIlosc, 57
      FOR nI := 1 TO nIlosc
         @ 8 + nI, 26 PROMPT aLista[ nI ]
      NEXT
      MENU TO nMenu

      DO CASE
      CASE nMenu == 1
         KomunUr()
         ErrorLevel( 2 )
         IF lJestGTWVT
            GShowWindow( .F. )
         ENDIF
         RETURN
      CASE nMenu > 1
         Plik( { "cd " + aListaKat[ nMenu ] } )
         KomunUr()
         ErrorLevel( 1 )
         IF lJestGTWVT
            GShowWindow( .F. )
         ENDIF
         RETURN
      ENDCASE

   ENDDO

   ErrorLevel( 3 )

   RETURN

/*----------------------------------------------------------------------*/

