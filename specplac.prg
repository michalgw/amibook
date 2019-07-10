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

               private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
               private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15,koniep
               begin sequence
               @ 1,47 say space(10)
               *-----parametry wewnetrzne-----
               _papsz=1
               _lewa=1
               _prawa=126
               _strona=.f.
               _czy_mon=.t.
               _czy_close=.t.
               czesc=1
               *------------------------------
               _szerokosc=126
               _koniec="del#[+].or.firma#ident_fir"
*@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      paras_nag='Lista wyp&_l.at'
      if .not.file([param_sp.mem])
         save to param_sp all like paras_*
      else
         restore from param_sp addi
      endif
      zparas_nag=paras_nag+space(40-len(paras_nag))
      mcod=val(miesiac)
      mcdo=val(miesiac)
      @ 23,0  clear to 23,79
      @ 23,0 say [Od m-ca] get mcod
      @ 23,12 say [Do m-ca] get mcdo
      @ 23,24 say [Tre&_s.&_c. nag&_l.&_o.wka] get zparas_nag pict repl('X',40)
      read_()
      if lastkey()=27
         break
      endif
      paras_nag=alltrim(zparas_nag)
      save to param_sp all like paras_*
      if mcod>mcdo
         kom(3,[*u],[ Nieprawid&_l.owy zakres ])
         break
      endif
*@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
select 3
do while.not.dostep('NIEOBEC')
enddo
do setind with 'NIEOBEC'
seek [+]+ident_fir
sele 2
if dostep('PRAC')
   do SETIND with 'PRAC'
else
   break
endif
sele 1
if dostep('ETATY')
   do SETIND with 'ETATY'
else
   break
endif
sele prac
seek '+'+ident_fir
if .not.found()
   kom(3,[*w],[b r a k   d a n y c h])
   break
endif
mon_drk([ö]+procname())
*@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
mon_drk([])
mon_drk([])
if mcdo-mcod=0
   mon_drk(space(19)+[ÄÄÄ]+padc(' '+paras_nag+' ',80,'Ä')+padl([ okres: ]+str(mcod,2)+'.'+param_rok,24,'Ä'))
else
   mon_drk(space(19)+[ÄÄÄ]+padc(' '+paras_nag+' ',80,'Ä')+padl([ okres od ]+str(mcod,2)+[ do ]+str(mcdo,2)+[  ]+param_rok,24,'Ä'))
endif
store 0 to s1,s2,s3,s3a,s4,s5a,s5b,s5c,s5d,s5e,s5f,s5g,s5h,s5i,s6,s7,s8,s9,s10,s11,s12,s13,s131,s132,s133,s134,s14,s141,s141a,s15,s16,s17,s17a,s17b,s17c,s17d,s18,s19,s20,s21,s22,s23,s23a,s23b,s24,zs7,zs10,zb4,s20a,sz1,sz2,sz3
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
sele prac
do while .not.&_koniec
store 0 to zdochod,zstaw_podat,zbrut_zasad,zbrut_premi,zdopl_opod,zdopl_bzus,zstaw_pue,zstaw_pur,zstaw_puc,zwar_psum,zwar_pue,zwar_pur,zwar_puc,zzasil_rodz,ziloso_rodz,zzasil_piel,ziloso_piel,zstaw_fue,zwar_fue,zstaw_fur,;
           zwar_fur,zstaw_fuw,zwar_fuw,zwolu,zwolc,zwolz,zwolo,zwolb,zwolm,zwolw,zwoln,zwoli,zwar_pf3,zstaw_ffp,zwar_ffp,zbrut_razem,zkoszt,zstaw_puz,zodlicz,zpodatek,znetto,zwar_puz,zwar_puzo,zdopl_nieop,zodl_nieop,zdo_wyplaty,;
           zstaw_ffg,zwar_ffg,zwar_fsum,zs7,zs10,zb4,zprzel_nako,zzus_zascho,zzus_rkch,zzus_podat
*   REC=recno()
   REC=rec_no
   k1=padr(alltrim(nazwisko)+' '+alltrim(imie1)+' '+alltrim(imie2),40)
   k2=pesel
   k3=symbol_fir
   zkod_kasy='   '
   zkod_tytu='      '
   store .f. to DOD
   store .t. to DDO
   if .not.empty(PRAC->DATA_PRZY)
      DOD=substr(dtos(PRAC->DATA_PRZY),1,6)<=param_rok+strtran(str(mcdo,2),' ','0')
   endif
   if .not.empty(PRAC->DATA_ZWOL)
      DDO=substr(dtos(PRAC->DATA_ZWOL),1,6)>=param_rok+strtran(str(mcod,2),' ','0')
   endif
   if DOD.and.DDO
      for xxe=mcod to mcdo
          xxes=str(xxe,2)
          sele etaty
          seek '+'+ident_fir+str(REC,5)+xxes
          if found()
             store 0 to wolI,wolU,wolC,wolO,wolW,wolB,wolM,choC,wolZ,choZ,wolN
             _zident_=str(prac->rec_no,5)
             _bot_=[del#'+'.or.firma#ident_fir.or.ident#_zident_.or.mc#etaty->mc]
             _bot_1=[del#'+'.or.firma#ident_fir.or.ident#_zident_.or.mc=etaty->mc]
             sele nieobec
             seek [+]+ident_fir+_zident_+etaty->mc
             if found()
                do while .not.&_bot_
                   do case
                   case substr(PRZYCZYNA,1,1)='I'
                        wolI=wolI+((dddo-ddod)+1)
                   case substr(PRZYCZYNA,1,1)='U'
                        wolU=wolU+((dddo-ddod)+1)
                   case substr(PRZYCZYNA,1,1)='C'
                        wolC=wolC+((dddo-ddod)+1)
                   case substr(PRZYCZYNA,1,1)='Z'
                        wolZ=wolZ+((dddo-ddod)+1)
                   case substr(PRZYCZYNA,1,1)='O'
                        wolO=wolO+((dddo-ddod)+1)
                   case substr(PRZYCZYNA,1,1)='W'
                        wolW=wolW+((dddo-ddod)+1)
                   case substr(PRZYCZYNA,1,1)='B'
                        wolB=wolB+((dddo-ddod)+1)
                   case substr(PRZYCZYNA,1,1)='M'
                        wolM=wolM+((dddo-ddod)+1)
                   case substr(PRZYCZYNA,1,1)='N'
                        wolN=wolN+((dddo-ddod)+1)
                   endcase
                   skip
                enddo
             endif
             sele etaty
             zbrut_zasad=zbrut_zasad+brut_zasad
             zbrut_premi=zbrut_premi+brut_premi
             zdopl_opod=zdopl_opod+dopl_opod
             zdopl_bzus=zdopl_bzus+dopl_bzus
             zwolu=zwolu+wolU
             zwolc=zwolc+wolC
             zwolz=zwolz+wolZ
             zwolo=zwolo+wolO
             zwolb=zwolb+wolB
             zwolm=zwolm+wolM
             zwoln=zwoln+wolN
             zwolw=zwolw+wolW
             zwoli=zwoli+wolI
             zs7=zs7+pensja+war_pf3
             zwar_pf3=zwar_pf3+war_pf3
             zs10=zs10+dop_zascho+dop_zasc20+dop_zas100
             zbrut_razem=zbrut_razem+brut_razem
             zkoszt=zkoszt+koszt
             zdochod=zdochod+dochod
             zwar_pue=zwar_pue+war_pue
             zwar_pur=zwar_pur+war_pur
             zwar_puc=zwar_puc+war_puc
             zwar_psum=zwar_psum+war_psum
             B4=max(0,_round(DOCHODPOD*(STAW_PODAT/100),2))
             zb4=zb4+b4
             zwar_puz=zwar_puz+war_puz
             zwar_puzo=zwar_puzo+war_puzo
             zodlicz=zodlicz+odlicz
             zpodatek=zpodatek+podatek
             znetto=znetto+netto
             zzasil_rodz=zzasil_rodz+zasil_rodz
             ziloso_rodz=ziloso_rodz+iloso_rodz
             zzasil_piel=zzasil_piel+zasil_piel
             ziloso_piel=ziloso_piel+iloso_piel
             zdopl_nieop=zdopl_nieop+dopl_nieop
             zodl_nieop=zodl_nieop+odl_nieop
             zdo_wyplaty=zdo_wyplaty+do_wyplaty
             zprzel_nako=zprzel_nako+przel_nako
             zwar_fue=zwar_fue+war_fue
             zwar_fur=zwar_fur+war_fur
             zwar_fuw=zwar_fuw+war_fuw
             zwar_ffp=zwar_ffp+war_ffp
             zwar_ffg=zwar_ffg+war_ffg
             zwar_fsum=zwar_fsum+war_fsum
             zstaw_podat=staw_podat
             zstaw_pue=staw_pue
             zstaw_pur=staw_pur
             zstaw_puc=staw_puc
             zstaw_puz=staw_puz
             zstaw_fue=staw_fue
             zstaw_fur=staw_fur
             zstaw_fuw=staw_fuw
             zstaw_ffp=staw_ffp
             zstaw_ffg=staw_ffg
             zkod_kasy=kod_kasy
             zkod_tytu=kod_tytu
             zzus_zascho=zus_zascho
             zzus_rkch=zus_rkch
             zzus_podat=zus_podat
          endif
      next
   mm=mcdo-mcod
   mon_drk(k1+[   PESEL:]+k2+space(50)+[FIRMA:]+k3)
mon_drk([Zasadnicza........:]+kwota(zBRUT_ZASAD,11,2)    +[  Ubezp.emeryt.]+iif(mm=0,str(zstaw_pue,4,2),space(4))+[%=]+str(zwar_pue,11,2)+[  ****PLACA NETTO***:]+kwota(zNETTO,11,2)     ;
       +[  -SKLAD.FINANS.PRZEZ PRACODAWCE])
mon_drk([Premia............:]+kwota(zBRUT_PREMI,11,2)    +[  Ubezp.rentowe]+iif(mm=0,str(zstaw_pur,4,2),space(4))+[%=]+str(zwar_pur,11,2)+[  Zasilek rodzinny..:]+kwota(zZASIL_RODZ,11,2);
       +[  Emerytalne...]+iif(mm=0,str(zSTAW_fUE,4,2),space(4))+[%=]+str(zwar_fue,11,2))
mon_drk([Dodatki,itp.......:]+kwota(zDOPL_OPOD ,11,2)    +[  Ubezp.chorob.]+iif(mm=0,str(zstaw_puc,4,2),space(4))+[%=]+str(zwar_puc,11,2)+[  Dla osob..........:]+kwota(zILOSO_RODZ,11)  ;
       +[  Rentowe......]+iif(mm=0,str(zSTAW_fUr,4,2),space(4))+[%=]+str(zwar_fur,11,2))
mon_drk([Dodatki bez ZUS...:]+kwota(zDOPL_BZUS ,11,2)    +[  ***UBEZPIECZENIA**:]+kwota(zwar_psum,11,2)                                  +[  Zasilek pielegnac.:]+kwota(zZASIL_PIEL,11,2);
       +[  Wypadkowe....]+iif(mm=0,str(zSTAW_fUw,4,2),space(4))+[%=]+str(zwar_fuw,11,2))
mon_drk([NIEOBEC:]+;
   padr(iif(zwolU#0,'U='+alltrim(str(zwolU,3))+' ','')+;
        iif(zwolC#0,'C='+alltrim(str(zwolC,3))+' ','')+;
        iif(zwolZ#0,'Z='+alltrim(str(zwolZ,3))+' ','')+;
        iif(zwolO#0,'O='+alltrim(str(zwolO,3))+' ','')+;
        iif(zwolB#0,'B='+alltrim(str(zwolB,3))+' ','')+;
        iif(zwolM#0,'M='+alltrim(str(zwolM,3))+' ','')+;
        iif(zwolN#0,'N='+alltrim(str(zwolN,3))+' ','')+;
        iif(zwolW#0,'W='+alltrim(str(zwolW,3))+' ','')+;
        iif(zwolI#0,'I='+alltrim(str(zwolI,3))+' ',''),22)+;
                                                          [  **III filar(PPE)**:]+kwota(zWAR_PF3,11,2)                                   +[  Dla osob..........:]+kwota(zILOSO_PIEL,11)     ;
       +[  Fundusz Pracy]+iif(mm=0,str(zSTAW_ffp,4,2),space(4))+[%=]+str(zwar_ffp,11,2))
mon_drk([Za czas przepracow:]+kwota(zs7,11,2)            +[  Oblicz.podat...]+iif(mm=0,str(zSTAW_PODAT,2),space(2))+[%=]+kwota(zb4,11,2) +[  Dop&_l.at.nieopodat..:]+kwota(zDOPL_NIEOP,11,2);
       +[  FG&__S.P         ]+  iif(mm=0,str(zSTAW_ffg,4,2),space(4))+[%=]+str(zwar_ffg,11,2))
mon_drk([Za chorobowe itp..:]+kwota(zs10,11,2)           +[  Odliczenie od pod.:]+kwota(zODLICZ,11,2)                                    +[  Potr&_a.c.nieopodat..:]+kwota(zODL_NIEOP ,11,2);
       +[  ***RAZEM SK&__L.ADKI**:]+kwota(zwar_fsum,11,2))
mon_drk([***P&__L.ACA BRUTTO***:]+kwota(zBRUT_RAZEM,11,2)+[  Kasa chorych.]+iif(mm=0,str(zSTAW_PUZ,4,2),space(4))+[%=]+str(zwar_puz,11,2)+[  ****DO WYP&__L.ATY****:]+kwota(zDO_WYPLATY,11,2);
       +[  Z ZUS:zasilek.....:]+kwota(zzus_zascho,11,2))
mon_drk([Koszt uzyskania...:]+kwota(zKOSZT,11,2)         +[  z tego odliczono..:]+kwota(zWAR_PUZO,11,2)                                  +[  z tego: przelewem.:]+kwota(zPRZEL_NAKO,11,2);
       +[        zdro:]+kwota(zzus_rkch,6,2)+[ podat:]+kwota(zzus_podat,6,2))
mon_drk([******DOCH&__O.D******:]+kwota(zDOCHOD,11,2)    +[  ******PODATEK*****:]+kwota(zPODATEK ,11,2)                                  +[          got&_o.wk&_a....:]+kwota(zDO_WYPLATY-zPRZEL_NAKO,11,2);
       +[  NFZ:]+zkod_kasy+[   Kod tyt.ub.:]+zkod_tytu)
mon_drk([])
mon_drk([])
      s1=s1+zbrut_zasad
      s2=s2+zbrut_premi
      s3=s3+zdopl_opod
      s3a=s3a+zdopl_bzus
      s5a=s5a+zwolU
      s5b=s5b+zwolC
      s5c=s5c+zwolZ
      s5d=s5d+zwolO
      s5e=s5e+zwolB
      s5f=s5f+zwolM
      s5g=s5g+zwolW
      s5h=s5h+zwolI
      s5i=s5i+zwolN
      s7=s7+zs7
      s9=s9+zwar_pf3
      s10=s10+zs10
      s11=s11+zbrut_razem
      s12=s12+zkoszt
      s13=s13+zdochod
      s131=s131+zwar_pue
      s132=s132+zwar_pur
      s133=s133+zwar_puc
      s134=s134+zwar_psum
      s14=s14+zb4
      s141=s141+zwar_puz
      s141a=s141a+zwar_puzo
      s15=s15+zodlicz
      s16=s16+zpodatek
      s17=s17+znetto
      s17a=s17a+zzasil_rodz
      s17b=s17b+ziloso_rodz
      s17c=s17c+zzasil_piel
      s17d=s17d+ziloso_piel
      s18=s18+zdopl_nieop
      s19=s19+zodl_nieop
      s20=s20+zdo_wyplaty
      s20a=s20a+zprzel_nako
      s21=s21+zwar_fue
      s22=s22+zwar_fur
      s23=s23+zwar_fuw
      s23a=s23a+zwar_ffp
      s23b=s23b+zwar_ffg
      s24=s24+zwar_fsum
      sz1=sz1+zzus_zascho
      sz2=sz2+zzus_rkch
      sz3=sz3+zzus_podat
if mcdo-mcod=0
   mon_drk(space(19)+[ÄÄÄ]+padc(' '+paras_nag+' ',80,'Ä')+padl([ okres: ]+str(mcod,2)+'.'+param_rok,24,'Ä'))
else
   mon_drk(space(19)+[ÄÄÄ]+padc(' '+paras_nag+' ',80,'Ä')+padl([ okres od ]+str(mcod,2)+[ do ]+str(mcdo,2)+[  ]+param_rok,24,'Ä'))
endif
   endif
   sele prac
   skip
   *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   _numer=0
   _grupa=.f.
enddo
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
*     s9=_round(s10/s8,2)
mon_drk('******************************')
mon_drk('********* R A Z E M **********')
mon_drk('******************************')
mon_drk([Zasadnicza........:]+kwota(s1,11,2);
  +[  Ubezp.emeryt......:]+str(s131,11,2);
  +[  ****PLACA NETTO***:]+kwota(s17,11,2);
  +[  -SKLAD.FINANS.PRZEZ PRACODAWCE])
mon_drk([Premia............:]+kwota(s2,11,2);
  +[  Ubezp.rentowe.....:]+str(s132,11,2);
  +[  Zasilek rodzinny..:]+kwota(s17a,11,2);
  +[  Emerytalne........:]+kwota(s21,11,2))
mon_drk([Dodatki,itp.......:]+kwota(s3,11,2);
  +[  Ubezp.chorob......:]+str(s133,11,2);
  +[  Dla osob..........:]+kwota(s17b,11);
  +[  Rentowe...........:]+kwota(s22,11,2))
mon_drk([Dodatki bez ZUS...:]+kwota(s3a,11,2);
  +[  ***UBEZPIECZENIA**:]+str(s134,11,2);
  +[  Zasilek pielegnac.:]+kwota(s17c,11,2);
  +[  Wypadkowe.........:]+kwota(s23,11,2))
mon_drk([NIEOBEC:]+;
         padr(iif(s5a#0,'U='+alltrim(str(s5a,3))+' ','')+;
              iif(s5b#0,'C='+alltrim(str(s5b,3))+' ','')+;
              iif(s5c#0,'Z='+alltrim(str(s5c,3))+' ','')+;
              iif(s5d#0,'O='+alltrim(str(s5d,3))+' ','')+;
              iif(s5e#0,'B='+alltrim(str(s5e,3))+' ','')+;
              iif(s5f#0,'M='+alltrim(str(s5f,3))+' ','')+;
              iif(s5i#0,'N='+alltrim(str(s5i,3))+' ','')+;
              iif(s5g#0,'W='+alltrim(str(s5g,3))+' ','')+;
              iif(s5h#0,'I='+alltrim(str(s5h,3))+' ',''),22);
  +[  **III filar(PPE)**:]+kwota(s9,11,2);
  +[  Dla osob..........:]+kwota(s17d,11);
  +[  Fundusz Pracy.....:]+kwota(s23a,11,2))
mon_drk([Za czas przepracow:]+kwota(s7,11,2);
  +[  Obliczony podatek.:]+kwota(s14,11,2);
  +[  Dop&_l.at.nieopodat..:]+kwota(s18,11,2);
  +[  FG&__S.P..............:]+kwota(s23b,11,2))
mon_drk([Za chorobowe itp..:]+kwota(s10,11,2);
  +[  Odliczenie od pod.:]+kwota(s15,11,2);
  +[  Potr&_a.c.nieopodat..:]+kwota(s19,11,2);
  +[  ***RAZEM SK&__L.ADKI**:]+kwota(s24,11,2))
mon_drk([***P&__L.ACA BRUTTO***:]+kwota(s11,11,2);
  +[  Kasa chorych......:]+kwota(s141,11,2);
  +[  ****DO WYP&__L.ATY****:]+kwota(s20,11,2);
  +[  Z ZUS:zasilek.....:]+kwota(sz1,11,2))
mon_drk([Koszt uzyskania...:]+kwota(s12,11,2);
  +[  Odliczenie od pod.:]+kwota(s141a,11,2);
  +[  z tego: przelewem.:]+kwota(s20a,11,2);
  +[        zdrowotne...:]+kwota(sz2,11,2))
mon_drk([******DOCH&__O.D******:]+kwota(s13,11,2);
  +[  ******PODATEK*****:]+kwota(s16,11,2);
  +[          got&_o.wk&_a....:]+kwota(s20-s20a,11,2);
  +[        podatek.....:]+kwota(sz3,11,2))
mon_drk(space(44)+[  SUMA SKLADEK FINANSOWANYCH PRZEZ PRACODAWCE: (51=]+kwota(s21+s22+s23,11,2)+[)   (53=]+kwota(s23a+s23b,11,2)+[)])
mon_drk([                U&_z.ytkownik programu komputerowego])
mon_drk([        ]+dos_c(code()))
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               mon_drk([þ])
               end
               if _czy_close
               close_()
               endif
