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

FUNCTION edekKonfig()
   LOCAL edeksciezka, pozycje_menu, menusel
      IF !File('paramedek.mem')
         SAVE TO paramedek ALL LIKE param_e*
      ENDIF
      ColSta()
      @  2,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      ColStd()
      @  3,42 say ' Metoda obsˆugi (Wˆasna/Zewn.)        '
      @  4,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      @  5,42 say ' Katalog zapisu plik¢w eDeklaracji    '
      @  6,42 say '                                      '
      @  7,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      @  8,42 say ' Plik programu wysyˆaj¥cego           '
      @  9,42 say '                                      '
      @ 10,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      @ 11,42 say ' Czy pyta† o nazw© pliku?             '
      @ 12,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      @ 13,42 say ' Czy automatycznie wysyˆa† deklaracj©?'
      @ 14,42 say ' (Tak / Nie / Pytaj)                  '
      @ 15,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      @ 16,42 say ' Czy weryfikowa† deklaracj© ?         '
      @ 17,42 say ' (Tak / Nie / Pytaj)                  '
      @ 18,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      @ 19,42 say ' JPK - Metoda obsˆugi  (Wˆ/Zew):      '
      @ 20,42 say ' JPK - Bramka testowa (Tak/Nie):      '
      @ 21,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      @ 22,42 SAY ' Rodzaj SHA (1 - SHA1, 2 - SHA256):   '
      edekKonfigPokaz()
      kl=0
      DO WHILE kl#27
            ColSta()
            @ 1,47 say '[F1]-pomoc'
            ColStd()
            kl=inkey(0)
            DO CASE
            CASE kl=109.or.kl=77
                 @ 1,47 say [          ]
                 ColStb()
                 center(23,[þ                       þ])
                 ColSta()
                 center(23,[M O D Y F I K A C J A])
                 ColStd()
                 begin sequence
                 *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
                       zparamedek_katalog=param_edka
                       zparamedek_program=param_edpr
                       zparam_edpz = param_edpz
                       zparam_edpw = param_edpw
                       zparam_edpv = param_edpv
                       zparam_edmo = param_edmo
                       zparam_ejmo = param_ejmo
                       zparam_ejts = param_ejts
                       zparam_edsh = param_edsh
                       *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
                       @  3, 75 get zparam_edmo PICTURE '!' VALID edekKonfigPoleEdmo()
                       @  6, 43 get zparamedek_katalog picture '@S36' WHEN zparam_edmo == 'Z'
                       @  9, 43 get zparamedek_program picture '@S36' WHEN zparam_edmo == 'Z'
                       @ 11, 68 GET zparam_edpz PICTURE '!' WHEN zparam_edmo == 'Z' VALID edekKonfigPoleEdpz()
                       @ 14, 63 GET zparam_edpw PICTURE '!' WHEN zparam_edmo == 'Z' VALID edekKonfigPoleEdpw()
                       @ 17, 63 GET zparam_edpv PICTURE '!' WHEN zparam_edmo == 'Z' VALID edekKonfigPoleEdpv()
                       @ 19, 76 GET zparam_ejmo PICTURE '!' VALID edekKonfigPoleEjmo()
                       @ 20, 76 GET zparam_ejts PICTURE '!' VALID edekKonfigPoleEjts()
                       @ 22, 78 GET zparam_edsh PICTURE '!' VALID edekKonfigPoleEdsh()
                       ****************************
                       clear type
                       read_()
                       if lastkey()=27
                          break
                       endif
                       *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
                       param_edka=zparamedek_katalog
                       param_edpr=zparamedek_program
                       param_edpz=zparam_edpz
                       param_edpw=zparam_edpw
                       param_edpv=zparam_edpv
                       param_edmo=zparam_edmo
                       param_ejmo = zparam_ejmo
                       param_ejts = zparam_ejts
                       param_edsh = zparam_edsh
                       save to paramedek all like param_e*
                 end
                 edekKonfigPokaz()
                 @ 23,0
                 *################################### POMOC ##################################
            case kl=28
                 save screen to scr_
                 @ 1,47 say [          ]
                 declare p[20]
                 *---------------------------------------
                 p[ 1]='                                             '
                 p[ 2]='     [M].....................modyfikacja     '
                 p[ 3]='     [Esc]...................wyj&_s.cie         '
                 p[ 4]='                                             '
                 *---------------------------------------
                 set color to i
                 i=20
                 j=24
                 do while i>0
                    if type('p[i]')#[U]
                       center(j,p[i])
                       j=j-1
                    endif
                    i=i-1
                 enddo
                 ColStd()
                 pause(0)
                 if lastkey()#27.and.lastkey()#28
                    keyboard chr(lastkey())
                 endif
                 restore screen from scr_
                 _disp=.f.
                 ******************** ENDCASE
            endcase
         enddo
      close_()
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION edekKonfigPoleEdpz()
   IF LastKey()=5
      RETURN .T.
   ENDIF
      IF !zparam_edpz$'TN'
         zparam_edpz = param_edpz
         RETURN .F.
      ENDIF
      set colo to w+
      @ 11,69 say iif(zparam_edpz=[T],[ak],[ie])
      ColStd()
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION edekKonfigPoleEdpw()
   LOCAL txtParam := ''
   IF LastKey()=5
      RETURN .T.
   ENDIF
      IF !zparam_edpw$'TNP'
         zparam_edpw = param_edpw
         RETURN .F.
      ENDIF
      DO CASE
         CASE zparam_edpw == 'T'
            txtParam = 'ak  '
         CASE zparam_edpw == 'N'
            txtParam = 'ie  '
         CASE zparam_edpw == 'P'
            txtParam = 'ytaj'
      ENDCASE
      set colo to w+
      @ 14,64 say txtParam
      ColStd()
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION edekKonfigPoleEdpv()
   LOCAL txtParam := ''
   IF LastKey()=5
      RETURN .T.
   ENDIF
      IF !zparam_edpv$'TNP'
         zparam_edpv = param_edpv
         RETURN .F.
      ENDIF
      DO CASE
         CASE zparam_edpv == 'T'
            txtParam = 'ak  '
         CASE zparam_edpv == 'N'
            txtParam = 'ie  '
         CASE zparam_edpv == 'P'
            txtParam = 'ytaj'
      ENDCASE
      set colo to w+
      @ 17,64 say txtParam
      ColStd()
   RETURN .T.

/*----------------------------------------------------------------------*/


FUNCTION edekKonfigPokaz()
   LOCAL txt_param_edpw := '', txt_param_edpv := ''
      DO CASE
      CASE param_edpw == 'T'
         txt_param_edpw := 'Tak  '
      CASE param_edpw == 'N'
         txt_param_edpw := 'Nie  '
      CASE param_edpw == 'P'
         txt_param_edpw := 'Pytaj'
      ENDCASE

      DO CASE
      CASE param_edpv == 'T'
         txt_param_edpv := 'Tak  '
      CASE param_edpv == 'N'
         txt_param_edpv := 'Nie  '
      CASE param_edpv == 'P'
         txt_param_edpv := 'Pytaj'
      ENDCASE

      clear type
      set colo to w+

      @  3, 75 SAY param_edmo
      @  6, 43 SAY param_edka //PICTURE '@S39'
      @  9, 43 SAY param_edpr //PICTURE '@S39'
      @ 11, 68 SAY iif(param_edpz == 'T', 'Tak', 'Nie')
      @ 14, 63 SAY txt_param_edpw
      @ 17, 63 SAY txt_param_edpv
      @ 19, 76 SAY param_ejmo
      @ 20, 76 SAY param_ejts
      @ 22, 78 SAY param_edsh
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION edekKonfigPoleEdmo()
   IF LastKey()=5
      RETURN .T.
   ENDIF
   IF !zparam_edmo$'WZ'
      zparam_edmo := param_edmo
      RETURN .F.
   ENDIF
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION edekKonfigPoleEjmo()

   IF !zparam_ejmo$'WZ'
      zparam_ejmo := param_ejmo
      RETURN .F.
   ENDIF
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION edekKonfigPoleEjts()

   IF !zparam_ejts$'TN'
      zparam_ejts := param_ejts
      RETURN .F.
   ENDIF
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION edekKonfigPoleEdsh()

   IF !zparam_edsh$'12'
      zparam_edsh := param_edsh
      RETURN .F.
   ENDIF
   RETURN .T.

/*----------------------------------------------------------------------*/
