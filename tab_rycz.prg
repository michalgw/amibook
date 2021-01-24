/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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
*±±±±±± TAB_RYCZ ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul stawek podatku zrycz. przechowywanych w pliku TAB_RYCZ.MEM          ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Tab_Rycz()

   IF .NOT. File( 'tab_rycz.mem' )
      PUBLIC staw_hand, staw_prod, staw_uslu, staw_ry20, staw_ry17, staw_ry10, ;
         staw_rk07, staw_rk08
      staw_hand := 0.03
      staw_prod := 0.055
      staw_uslu := 0.085
      staw_ry20 := 0.17
      staw_ry17 := 0.15
      staw_ry10 := 0.1
      staw_rk07 := 0.125
      staw_rk08 := 0.02
      SAVE TO tab_rycz ALL LIKE staw_*
      RETURN
   ENDIF

   zstaw_hand := staw_hand * 100
   zstaw_prod := staw_prod * 100
   zstaw_uslu := staw_uslu * 100
   zstaw_ry20 := staw_ry20 * 100
   zstaw_ry17 := staw_ry17 * 100
   zstaw_ry10 := staw_ry10 * 100
   zstaw_rk07 := staw_rk07 * 100
   zstaw_rk08 := staw_rk08 * 100

   *################################# GRAFIKA ##################################
   ColStd()
   @  3, 42 CLEAR TO 22, 79
   @  9, 48 SAY 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
   @ 10, 48 SAY 'º   Rodzaj  ³  Stawka º'
   @ 11, 48 SAY 'º sprzeda&_z.y ³    %    º'
   @ 12, 48 SAY 'ºÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄº'
   @ 13, 48 SAY 'º Handel    ³         º'
   @ 14, 48 SAY 'º Produkcja ³         º'
   @ 15, 48 SAY 'º Us&_l.ugi    ³         º'
   @ 16, 48 SAY 'º Wolne zaw.³         º'
   @ 17, 48 SAY 'º Inne us&_l.u.³         º'
   @ 18, 48 SAY 'º Prawa maj.³         º'
   @ 19, 48 SAY 'º Wyn.100000³         º'
   @ 20, 48 SAY 'º Ar.6.us.1d³         º'
   @ 21, 48 SAY 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'

   *################################# OPERACJE #################################
   say_r()
   kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      ColStd()
      kl := Inkey( 0 )
      DO CASE
      *############################### MODYFIKACJA ################################
      CASE kl == 109 .OR. kl == 77
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                       þ' )
         ColSta()
         center( 23, 'M O D Y F I K A C J A' )
         ColStd()
         BEGIN SEQUENCE
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ 13, 63 GET zstaw_hand PICTURE '99.99'
            @ 14, 63 GET zstaw_prod PICTURE '99.99'
            @ 15, 63 GET zstaw_uslu PICTURE '99.99'
            @ 16, 63 GET zstaw_ry20 PICTURE '99.99'
            @ 17, 63 GET zstaw_ry17 PICTURE '99.99'
            @ 18, 63 GET zstaw_ry10 PICTURE '99.99'
            @ 19, 63 GET zstaw_rk07 PICTURE '99.99'
            @ 20, 63 GET zstaw_rk08 PICTURE '99.99'
            ****************************
            CLEAR TYPEAHEAD
            read_()
            IF LastKey() == 27
               BREAK
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            staw_hand := zstaw_hand / 100
            staw_prod := zstaw_prod / 100
            staw_uslu := zstaw_uslu / 100
            staw_ry20 := zstaw_ry20 / 100
            staw_ry17 := zstaw_ry17 / 100
            staw_ry10 := zstaw_ry10 / 100
            staw_rk07 := zstaw_rk07 / 100
            staw_rk08 := zstaw_rk08 / 100
            SAVE TO tab_rycz ALL LIKE staw_*
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
         END
         say_r()
         @ 23, 0
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                            '
         p[ 2 ] := '     [M].....................modyfikacja                    '
         p[ 3 ] := '     [D].....................przywr¢c domy˜lne warto˜ci     '
         p[ 4 ] := '     [Esc]...................wyj&_s.cie                        '
         p[ 5 ] := '                                                            '
         *---------------------------------------
         SET COLOR TO i
         i := 20
         j := 24
         DO WHILE i > 0
            IF Type( 'p[i]' ) # 'U'
               center( j, p[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         Pause( 0 )
         IF LastKey() # 27 .AND. LastKey() # 28
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.

      CASE kl == Asc( 'D' ) .OR. kl == Asc( 'd' )

         IF TNEsc( , "Czy przywr¢ci† domy˜ln¥ tabel© stawek podatku ? (Tak/Nie)" )
            DomParPrzywroc_TabRycz( .T., DomParRok() )
            say_r()
         ENDIF

      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()

*################################## FUNKCJE #################################
PROCEDURE say_r()

   CLEAR TYPEAHEAD
   SET COLOR TO w+
   @ 13, 63 SAY zstaw_hand PICTURE '99.99'
   @ 14, 63 SAY zstaw_prod PICTURE '99.99'
   @ 15, 63 SAY zstaw_uslu PICTURE '99.99'
   @ 16, 63 SAY zstaw_ry20 PICTURE '99.99'
   @ 17, 63 SAY zstaw_ry17 PICTURE '99.99'
   @ 18, 63 SAY zstaw_ry10 PICTURE '99.99'
   @ 19, 63 SAY zstaw_rk07 PICTURE '99.99'
   @ 20, 63 SAY zstaw_rk08 PICTURE '99.99'
   ColStd()

   RETURN

*############################################################################
