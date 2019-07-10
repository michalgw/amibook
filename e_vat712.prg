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

*param ubezp
*private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
@ 1,47 say [          ]
*############################### OTWARCIE BAZ ###############################
   @ 3,42 clear to 22,79
   save screen to scr2
   *--------------------------------------
   param_v7()
   jeden=v7_zglo()
   if jeden#1
      close_()
      return
   endif
   set console off
   set device to print
   set print on
   NUFIR=val(alltrim(ident_fir))
   Nufir1=HI36(nufir)
   nufir2=LO36(nufir)
   xtypdok=alltrim(zPOLESTO)
   xtypdok=iif(len(alltrim(xtypdok))=0,'7',xtypdok)
   xwerdok=strtran(strtran(alltrim(zWERVAT),')',''),'(','')
   xwerdok=iif(len(alltrim(xwerdok))=1,'0'+xwerdok,xwerdok)
   PLIK_DEK=substr(param_rok,4,1)+;
            iif(val(miesiac)>9,chr(55+val(miesiac)),alltrim(miesiac))+;
            iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
            iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
            'V'+;
            xtypdok+;
            xwerdok+'.xml'
   aaaa=alltrim(parv7_cel)+PLIK_DEK
   set printer to &aaaa

   do case
   case miesiac=' 1'.or.miesiac=' 3'.or.miesiac=' 5'.or.miesiac=' 7'.or.miesiac=' 8'.or.miesiac='10'.or.miesiac='12'
        DAYM='31'
   case miesiac=' 4'.or.miesiac=' 6'.or.miesiac=' 9'.or.miesiac='11'
        DAYM='30'
   case miesiac=' 2'
        DAYM='29'
        if day(ctod(param_rok+'.'+miesiac+'.'+DAYM))=0
           DAYM='28'
        endif
   endcase
   DDAY=ctod(param_rok+'.'+miesiac+'.'+DAYM)

   edekl_pocz()
   vat_pocz('VAT-7'+alltrim(zPOLESTO)+' '+alltrim(zWERVAT),'VAT-7','VAT','Z','2-0E',strtran(strtran(alltrim(zWERVAT),')',''),'(',''),'P_7',iif(kordek='D','1','2'),p5b,alltrim(p5a),p6a)
   podm1_nagl('Podatnik')
   if spolka_=.f.
      osob_fiz(p4,alltrim(p8i),alltrim(p8n),alltrim(p11),alltrim(p8p))
   else
      osob_nief(p4,alltrim(p8),alltrim(p11))
   endif
   adresz_nagl('RAD')
   adres_pol('PL',alltrim(p17),alltrim(p17a),alltrim(p18),alltrim(p19),alltrim(p20),alltrim(p21),alltrim(p22),p23,alltrim(p24))
   adresz_stop()
   podm1_stop()
   szczeg_vat(alltrim(str(p64,14,0)),;
                      alltrim(str(p64exp,14,0)),;
                      alltrim(str(p64expue,14,0)),;
                      alltrim(str(p67,14,0)),;
                      alltrim(str(p67art129,14,0)),;
                      alltrim(str(p61+p61a,14,0)),;
                      alltrim(str(p62+p62a,14,0)),;
                      alltrim(str(p69,14,0)),;
                      alltrim(str(p70,14,0)),;
                      alltrim(str(p71,14,0)),;
                      alltrim(str(p72,14,0)),;
                      alltrim(str(p65ue,14,0)),;
                      alltrim(str(p65,14,0)),;
                      alltrim(str(p65dekue,14,0)),;
                      alltrim(str(p65vdekue,14,0)),;
                      alltrim(str(p65dekit,14,0)),;
                      alltrim(str(p65vdekit,14,0)),;
                      alltrim(str(p65dekus,14,0)),;
                      alltrim(str(p65vdekus,14,0)),;
                      alltrim(str(p65dekusu,14,0)),;
                      alltrim(str(p65vdekusu,14,0)),;
                      alltrim(str(p65dekwe,14,0)),;
                      alltrim(str(p65vdekwe,14,0)),;
                      alltrim(str(pp12,14,0)),;
                      alltrim(str(znowytran,14,0)),;
                      alltrim(str(p75,14,0)),;
                      alltrim(str(p76,14,0)),;
                      alltrim(str(pp8,14,0)),;
                      alltrim(str(pp11,14,0)),;
                      alltrim(str(p45dek,14,0)),;
                      alltrim(str(p46dek,14,0)),;
                      alltrim(str(p49dek,14,0)),;
                      alltrim(str(p50dek,14,0)),;
                      alltrim(str(zkorekst,14,0)),;
                      alltrim(str(zkorekpoz,14,0)),;
                      alltrim(str(p79,14,0)),;
                      alltrim(str(p98a,14,0)),;
                      alltrim(str(pp13,14,0)),;
                      alltrim(str(p98b,14,0)),;
                      alltrim(str(p99a,14,0)),;
                      alltrim(str(p99,14,0)),;
                      alltrim(str(p99c,14,0)),;
                      alltrim(str(p99abc,14,0)),;
                      alltrim(str(p99ab,14,0)),;
                      alltrim(str(p99b,14,0)),;
                      alltrim(str(p99d,14,0)),;
                      iif(zf2='T','1','0'),;
                      iif(zf3='T','1','0'),;
                      iif(zf4='T','1','0'),;
                      iif(zf5='T','1','0'),;
                      '2','2')
   pouczenvat()
   oswiadczenie()
   edekl_kon()

   set printer to
   set console on
   set print off
   set devi to screen
   raportedekl(plik_dek)
   close_()
   restore screen from scr2
   _disp=.f.
close_()
