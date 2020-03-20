/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michaà Gawrycki (gmsystems.pl)

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

FUNCTION Polska3()

do case
case POLSKA_3='0'
     POLA='W'
case POLSKA_3='1'
     POLA='E'
case POLSKA_3='2'
     POLA='L'
endcase
POLD=POLSKA_D
set curs on
@ 18,25 get POLA pict '!' when wPOLA() valid vPOLA()
read
if lastkey()#27.and.POLA#'W'
   @ 18,31 get POLD pict '!' when wPOLD() valid vPOLD()
   read
endif
set curs off
if lastkey()#27
   ColStd()
   @ 24,0
   do case
   case POLA='W'
        POLSKA_3='0'
   case POLA='E'
        POLSKA_3='1'
   case POLA='L'
        POLSKA_3='2'
   endcase
   if POLSKA_3#'0'
      x=fcreate('POLZNAK.DRU',0)
      do case
      case POLD='M'
           znaki='èïêú•£ò†°Üçëí§¢û¶ß'
      case POLD='L'
           znaki='§è®ù„‡óçΩ•Ü©à‰¢ò´æ'
      case POLD='I'
           znaki='°∆ £—”¶¨Ø±ÊÍ≥ÒÛ∂ºø'
      other
           znaki='ACEú•OSZZacel§¢szz'
      endcase
      if ferror()=0
         fwrite(x,znaki,18)
      endif
      fclose(x)
   endif
   POLSKA_D=POLD
   save to POLSKA all like POLSKA_*
   /* Nic nie zapisujemy
   x=fcreate('POLSKA.BAT',0)
   if ferror()=0
      if POLSKA_1=.t.
         znaki1='@call POLSKA1'+chr(13)+chr(10)
      else
         znaki1='rem @call POLSKA1'+chr(13)+chr(10)
      endif
      if POLSKA_2=.t.
         znaki2='@call POLSKA2'+chr(13)+chr(10)
      else
         znaki2='rem @call POLSKA2'+chr(13)+chr(10)
      endif
      do case
      case POLSKA_3='0'
           znaki3='rem @call POLSKA3'+chr(13)+chr(10)
      case POLSKA_3='1'
           znaki3='@call POLSKA3 Z'+chr(13)+chr(10)
      case POLSKA_3='2'
           znaki3='@call POLSKA3 X'+chr(13)+chr(10)
      endcase
      fwrite(x,znaki1+znaki2+znaki3+chr(26))
   endif
   fclose(x)
   */
   do KOMUN with 'Zmiany zadzia&_l.aj&_a. po ponownym uruchomieniu programu i w&_l.&_a.czeniu drukarki'
endif
ColStd()
@ 24,0
*************************************
func wPOLA
*************************************
ColInf()
@ 24,0 say padc('Wpisz: W-nie obs&_l.ugiwa&_c. drukarki, E-znaki w EPROM-ie lub L-programowa&_c. drukark&_e.',80,' ')
ColStd()
@ 18,26 say iif(POLA='E','PROM-',iif(POLA='L','OAD -','y&_l.&_a.czone '))
return .t.
*************************************
func vPOLA
*************************************
R=.f.
if POLA$'WEL'
   ColStd()
   @ 18,26 say iif(POLA='E','PROM-',iif(POLA='L','OAD -','y&_l.&_a.czone '))
   R=.t.
else
   ColInf()
   @ 24,0 say padc('Wpisz: W-nie obs&_l.ugiwa&_c. drukarki, E-znaki w EPROM-ie lub L-programowa&_c. drukark&_e.',80,' ')
   ColStd()
endif
return R
*************************************
func wPOLD
*************************************
ColInf()
@ 24,0 say padc('Wpisz: N-bez polskich, L-LATIN2 CP852, I-ISO LATIN2 lub M-Mazovia',80,' ')
ColStd()
@ 18,32 say iif(POLD='L','AT',;
            iif(POLD='I','SO',;
            iif(POLD='M','AZ','ON')))
return .t.
*************************************
func vPOLD
*************************************
R=.f.
if POLD$'LIMN'
   ColStd()
   @ 18,32 say iif(POLD='L','AT',;
               iif(POLD='I','SO',;
               iif(POLD='M','AZ','ON')))
   R=.t.
else
   ColInf()
   @ 24,0 say padc('Wpisz: N-bez polskich, L-LATIN2 CP852, I-ISO LATIN2 lub M-Mazovia',80,' ')
   ColStd()
endif
return R
