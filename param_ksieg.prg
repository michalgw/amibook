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

FUNCTION menuKonfigKsiega()
   LOCAL pozycje_menu, menusel
   PRIVATE zparam_ks5v, zparam_ks5d, zparam_kslp, zparam_ksnd, ;
      zparam_kskw, zparam_ksv7

   IF !File('parksg.mem')
      SAVE TO parksg ALL LIKE param_ks*
   ENDIF
   ColSta()
   @  2,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
   ColStd()
   @  3,42 say ' Nliczanie 50% VAT na poj. (1/2)      '
   @  4,42 say ' 1 - Ksi©ga: Netto + 50% VAT          '
   @  5,42 say ' 2 - Ksi©ga: 50% Netto + 50% VAT      '
   @  6,42 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @  7,42 say ' Obliczanie podstawy opodatkowania    '
   @  8,42 say ' deklaracji VAT-7 (pole 43.)          '
   @  9,42 say ' dla 50% VAT na pojazdy (1/2):        '
   @ 10,42 say ' 1 - 100%     2 - 50%                 '
   @ 11,42 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @ 12,42 say ' Sortowanie dokument¢w w ksi©dze      '
   @ 13,42 say ' (1 - Nr dok./Dzieä, 2 - Dzieä)       '
   @ 14,42 say ' (3 - Lp./Dzieä )                     '
   @ 15,42 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @ 16,42 say ' Inf. o wprowadzeniu dok. z istn. nr  '
   @ 17,42 say ' (N-nie, T-akt.miesiac, R-rok):       '
   @ 18,42 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @ 19,42 say ' Odliczanie kwoty wolnej po przekr.   '
   @ 20,42 say ' progu (Tak/Nie)                      '
   @ 21,42 say ' Obsˆuga p¢l JPK_V7 (Tak/Nie)         '
   @ 22,42 say ' Pami©taj ostani symb. rej.(T/N)      '
   menuKonfigKsiegaPokaz()
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
                 zparam_ks5v := param_ks5v
                 zparam_ks5d := param_ks5d
                 zparam_kslp := param_kslp
                 zparam_ksnd := param_ksnd
                 zparam_kskw := param_kskw
                 zparam_ksv7 := param_ksv7
                 zparam_kssr := param_kssr
                 *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
                 @  3, 76 get zparam_ks5v PICTURE '!' VALID menuKonfigKsiegaPolKS5V()
                 @  9, 76 get zparam_ks5d PICTURE '!' VALID menuKonfigKsiegaPolKS5D()
                 @ 14, 62 get zparam_kslp PICTURE '!' VALID menuKonfigKsiegaPolKSLP()
                 @ 17, 74 get zparam_ksnd PICTURE '!' VALID menuKonfigKsiegaPolKSND()
                 @ 20, 72 get zparam_kskw PICTURE '!' VALID menuKonfigKsiegaPolKSKW()
                 @ 21, 72 get zparam_ksv7 PICTURE '!' VALID menuKonfigKsiegaPolKSV7()
                 @ 22, 75 get zparam_kssr PICTURE '!' VALID menuKonfigKsiegaPolKSSR()
                 ****************************
                 clear type
                 read_()
                 if lastkey()=27
                    break
                 endif
                 *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
                 param_ks5v := zparam_ks5v
                 param_ks5d := zparam_ks5d
                 param_kslp := zparam_kslp
                 param_ksnd := zparam_ksnd
                 param_kskw := zparam_kskw
                 param_ksv7 := zparam_ksv7
                 param_kssr := zparam_kssr
                 save TO parksg all like param_ks*
                 SWITCH param_kslp
                 CASE '1'
                    WERSJA4 := .T.
                    EXIT
                 CASE '2'
                    WERSJA4 := .F.
                    EXIT
                 CASE '3'
                    WERSJA4 := .F.
                    EXIT
                 ENDSWITCH
           end
           menuKonfigKsiegaPokaz()
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

FUNCTION menuKonfigKsiegaPolKS5V()
   IF LastKey()=5
      RETURN .T.
   ENDIF
      IF !zparam_ks5v$'12'
         zparam_ks5v = param_ks5v
         RETURN .F.
      ENDIF
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION menuKonfigKsiegaPolKS5D()
   IF LastKey()=5
      RETURN .T.
   ENDIF
      IF !zparam_ks5d$'12'
         zparam_ks5d = param_ks5d
         RETURN .F.
      ENDIF
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION menuKonfigKsiegaPolKSLP()
   IF LastKey()=5
      RETURN .T.
   ENDIF
   IF !zparam_kslp$'123'
      zparam_kslp = param_kslp
      RETURN .F.
   ENDIF
   IF zparam_kslp == '3' .AND. param_lp <> 'T'
      zparam_kslp = param_kslp
      komun('Ta opcja dost©pna jest jedyne przy wˆ¥czonej Lp. ksi©gi')
      RETURN .F.
   ENDIF
   set colo to w+
   SWITCH zparam_kslp
   CASE '1'
      @ 14, 63 SAY ' - Nr dok./Dzieä        '
      EXIT
   CASE '2'
      @ 14, 63 SAY ' - Dzieä'
      EXIT
   CASE '3'
      @ 14, 63 SAY ' - Lp/Dzieä     '
      EXIT
   ENDSWITCH
   ColStd()
   RETURN .T.

/*----------------------------------------------------------------------*/

PROCEDURE menuKonfigKsiegaPokaz()
   clear type
   set colo to w+
   @  3, 76 SAY param_ks5v
   @  9, 76 SAY param_ks5d
   @ 17, 74 SAY param_ksnd
   @ 20, 72 SAY iif(param_kskw == 'T', 'Tak', 'Nie')
   @ 21, 72 SAY iif(param_ksv7 == 'T', 'Tak', 'Nie')
   @ 22, 75 SAY iif(param_kssr == 'T', 'Tak', 'Nie')
   SWITCH param_kslp
   CASE '1'
      @ 14, 62 SAY '1 - Nr dok./Dzieä'
      EXIT
   CASE '2'
      @ 14, 62 SAY '2 - Dzieä        '
      EXIT
   CASE '3'
      @ 14, 62 SAY '3 - Lp/Dzieä     '
      EXIT
   ENDSWITCH
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION menuKonfigKsiegaPolKSND()
   IF LastKey()=5
      RETURN .T.
   ENDIF
      IF !zparam_ksnd$'TNR'
         zparam_ksnd = param_ksnd
         RETURN .F.
      ENDIF
   //@ 19, 73 SAY iif(param_ksnd == 'T', 'ak', 'ie')
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION menuKonfigKsiegaPolKSKW()
   IF LastKey()=5
      RETURN .T.
   ENDIF
      IF !zparam_kskw$'TN'
         zparam_kskw = param_kskw
         RETURN .F.
      ENDIF
   @ 20, 73 SAY iif(zparam_kskw == 'T', 'ak', 'ie')
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION menuKonfigKsiegaPolKSV7()
   IF LastKey()=5
      RETURN .T.
   ENDIF
      IF !zparam_ksv7$'TN'
         zparam_ksv7 = param_ksv7
         RETURN .F.
      ENDIF
   @ 21, 73 SAY iif(zparam_ksv7 == 'T', 'ak', 'ie')
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION menuKonfigKsiegaPolKSSR()
   IF LastKey()=5
      RETURN .T.
   ENDIF
      IF !zparam_kssr$'TN'
         zparam_kssr = param_kssr
         RETURN .F.
      ENDIF
   @ 22, 76 SAY iif(zparam_kssr == 'T', 'ak', 'ie')
   RETURN .T.

/*----------------------------------------------------------------------*/
