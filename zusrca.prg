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

param ubezp
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
@ 1,47 say [          ]
*############################### OTWARCIE BAZ ###############################
select 6
if dostep('FIRMA')
   go val(ident_fir)
else
   return
endif
zspolka=iif(spolka,'T','N')
select 4
if dostep('DANE_MC')
   set inde to DANE_MC
else
   close_()
   return
endif
select 3
do while.not.dostep('ETATY')
enddo
do setind with 'ETATY'
set orde to 2
select 2
if dostep('PRAC')
   do setind with 'PRAC'
   set orde to 2
else
   close_()
   return
endif
select 1
if dostep('SPOLKA')
   do setind with 'SPOLKA'
   seek [+]+ident_fir
else
   close_()
   return
endif
if del#[+].or.firma#ident_fir
   kom(5,[*u],[ Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ])
   close_()
   return
endif
if ubezp=2
   @ 3,42 clear to 22,79
   save screen to scr2
   *--------------------------------------
   param_zu()
   jeden=zus_zglo()
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
   PLIK_KDU=substr(param_rok,4,1)+;
            iif(val(miesiac)>9,chr(55+val(miesiac)),alltrim(miesiac))+;
            iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
            iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
            '8'+;
            'F'+;
            '0'+;
            '0.kdu'
   aaaa=alltrim(paraz_cel)+PLIK_KDU
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

   kedu_pocz()
   dp_pocz('RCA')
   ?'<ZUSRCA>'
   dorca(miesiac,param_rok,0)
   if zSPOLKA='T'
      dipl(F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  '))
   else
      subim=substr(A->NAZ_IMIE,at(' ',A->NAZ_IMIE)+1)
      dipl(A->NIP,substr(F->NR_REGON,3),A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,F->nazwa_skr,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
   endif
*   dipl() with F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  ')

   sele prac
   go top
   seek '+'+ident_fir+'+'
   do while .not.eof().and.del='+'.and.firma=ident_fir.and.status<='U'
      if .not.empty(DATA_PRZY)
         DOD=substr(dtos(DATA_PRZY),1,6)<=param_rok+strtran(miesiac,' ','0')
      else
         DOD=.f.
      endif
      if .not.empty(DATA_ZWOL)
         DDO=substr(dtos(DATA_ZWOL),1,6)>=param_rok+strtran(miesiac,' ','0')
         if substr(dtos(DATA_ZWOL),1,6)==param_rok+strtran(miesiac,' ','0')
            PROZWOL=dtoc(DATA_ZWOL)
         endif
      else
         PROZWOL=''
         DDO=.t.
      endif
      if DOD.and.DDO=.t.
         sele etaty
         seek '+'+ident_fir+miesiac+str(prac->rec_no,5)
         if found()
            ddorca(PRAC->NAZWISKO,;
                           PRAC->IMIE1,;
                           iif(.not.empty(PRAC->PESEL),'P',iif(.not.empty(PRAC->NIP),'N',PRAC->RODZ_DOK)),;
                           iif(.not.empty(PRAC->PESEL),PRAC->PESEL,iif(.not.empty(PRAC->NIP),PRAC->NIP,PRAC->DOWOD_OSOB)),;
                           ETATY->KOD_TYTU,;
                           ZUSWYMIAR(ETATY->WYMIARL,ETATY->WYMIARM),;
                           ETATY->PENSJA-ETATY->DOPL_BZUS,;
                           ETATY->PENSJA-ETATY->DOPL_BZUS,;
                           ETATY->BRUT_RAZEM-(ETATY->DOPL_BZUS+ETATY->WAR_PF3+ETATY->WAR_PSUM),;
                           ETATY->WAR_PUE,;
                           ETATY->WAR_PUR,;
                           ETATY->WAR_PUC,;
                           ETATY->WAR_PUZ,;
                           ETATY->WAR_FUE,;
                           ETATY->WAR_FUR,;
                           ETATY->WAR_FUW,;
                           ETATY->WAR_PF3,;
                           ETATY->WAR_PSUM+ETATY->WAR_PUZ+ETATY->WAR_FSUM-(ETATY->WAR_FFP+ETATY->WAR_FFG),;
                           ETATY->ILOSO_RODZ,;
                           ETATY->ZASIL_RODZ,;
                           ETATY->ILOSO_PIEL,;
                           ETATY->ZASIL_PIEL,;
                           ETATY->ZASIL_PIEL+ETATY->ZASIL_RODZ)
         endif
      endif
      sele prac
      skip
   enddo

   sele spolka
   go top
   seek '+'+ident_fir
   do while .not.eof().and.del='+'.and.firma=ident_fir
      zident=str(recno(),5)
      sele dane_mc
      seek '+'+zident+miesiac
      if found()
         subim=substr(A->NAZ_IMIE,at(' ',A->NAZ_IMIE)+1)
         ddorca(substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),;
                        substr(subim,1,at(' ',subim)),;
                        iif(.not.empty(A->PESEL),'P',iif(.not.empty(A->NIP),'N',A->RODZ_DOK)),;
                        iif(.not.empty(A->PESEL),A->PESEL,iif(.not.empty(A->NIP),A->NIP,A->DOWOD_OSOB)),;
                        A->KOD_TYTU,;
                        '      ',;
                        D->PODSTAWA,;
                        D->PODSTAWA,;
                        D->PODSTZDR,;
                        D->WAR_wUE,;
                        D->WAR_wUR,;
                        D->WAR_wUC,;
                        D->WAR_wUZ,;
                        0,;
                        0,;
                        D->war_wuw,;
                        0,;
                        D->WAR_wue+D->war_wur+D->war_wuc+D->WAR_wUZ+D->WAR_wuw,;
                        0,;
                        0,;
                        0,;
                        0,;
                        0)
      endif
      sele spolka
      skip
   enddo

   oplr()
   ?'</ZUSRCA>'
   dp_kon('RCA')
   kedu_kon()
   set printer to
   set console on
   set print off
   set devi to screen
   kedu_rapo(plik_kdu)
   close_()
   restore screen from scr2
   _disp=.f.
else
   @ 3,42 clear to 22,79
   save screen to scr2
   *--------------------------------------
   param_zu()
   jeden=zus_zglo()
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
   PLIK_KDU=substr(param_rok,4,1)+;
            iif(val(miesiac)>9,chr(55+val(miesiac)),alltrim(miesiac))+;
            iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
            iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
            '8'+;
            'P'+;
            '0'+;
            '0.kdu'
   aaaa=alltrim(paraz_cel)+PLIK_KDU
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

   kedu_pocz()
   dp_pocz('RCA')
   ?'<ZUSRCA>'
   dorca(miesiac,param_rok,0)
   if zSPOLKA='T'
      dipl(F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  '))
   else
      subim=substr(A->NAZ_IMIE,at(' ',A->NAZ_IMIE)+1)
      dipl(A->NIP,substr(F->NR_REGON,3),A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,F->nazwa_skr,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
   endif
*   dipl() with F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  ')

   sele prac
   go top
   seek '+'+ident_fir+'+'
   brakpra=.f.
   if found()
   do while .not.eof().and.del='+'.and.firma=ident_fir.and.status<='U'
      if .not.empty(DATA_PRZY)
         DOD=substr(dtos(DATA_PRZY),1,6)<=param_rok+strtran(miesiac,' ','0')
      else
         DOD=.f.
      endif
      if .not.empty(DATA_ZWOL)
         DDO=substr(dtos(DATA_ZWOL),1,6)>=param_rok+strtran(miesiac,' ','0')
         if substr(dtos(DATA_ZWOL),1,6)==param_rok+strtran(miesiac,' ','0')
            PROZWOL=dtoc(DATA_ZWOL)
         endif
      else
         PROZWOL=''
         DDO=.t.
      endif
      sele etaty
      seek '+'+ident_fir+miesiac+str(prac->rec_no,5)
      if DOD.and.DDO=.t.
            sele etaty
            seek '+'+ident_fir+miesiac+str(prac->rec_no,5)
            if found()
               ddorca(PRAC->NAZWISKO,;
                              PRAC->IMIE1,;
                              iif(.not.empty(PRAC->PESEL),'P',iif(.not.empty(PRAC->NIP),'N',PRAC->RODZ_DOK)),;
                              iif(.not.empty(PRAC->PESEL),PRAC->PESEL,iif(.not.empty(PRAC->NIP),PRAC->NIP,PRAC->DOWOD_OSOB)),;
                              ETATY->KOD_TYTU,;
                              ZUSWYMIAR(ETATY->WYMIARL,ETATY->WYMIARM),;
                              ETATY->PENSJA-ETATY->DOPL_BZUS,;
                              ETATY->PENSJA-ETATY->DOPL_BZUS,;
                              ETATY->BRUT_RAZEM-(ETATY->DOPL_BZUS+ETATY->WAR_PF3+ETATY->WAR_PSUM),;
                              ETATY->WAR_PUE,;
                              ETATY->WAR_PUR,;
                              ETATY->WAR_PUC,;
                              ETATY->WAR_PUZ,;
                              ETATY->WAR_FUE,;
                              ETATY->WAR_FUR,;
                              ETATY->WAR_FUW,;
                              ETATY->WAR_PF3,;
                              ETATY->WAR_PSUM+ETATY->WAR_PUZ+ETATY->WAR_FSUM-(ETATY->WAR_FFP+ETATY->WAR_FFG),;
                              ETATY->ILOSO_RODZ,;
                              ETATY->ZASIL_RODZ,;
                              ETATY->ILOSO_PIEL,;
                              ETATY->ZASIL_PIEL,;
                              ETATY->ZASIL_PIEL+ETATY->ZASIL_RODZ)
            else
               brakpra=.t.
               exit
            endif
      endif
      sele prac
      skip
   enddo
   else
      brakpra=.t.
   endif
   oplr()
   ?'</ZUSRCA>'
   dp_kon('RCA')
   kedu_kon()
   set printer to
   set console on
   set print off
   set devi to screen
   if brakpra=.t.
      do komun with 'Brak p&_l.ac. Niemo&_z.liwe jest utworzenie prawid&_l.owego pliku dla P&_l.atnika'
   else
      kedu_rapo(plik_kdu)
   endif
   close_()
   restore screen from scr2
   _disp=.f.
endif
close_()
