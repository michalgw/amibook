/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

#include "inkey.ch"

PROCEDURE Kat_Rej_()

   PRIVATE _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot
   PRIVATE _stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou

   @ 1, 47 SAY '          '
   IF del # '+'
      Kom( 3, '*u', ' Brak zdefiniowanych rejestr&_o.w ' )
      KEYBOARD Chr( 27 )
      Inkey()
      RETURN
   ENDIF

   *################################# GRAFIKA ##################################
   CURR := ColStd()
   @  8, 11 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
   @  9, 11 SAY '°                                           °'
   @ 10, 11 SAY '°                                           °'
   @ 11, 11 SAY '°                                           °'
   @ 12, 11 SAY '°                                           °'
   @ 13, 11 SAY '°                                           °'
   @ 14, 11 SAY '°                                           °'
   @ 15, 11 SAY '°                                           °'
   @ 16, 11 SAY '°                                           °'
   @ 17, 11 SAY '°                                           °'
   @ 18, 11 SAY '°                                           °'
   @ 19, 11 SAY '°                                           °'
   @ 20, 11 SAY '°                                           °'
   @ 21, 11 SAY '°                                           °'
   @ 22, 11 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'

   *################################# OPERACJE #################################

   *----- parametry ------
   _row_g := 9
   _col_l := 12
   _row_d := 21
   _col_p := 54
   _invers := [i]
   _curs_l := 0
   _curs_p := 0
   _esc := '27,28,13,32'
   _top := 'firma#ident_fir'
   _bot := "del#'+'.or.firma#ident_fir"
   _stop := '+' + ident_fir
   _sbot := '+' + ident_fir + 'þ'
   _proc := 'linia155()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := ''
   _disp := .T.
   _cls := ''

   *----------------------
   kl := 0
   DO WHILE kl # K_ESC .AND. kl # K_ENTER .AND. kl # Asc( ' ' )
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := Wybor( _row )
      SetColor( CURR )
      kl := LastKey()
      DO CASE
      *################################### POMOC ##################################
      CASE kl == K_F1
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                        '
         p[ 2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
         p[ 3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[ 4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[ 5 ] := '   [Enter].................akceptacja                   '
         p[ 6 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 7 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO i
         i := 20
         j := 24
         DO WHILE i > 0
            IF Type( 'p[i]' ) # 'U'
               Center( j, p[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         Pause( 0 )
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      ******************** ENDCASE
      ENDCASE
   ENDDO
   SetColor( CURR )
   RETURN

*################################## FUNKCJE #################################

FUNCTION linia155()

   RETURN SYMB_REJ + ' ' + OPIS

*############################################################################

FUNCTION Kat_Rej_Wybierz( cSymbolRej, nTop, nLeft, cRej )

   LOCAL lWybrano := .F.
   LOCAL cScreen := SaveScreen()
   LOCAL nArea := Select()
   LOCAL cKolor := SetColor()
   LOCAL cTab

   hb_default( @cRej, 'S' )

   IF cRej == 'S'
      cTab := 'KAT_SPR'
   ELSE
      cTab := 'KAT_ZAK'
   ENDIF

   DO WHILE ! DostepPro( cTab, cTab, , 'kat_sp_wyb' )
   ENDDO

   kat_sp_wyb->( dbSeek( '+' + ident_fir + cSymbolRej ) )
   IF kat_sp_wyb->del # '+' .OR. kat_sp_wyb->firma # ident_fir
      kat_sp_wyb->( dbSkip( -1 ) )
   ENDIF
   IF kat_sp_wyb->del == '+' .AND. kat_sp_wyb->firma == ident_fir

      Kat_Rej_()

      RestScreen( , , , , cScreen )

      IF LastKey() == K_ENTER

         cSymbolRej := kat_sp_wyb->symb_rej

         IF PCount() == 3
            SET COLOR TO i
            @ nTop, nLeft SAY cSymbolRej
            SET COLOR TO
         ENDIF

         lWybrano := .T.

      ENDIF

   ENDIF

   kat_sp_wyb->( dbCloseArea() )
   Select( nArea )
   SetColor( cKolor )

   RETURN lWybrano

/*----------------------------------------------------------------------*/

