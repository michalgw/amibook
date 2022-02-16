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
      staw_rk09 := 0.14
      staw_rk10 := 0.12
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
   zstaw_rk09 := staw_rk09 * 100
   zstaw_rk10 := staw_rk10 * 100

   zstaw_ohand := staw_ohand
   zstaw_oprod := staw_oprod
   zstaw_ouslu := staw_ouslu
   zstaw_ory20 := staw_ory20
   zstaw_ory17 := staw_ory17
   zstaw_ory10 := staw_ory10
   zstaw_ork07 := staw_ork07
   zstaw_ork08 := staw_ork08
   zstaw_ork09 := staw_ork09
   zstaw_ork10 := staw_ork10

   *################################# GRAFIKA ##################################
   ColStd()
   @  3, 42 CLEAR TO 22, 79
   @  9, 42 SAY 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
   @ 10, 42 SAY 'ºKol³   Rodzaj sprzeda¾y   ³ Stawka% º'
   @ 11, 42 SAY 'ºÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄº'
   @ 12, 42 SAY 'º 5 ³                      ³         º'
   @ 13, 42 SAY 'º 6 ³                      ³         º'
   @ 14, 42 SAY 'º 7 ³                      ³         º'
   @ 15, 42 SAY 'º 8 ³                      ³         º'
   @ 16, 42 SAY 'º 9 ³                      ³         º'
   @ 17, 42 SAY 'º 10³                      ³         º'
   @ 18, 42 SAY 'º 11³                      ³         º'
   @ 19, 42 SAY 'º 12³                      ³         º'
   @ 20, 42 SAY 'º 13³                      ³         º'
   IF staw_k08w
      @ 21, 42 SAY 'º 14³                      ³         º'
      @ 22, 42 SAY 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'
   ELSE
      @ 21, 42 SAY 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'
   ENDIF

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
            @ 12, 48 GET zstaw_ory20 PICTURE '@S21 XXXXXXXXXXXXXXXXXXXXXXXX'
            @ 12, 72 GET zstaw_ry20 PICTURE '99.99'
            @ 13, 48 GET zstaw_ory17 PICTURE '@S21 XXXXXXXXXXXXXXXXXXXXXXXX'
            @ 13, 72 GET zstaw_ry17 PICTURE '99.99'
            @ 14, 48 GET zstaw_ork09 PICTURE '@S21 XXXXXXXXXXXXXXXXXXXXXXXX'
            @ 14, 72 GET zstaw_rk09 PICTURE '99.99'
            @ 15, 48 GET zstaw_ouslu PICTURE '@S21 XXXXXXXXXXXXXXXXXXXXXXXX'
            @ 15, 72 GET zstaw_uslu PICTURE '99.99'
            @ 16, 48 GET zstaw_ork10 PICTURE '@S21 XXXXXXXXXXXXXXXXXXXXXXXX'
            @ 16, 72 GET zstaw_rk10 PICTURE '99.99'
            @ 17, 48 GET zstaw_oprod PICTURE '@S21 XXXXXXXXXXXXXXXXXXXXXXXX'
            @ 17, 72 GET zstaw_prod PICTURE '99.99'
            @ 18, 48 GET zstaw_ohand PICTURE '@S21 XXXXXXXXXXXXXXXXXXXXXXXX'
            @ 18, 72 GET zstaw_hand PICTURE '99.99'
            @ 19, 48 GET zstaw_ork07 PICTURE '@S21 XXXXXXXXXXXXXXXXXXXXXXXX'
            @ 19, 72 GET zstaw_rk07 PICTURE '99.99'
            @ 20, 48 GET zstaw_ory10 PICTURE '@S21 XXXXXXXXXXXXXXXXXXXXXXXX'
            @ 20, 72 GET zstaw_ry10 PICTURE '99.99'
            IF staw_k08w
               @ 21, 48 GET zstaw_ork08 PICTURE '@S21 XXXXXXXXXXXXXXXXXXXXXXXX'
               @ 21, 72 GET zstaw_rk08 PICTURE '99.99'
            ENDIF
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
            staw_rk09 := zstaw_rk09 / 100
            staw_rk10 := zstaw_rk10 / 100

            staw_ohand := zstaw_ohand
            staw_oprod := zstaw_oprod
            staw_ouslu := zstaw_ouslu
            staw_ory20 := zstaw_ory20
            staw_ory17 := zstaw_ory17
            staw_ory10 := zstaw_ory10
            staw_ork07 := zstaw_ork07
            staw_ork08 := zstaw_ork08
            staw_ork09 := zstaw_ork09
            staw_ork10 := zstaw_ork10

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
   @ 12, 48 SAY Pad( SubStr( zstaw_ory20, 1, 21 ), 21 )
   @ 12, 72 SAY zstaw_ry20 PICTURE '99.99'
   @ 13, 48 SAY Pad( SubStr( zstaw_ory17, 1, 21 ), 21 )
   @ 13, 72 SAY zstaw_ry17 PICTURE '99.99'
   @ 14, 48 SAY Pad( SubStr( zstaw_ork09, 1, 21 ), 21 )
   @ 14, 72 SAY zstaw_rk09 PICTURE '99.99'
   @ 15, 48 SAY Pad( SubStr( zstaw_ouslu, 1, 21 ), 21 )
   @ 15, 72 SAY zstaw_uslu PICTURE '99.99'
   @ 16, 48 SAY Pad( SubStr( zstaw_ork10, 1, 21 ), 21 )
   @ 16, 72 SAY zstaw_rk10 PICTURE '99.99'
   @ 17, 48 SAY Pad( SubStr( zstaw_oprod, 1, 21 ), 21 )
   @ 17, 72 SAY zstaw_prod PICTURE '99.99'
   @ 18, 48 SAY Pad( SubStr( zstaw_ohand, 1, 21 ), 21 )
   @ 18, 72 SAY zstaw_hand PICTURE '99.99'
   @ 19, 48 SAY Pad( SubStr( zstaw_ork07, 1, 21 ), 21 )
   @ 19, 72 SAY zstaw_rk07 PICTURE '99.99'
   @ 20, 48 SAY Pad( SubStr( zstaw_ory10, 1, 21 ), 21 )
   @ 20, 72 SAY zstaw_ry10 PICTURE '99.99'
   IF staw_k08w
      @ 21, 48 SAY Pad( SubStr( zstaw_ork08, 1, 21 ), 21 )
      @ 21, 72 SAY zstaw_rk08 PICTURE '99.99'
   ENDIF
   ColStd()

   RETURN

*############################################################################

FUNCTION Tab_RyczInfo()

   RETURN "5-" + NumToStr( staw_ry20 * 100 ) + "%, 6-" + NumToStr( staw_ry17 * 100 ) + "%" ;
      + ", 7-" + NumToStr( staw_rk09 * 100 ) + "%, 8-" + NumToStr( staw_uslu * 100 ) + "%" ;
      + ", 9-" + NumToStr( staw_rk10 * 100 ) + "%, 10-" + NumToStr( staw_prod * 100 ) + "%" ;
      + ", 11-" + NumToStr( staw_hand * 100 ) + "%, 12-" + NumToStr( staw_rk07 * 100 ) + "%" ;
      + ", 13-" + NumToStr( staw_ry10 * 100 ) + "%"

/*----------------------------------------------------------------------*/
