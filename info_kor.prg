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

*################################# GRAFIKA ##################################
kwoty_k=array(12,4)
for x_y=1 to 12
    kwoty_k[x_y,1]=0
    kwoty_k[x_y,2]=0
    kwoty_k[x_y,3]=0
    kwoty_k[x_y,4]=0
next

INNE_1=0
INNE_2=0

@  3,0 clear to 22,79
ColInf()
@  3,0 say '[ESC]-wyjscie                                                  [D]-wydruk ekranu'
ColStd()
@  4,0 say ' Wyliczenie struktury sprzeda&_z.y za rok '+str(val(param_rok),4)+' i kwoty korekty zakup&_o.w pozosta&_l.ych '
@  5,0 say '                    WARTO&__S.&__C. NETTO SPRZEDA&__Z.Y      VAT OD ZAKUP.MIESZ.POZOSTA&__L.E   '
@  6,0 say '                OPODATKOWANA        OG&__O.&__L.EM      WG DOKUMENTU  NAL.STR.WG '+str(val(param_rok)-1,4)+'   '
@  7,0 say ' Stycze&_n.....:                                                                   '
@  8,0 say ' Luty.......:                                                                   '
@  9,0 say ' Marzec.....:                                                                   '
@ 10,0 say ' Kwiecie&_n....:                                                                   '
@ 11,0 say ' Maj........:                                                                   '
@ 12,0 say ' Czerwiec...:                                                                   '
@ 13,0 say ' Lipiec.....:                                                                   '
@ 14,0 say ' Sierpie&_n....:                                                                   '
@ 15,0 say ' Wrzesie&_n....:                                                                   '
@ 16,0 say ' Pa&_x.dziernik:                                                                   '
@ 17,0 say ' Listopad...:                                                                   '
@ 18,0 say ' Grudzie&_n....:                                                                   '
@ 19,0 say ' INNE.......:                                                                   '
@ 20,0 say ' RAZEM......:                                                                   '
@ 21,0 say ' Struktura rzeczywista za '+str(val(param_rok),4)+' w %.:     Zaktualizowano na z&_l..:                 '
@ 22,0 say ' Warto&_s.&_c. korekty od zakup&_o.w pozosta&_l.ych do VAT-7 za okr.I.'+str(val(param_rok)+1,4)+':                 '
*################################ OBLICZENIA ################################
set cursor off
do czekaj

select 3
if dostep('FIRMA')
   go val(ident_fir)
   spolka_=spolka
else
   break
endif

zstrusprob=strusprob
use

_koniec="del#[+].or.firma#ident_fir.or.eof()"

select 5
if dostep('REJZ')
   do setind with 'REJZ'
   seek '+'+IDENT_FIR
   KONIEC1=&_koniec
else
   break
endif

select 1
if dostep('REJS')
   do setind with 'REJS'
   seek '+'+IDENT_FIR
else
   break
endif

sele rejs
do while .not.&_koniec
   mies_dok=val(alltrim(MC))
   if mies_dok>0 .and. mies_dok<13
      kwoty_k[mies_dok,1]=kwoty_k[mies_dok,1]+WART02+WART07+WART22+WART00+WART08
      kwoty_k[mies_dok,2]=kwoty_k[mies_dok,2]+WART02+WART07+WART22+WART00+WART08+WARTZW
   endif

*  p61=p61+WART02
*  p62=p62+VAT02
***p61a=p61a+WART12
***p62a=p62a+VAT12
*  p64=p64+WARTZW
*  p69=p69+WART07
*  p70=p70+VAT07
*  p71=p71+WART22
*  p72=p72+VAT22
*  if WART00<>0.00
*     if UE='T'
*        p65ue=p65ue+rejs->WART00
*     endif
*     if UE<>'T'.and.EXPORT='T'
*        p65=p65+rejs->WART00
*     endif
*     if UE<>'T'.and.EXPORT<>'T'
*        p67=p67+rejs->WART00
*     endif
*  endif
   skip 1
enddo

do poka_korva

sele REJZ
do while .not.&_koniec
   mies_dok=val(alltrim(MC))
   if mies_dok>0 .and. mies_dok<13 .and. RACH='F'
      kwoty_k[mies_dok,3]=kwoty_k[mies_dok,3]+iif(SP02='P'.and.ZOM02='M',VAT02,0)+iif(SP07='P'.and.ZOM07='M',VAT07,0)+iif(SP22='P'.and. ZOM22='M',VAT22,0)+iif(SP12='P'.and. ZOM12='M',VAT12,0)
   endif
   skip 1
enddo

for x_y=1 to 12
    kwoty_k[x_y,4]=_round(kwoty_k[x_y,3]*(zstrusprob/100),2)
next

sele 5
use
sele 1
use

do poka_korva

@ 23,0 clear
set curs on

do while lastkey()<>27
   @ 19,15 get INNE_1 pict '  999999999.99'
   @ 19,31 get INNE_2 pict '  999999999.99'
   read

   do poka_korva

   @ 23,0 say '[D lub PrintScreen]-drukowanie ekranu    [Inny klawisz]-wpisanie nowych wartosci'
   kkk=inkey(0)
   if kkk=68.or.kkk=100
      //x=fcreate('c:\ekrstrva.txt',0)
      zm=savescreen(0,0,24,79)
      zm__=''
      zm__=zm__+&kod_res+&kod_12cp+&kod_6wc
      zm__=zm__+repl('=',80)+chr(13)+chr(10)
      zm__=zm__+''+chr(13)+chr(10)
      for j=4 to 22
          for i=1 to 159 step 2
              zm__=zm__+substr(zm,j*160+i,1)
          next
          zm__=zm__+chr(13)+chr(10)
      next
      zm__=zm__+''+chr(13)+chr(10)
      zm__=zm__+repl('=',80)+chr(13)+chr(10)
      zm__=zm__+&kod_ff
      //fwrite(x,zm__,len(zm__))
      //fclose(x)
      //!copy c:\ekrstrva.txt lpt1:
      DrukujNowyProfil(zm__)
   endif
   @ 23,0 say '                                                                                '
enddo
set curs off
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
procedure poka_korva

SET COLOR TO W+

zrokopod=0
zrokogol=0
zvatdoku=0
zvatstru=0
zstrusprwy=0

for x_y=1 to 12
    @ 6+x_y,15 say kwoty_k[x_y,1] pict '999 999 999.99'
    @ 6+x_y,31 say kwoty_k[x_y,2] pict '999 999 999.99'
    zrokopod=zrokopod+kwoty_k[x_y,1]
    zrokogol=zrokogol+kwoty_k[x_y,2]
    @ 6+x_y,47 say kwoty_k[x_y,3] pict '999 999 999.99'
    @ 6+x_y,63 say kwoty_k[x_y,4] pict '999 999 999.99'
    zvatdoku=zvatdoku+kwoty_k[x_y,3]
    zvatstru=zvatstru+kwoty_k[x_y,4]
next

@ 19,15 say INNE_1 pict '999 999 999.99'
@ 19,31 say INNE_2 pict '999 999 999.99'

zrokopod=zrokopod+INNE_1
zrokogol=zrokogol+INNE_2

@ 20,15 say zrokopod pict '999 999 999.99'
@ 20,31 say zrokogol pict '999 999 999.99'
@ 20,47 say zvatdoku pict '999 999 999.99'
@ 20,63 say zvatstru pict '999 999 999.99'

if zrokogol<>0.0
   zstrusprwy=(zrokopod/zrokogol)*100
   if zstrusprwy<=2.00
      zstrusprwy=0.00
   endif
   if zstrusprwy>=98.00
      zstrusprwy=100.00
   endif
   if zstrusprwy-int(zstrusprwy)>0.000000
      zstrusprwy=int(zstrusprwy)+1
   else
      zstrusprwy=int(zstrusprwy)
   endif
endif
@ 21,36 say zstrusprwy pict '999'

zvatnew=_round(zvatdoku*(zstrusprwy/100),2)

@ 21,63 say zvatnew pict '999 999 999.99'

zvatkorn=_int(zvatnew-zvatstru)

@ 22,63 say zvatkorn pict '999 999 999.99'

SET COLOR TO

