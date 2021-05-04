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
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*set cent off
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say 'ÚÄÄÄDataÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄAdresatÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄKwotaÄÄÂIdentyfikat.ÂTytPlaÄÂOkr¿'
@  4, 0 say '³          ³                                ³         ³            ³       ³   ³'
@  5, 0 say '³          ³                                ³         ³            ³       ³   ³'
@  6, 0 say '³          ³                                ³         ³            ³       ³   ³'
@  7, 0 say '³          ³                                ³         ³            ³       ³   ³'
@  8, 0 say '³          ³                                ³         ³            ³       ³   ³'
@  9, 0 say '³          ³                                ³         ³            ³       ³   ³'
@ 10, 0 say '³          ³                                ³         ³            ³       ³   ³'
@ 11, 0 say '³          ³                                ³         ³            ³       ³   ³'
@ 12, 0 say 'ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄ´'
@ 13, 0 say '³              NA DOBRO RACHUNKU                  W CI&__E.&__Z.AR RACHUNKU            ³'
@ 14, 0 say '³ Nazwa..:                                                                     ³'
@ 15, 0 say '³ Ulica..:                                                                     ³'
@ 16, 0 say '³ Miejsc.:                                                                     ³'
@ 17, 0 say '³ Bank...:                                                                     ³'
@ 18, 0 say '³ Konto..:                                                                     ³'
@ 19, 0 say 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´'
@ 20, 0 say '³ Data:          ³ NIP,itp:               TypID:  Okres-Rok:   Typ:  NrOkr:    ³'
@ 21, 0 say '³Kwota:          ³ Formul/Platnos:        IdentZobowiaz:                       ³'
@ 22, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
*############################### OTWARCIE BAZ ###############################
select 2
do while.not.dostep('URZEDY')
enddo
do setind with 'URZEDY'
select 1
do while.not.dostep('PRZELPOD')
enddo
do setind with 'PRZELPOD'
seek [+]+ident_fir
*################################# OPERACJE #################################
*----- parametry ------
_row_g=4
_col_l=1
_row_d=11
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,22,48,77,109,7,46,28,76,108,80,112,66,98,78,110,87,119]
_top=[firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[ş]
_proc=[say411p()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[say411sp]
_disp=.t.
_cls=''
_top_bot=_top+[.or.]+_bot
*----------------------
kl=0
do while kl#27
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   set colo to
   _row=wybor(_row)
   ColStd()
   kl=lastkey()
   do case
   *########################### INSERT/MODYFIKACJA #############################
   case kl=22.or.kl=48.or._row=-1.or.kl=77.or.kl=109
        @ 1,47 say [          ]
        ins=(kl#109.and.kl#77).OR.&_top_bot
        if ins
           ColStb()
           center(23,[ş                     ş])
           ColSta()
           center(23,[W P I S Y W A N I E])
           ColStd()
*          restscreen(_row_g,_col_l,_row_d+1,_col_p,_cls)
           wiersz=_row_d
        else
           ColStb()
           center(23,[ş                       ş])
           ColSta()
           center(23,[M O D Y F I K A C J A])
           ColStd()
           wiersz=_row
        endif
        begin sequence
              *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ ZMIENNE ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ
              zURZAD     =URZAD
              zNAZWA_WIE =NAZWA_WIE
              zNAZWA_PLA =NAZWA_PLA
              zULICA_WIE =ULICA_WIE
              zULICA_PLA =ULICA_PLA
              zMIEJSC_WIE=MIEJSC_WIE
              zMIEJSC_PLA=MIEJSC_PLA
              zBANK_WIE  =BANK_WIE
              zBANK_PLA  =BANK_PLA
              zKONTO_WIE =KONTO_WIE
              zKONTO_PLA =KONTO_PLA
              zKWOTA     =KWOTA
              zNIP       =substr(TRESC,1,14)
              zTYP       =substr(TRESC,16,1)
              zOKRROK    =substr(TRESC,20,2)
              zOKRTYP    =substr(TRESC,22,1)
              zOKRNR     =substr(TRESC,23,4)
              zFORMUL    =substr(TRESC,27,7)
              zIDZOB     =substr(TRESC,34,21)
              zDATA      =date()
              *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ GET ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ
              @ 14,10 get zNAZWA_WIE  pict '@KS33 '+repl('!',56) when v3_14pod()
              @ 15,10 get zULICA_WIE  pict '@K '+repl('!',28)
              @ 16,10 get zMIEJSC_WIE pict '@K '+repl('!',28)
              @ 17,10 get zBANK_WIE   pict '@K '+repl('!',28)
              @ 18,10 get zKONTO_WIE  pict repl('!',32) when v3_15pod()
              @ 14,45 get zNAZWA_PLA  pict '@KS33 '+repl('!',56)
              @ 15,45 get zULICA_PLA  pict '@K '+repl('!',28)
              @ 16,45 get zMIEJSC_PLA pict '@K '+repl('!',28)
              @ 17,45 get zBANK_PLA   pict '@K '+repl('!',28)
              @ 18,45 get zKONTO_PLA  pict repl('!',32)
              @ 20, 7 get zDATA       pict '@D'
              @ 21, 7 get zKWOTA      pict '@K  999999.99'
              @ 20,27 get zNIP        pict repl('!',14)
              @ 20,48 get zTYP        pict '!'
              @ 20,60 get zOKRROK     pict '99'
              @ 20,67 get zOKRTYP     pict '!'
              @ 20,75 get zOKRNR      pict '9999'
              @ 21,34 get zFORMUL     pict repl('!',7)
              @ 21,56 get zIDZOB      pict repl('!',20)
              read_()
              if lastkey()=27
                 break
              endif
              *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ REPL ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ
              if ins
                 app()
              endif
              do BLOKADAR
              repl_([FIRMA],IDENT_FIR)
              if substr(zURZAD,1,20)<>SUBSTR(zMIEJSC_WIE,8,20).or.substr(zURZAD,24,25)<>substr(zNAZWA_WIE,16,25)
                 zURZAD=''
              endif
              repl_([URZAD]     ,zURZAD     )
              repl_([NAZWA_WIE] ,zNAZWA_WIE )
              repl_([NAZWA_PLA] ,zNAZWA_PLA )
              repl_([ULICA_WIE] ,zULICA_WIE )
              repl_([ULICA_PLA] ,zULICA_PLA )
              repl_([MIEJSC_WIE],zMIEJSC_WIE)
              repl_([MIEJSC_PLA],zMIEJSC_PLA)
              repl_([BANK_WIE]  ,zBANK_WIE  )
              repl_([BANK_PLA]  ,zBANK_PLA  )
              repl_([KONTO_WIE] ,zKONTO_WIE )
              repl_([KONTO_PLA] ,zKONTO_PLA )
              repl_([KWOTA]     ,zKWOTA     )
              repl_([TRESC]     ,zNIP+' '+zTYP+'   '+zOKRROK+zOKRTYP+zOKRNR+zFORMUL+zIDZOB)
              repl_([DATA]      ,zDATA      )
              commit_()
              unlock
              *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ
              _row=int((_row_g+_row_d)/2)
              if .not.ins
                 break
              endif
              scroll(_row_g,_col_l,_row_d,_col_p,1)
              @ _row_d,_col_l say '        ³                                 ³           ³                       '
        end
        _disp=ins.or.lastkey()#27
        kl=iif(lastkey()=27.and._row=-1,27,kl)
        @ 23,0
   *################################ KASOWANIE #################################
   case kl=7.or.kl=46
        @ 1,47 say [          ]
        ColStb()
        center(23,[ş                   ş])
        ColSta()
        center(23,[K A S O W A N I E])
        ColStd()
        _disp=tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
        if _disp
           do BLOKADAR
           del()
           unlock
           skip
           commit_()
           if &_bot
              skip -1
           endif
        endif
        @ 23,0
   *################################### POMOC ##################################
   case kl=28
        save screen to scr_
        @ 1,47 say [          ]
        declare p[20]
        *---------------------------------------
        p[ 1]='                                                         '
        p[ 2]='   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja   '
        p[ 3]='   [Home/End]..............pierwsza/ostatnia pozycja     '
        p[ 4]='   [Ins]...................wpisywanie                    '
        p[ 5]='   [M].....................modyfikacja pozycji           '
        p[ 6]='   [Del]...................kasowanie pozycji             '
        p[ 7]='   [L,N]...................zadrukowanie przelewu         '
        p[ 9]='   [B,W]...................zadrukowanie wplaty gotowkowej'
        p[12]='   [Esc]...................wyj&_s.cie                       '
        p[13]='                                                         '
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
        set color to
        pause(0)
        if lastkey()#27.and.lastkey()#28
           keyboard chr(lastkey())
        endif
        restore screen from scr_
        _disp=.f.
   *############################## DRUK NOWEGO PRZELEWU ########################
   case kl=78.or.kl=110.or.kl=76 .or. kl=108
        save screen to scr_
        zNAZWA_WIE =NAZWA_WIE
        zNAZWA_PLA =NAZWA_PLA
        zULICA_WIE =ULICA_WIE
        zULICA_PLA =ULICA_PLA
        zMIEJSC_WIE=MIEJSC_WIE
        zMIEJSC_PLA=MIEJSC_PLA
        zBANK_WIE  =BANK_WIE
        zBANK_PLA  =BANK_PLA
        zKONTO_WIE =KONTO_WIE
        zKONTO_PLA =KONTO_PLA
        zKWOTA     =KWOTA
        zTRESC     =TRESC
        zDATA      =DATA
        afill(nazform,'')
        afill(strform,0)
        zPodatki=.t.
        nazform[1]='PRZELN'
        strform[1]=1
        form(nazform,strform,1)
        sele 1
        do BLOKADAR
        repl DOKUMENT with 'PRZELEW'
        COMMIT
        unlock
        restore screen from scr_
        zPodatki=.f.
   *############################## DRUK NOWEGO DOWODU WPLATY ###################
   case kl=87.or.kl=119.or.kl=66.or.kl=98
        save screen to scr_
        zNAZWA_WIE =NAZWA_WIE
        zNAZWA_PLA =NAZWA_PLA
        zULICA_WIE =ULICA_WIE
        zULICA_PLA =ULICA_PLA
        zMIEJSC_WIE=MIEJSC_WIE
        zMIEJSC_PLA=MIEJSC_PLA
        zBANK_WIE  =BANK_WIE
        zBANK_PLA  =BANK_PLA
        zKONTO_WIE =KONTO_WIE
        zKONTO_PLA =KONTO_PLA
        zKWOTA     =KWOTA
        zTRESC     =TRESC
        zDATA      =DATA
        afill(nazform,'')
        afill(strform,0)
        zPodatki=.t.
        nazform[1]='WPLATN'
        strform[1]=1
        form(nazform,strform,1)
        sele 1
        do BLOKADAR
        repl DOKUMENT with 'WPLATA'
        COMMIT
        unlock
        restore screen from scr_
        zPodatki=.f.
   ******************** ENDCASE
   endcase
enddo
close_()

*################################## FUNKCJE #################################
function say411p
return dtoc(DATA)+[³]+substr(NAZWA_WIE,1,32)+[³]+str(kwota,9,2)+[³]+substr(TRESC,1,11)+substr(TRESC,16,1)+[³]+substr(TRESC,27,7)+[³]+substr(TRESC,20,3)
*############################################################################
procedure say411sp
clear type
if empty(DOKUMENT)
   ColStd()
   @ 12, 0 say 'ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄ´'
else
   set color to /w
   do case
   case DOKUMENT='BANKOWY'
        DD='BANKOWY DOW&__O.D WP&__L.ATY'
   other
        DD=DOKUMENT
   endcase
   DDD=repl('*** drukowano '+alltrim(DD)+' ',5)
   @ 12, 0 say DDD
endif
set color to +w
@ 14,10 say substr(NAZWA_WIE,1,33)
@ 15,10 say ULICA_WIE
@ 16,10 say MIEJSC_WIE
@ 17,10 say BANK_WIE
@ 18,10 say KONTO_WIE
@ 14,45 say substr(NAZWA_PLA,1,33)
@ 15,45 say ULICA_PLA
@ 16,45 say MIEJSC_PLA
@ 17,45 say BANK_PLA
@ 18,45 say KONTO_PLA
@ 20, 7 say DATA
@ 21, 7 say KWOTA pict '999 999.99'
@ 20,27 say substr(TRESC,1,14)
@ 20,48 say substr(TRESC,16,1)
@ 20,60 say substr(TRESC,20,2)
@ 20,67 say substr(TRESC,22,1)
@ 20,75 say substr(TRESC,23,4)
@ 21,34 say substr(TRESC,27,7)
@ 21,56 say substr(TRESC,34,20)
set color to
return
***************************************************
function v3_14pod
if lastkey()=5
   return .t.
endif
save screen to scr2
select urzedy
seek [+]+substr(zurzad,1,20)+substr(zurzad,24,25)
if del#[+].or.miejsc_us#substr(zurzad,1,20).or.urzad#substr(zurzad,24,25)
   skip -1
endif
urzedy_()
restore screen from scr2
if lastkey()=13 .OR. LastKey() == 1006
   zurzad=miejsc_us+' - '+urzad
   zNAZWA_WIE='URZ&__A.D SKARBOWY '+alltrim(URZAD)
   znazwa_wie=znazwa_wie+space(56-len(znazwa_wie))
   zulica_wie=alltrim(ulica)+' '+alltrim(nr_domu)
   zulica_wie=zulica_wie+space(28-len(zulica_wie))
   zmiejsc_wie=kod_poczt+' '+alltrim(miejsc_us)
   zmiejsc_wie=zmiejsc_wie+space(28-len(zmiejsc_wie))
   zbank_wie=alltrim(bank)
   zbank_wie=zbank_wie+space(28-len(zbank_wie))
*   zkonto_wie=space(35)
   set color to i
   @ 14,10 say substr(zNAZWA_WIE,1,33)
   @ 15,10 say zULICA_WIE
   @ 16,10 say zMIEJSC_WIE
   @ 17,10 say zBANK_WIE
   set color to
   pause(.5)
endif
select przelpod
return .t.
***************************************************
function v3_15pod
if lastkey()=5
   return .t.
endif
save screen to scr2
select urzedy
seek [+]+substr(zurzad,1,20)+substr(zurzad,24,25)
if del#[+].or.miejsc_us#substr(zurzad,1,20).or.urzad#substr(zurzad,24,25)
   sele Przelpod
   restore screen from scr2
   return .t.
else
   if .not.ins
      do case
      case alltrim(zFORMUL)='PIT'
           ktorekon=1
      case alltrim(zFORMUL)='VAT'
           ktorekon=2
      other
           ktorekon=3
      endcase
   else
      ktorekon=1
   endif
   ColPro()
   @ 17,25 clear to 21,53
   @ 17,25 to 21,53
   @ 18,26 prompt ' konto podatku dochodowego '
   @ 19,26 prompt ' konto podatku VAT         '
   @ 20,26 prompt ' inne konto                '
   ktorekon=menu(ktorekon)
   ColStd()
   if lastkey()=27
      sele Przelpod
      restore screen from scr2
      return .t.
   endif
*   zkonto_wie=space(35)
   do case
   case ktorekon=1
        zkonto_wie=kontodoch
   case ktorekon=2
        zkonto_wie=kontovat
   endcase
   restore screen from scr2
   if lastkey()=13
      set color to i
      @ 18,10 say zKONTO_WIE
      set color to
      pause(.5)
   endif
endif
select przelpod
return .t.
*############################################################################
