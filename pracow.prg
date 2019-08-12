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

#include "box.ch"
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,menuDrkDek,_top_bot
   private _prac_aktywny := 'T'
   private cEkranTmp
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say '                 I N F O R M A C J E   O   P R A C O W N I K A C H              '
@  4, 0 say 'ÚÄÄÄÄÄÄÄÄÄÄÄNazwiskoÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄImi© 1ÄÄÄÄÂÄÄÄÄImi© 2ÄÄÄÄÂStatusÄÂÄPˆecÄÄÂKr¿'
@  5, 0 say '³                             ³              ³              ³       ³       ³  ³'
@  6, 0 say '³                             ³              ³              ³       ³       ³  ³'
@  7, 0 say '³                             ³              ³              ³       ³       ³  ³'
@  8, 0 say '³                             ³              ³              ³       ³       ³  ³'
@  9, 0 say '³                             ³              ³              ³       ³       ³  ³'
@ 10, 0 say '³                             ³              ³              ³       ³       ³  ³'
@ 11, 0 say 'ÃÄ(       )ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄ´'
@ 12, 0 say '³ Nr PESEL..             NIP..                 Dokument.          nr:          ³'
@ 13, 0 say '³ Urodzony/a dnia..           w                Nazwisko rodowe.                ³'
@ 14, 0 say '³ Imiona: ojca.             matki.             Obywatelstwo....                ³'
@ 15, 0 say '³ Miejsce zamieszkania.                        Kod..        Poczta..           ³'
@ 16, 0 say '³ Ulica,dom,lokal......                              /        Tel...           ³'
@ 17, 0 say '³ Gmina.                   Powiat.                   Wojew.                    ³'
@ 18, 0 say '³ Urz&_a.d Skarbowy.......                                                        ³'
@ 19, 0 say '³ Miejsce zatrudnienia.                                                        ³'
@ 20, 0 say '³ Bank:                Konto:                Kwota przelewu:                   ³'
@ 21, 0 say '³ Nr id. podat.                  Rodzaj nr id.                                 ³'
@ 22, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
*############################### OTWARCIE BAZ ###############################
select 7
if dostep('ZALICZKI')
   do setind with 'ZALICZKI'
else
   close_()
   return
endif
select 6
if dostep('WYPLATY')
   do setind with 'WYPLATY'
else
   close_()
   return
endif
select 5
if dostep('NIEOBEC')
   do setind with 'NIEOBEC'
else
   close_()
   return
endif
select 4
if dostep('ETATY')
   do setind with 'ETATY'
else
   close_()
   return
endif
select 3
if dostep('UMOWY')
   do setind with 'UMOWY'
else
   close_()
   return
endif
select 2
if dostep('URZEDY')
   do setind with 'URZEDY'
else
   close_()
   return
endif
select 1
if dostep('PRAC')
   do setind with 'PRAC'
   SET FILTER TO prac->aktywny == _prac_aktywny
   GO TOP
   seek [+]+ident_fir
else
   close_()
   return
endif
*################################# OPERACJE #################################
*----- parametry ------
_row_g=5
_col_l=1
_row_d=10
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,22,48,77,109,7,46,13,28,65,97,-4]
_top=[firma#ident_fir]
_bot=[del#'+'.OR.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[say31()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[say31s]
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
        KTOROPER()
        if ins
           restscreen(_row_g,_col_l,_row_d+1,_col_p,_cls)
           wiersz=_row_d
        else
           wiersz=_row
        endif
        begin sequence
              *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
              if ins
                 zNREWID=space(11)
                 zNAZWISKO=space(30)
                 zIMIE1=space(15)
                 zIMIE2=space(15)
                 zIMIE_O=space(15)
                 zIMIE_M=space(15)
                 zPLEC=' '
                 zPESEL=space(11)
                 zNIP=space(13)
                 zMIEJSC_UR=space(20)
                 zDATA_UR=ctod([    .  .  ])
                 zNAZW_RODU=space(30)
                 zOBYWATEL=padr('POLSKIE',22)
                 zMIEJSC_ZAM=space(20)
                 zGMINA=space(20)
                 zULICA=space(20)
                 zNR_DOMU=space(5)
                 zNR_MIESZK=space(5)
                 zKOD_POCZT=[  -   ]
                 zPOCZTA=space(20)
                 zTELEFON=space(15)
                 zSKARB=0
                 zURZAD=space(45)
                 zZATRUD=space(70)
                 zDOWOD=space(9)
                 zRODZ_DOK='D'
                 zSTATUS='U'
                 zPARAM_WOJ=M->PARAM_WOJ
                 zPARAM_POW=M->PARAM_POW
                 zBANK=space(30)
                 zKONTO=space(32)
//002 dwie nowe linie
                 zJAKI_PRZEL='N'
                 zKW_PRZELEW=0
                 zAKTYWNY := 'T'
                 zRODZOBOW := '1'
                 zDOKIDKRAJ := 'PL'
                 zZAGRNRID := Space( 20 )
                 zDOKIDROZ := ' '
              else
                 zNREWID=NREWID
                 zNAZWISKO=NAZWISKO
                 zIMIE1=IMIE1
                 zIMIE2=IMIE2
                 zIMIE_O=IMIE_O
                 zIMIE_M=IMIE_M
                 zPLEC=PLEC
                 zPESEL=PESEL
                 zNIP=NIP
                 zMIEJSC_UR=MIEJSC_UR
                 zDATA_UR=DATA_UR
                 zNAZW_RODU=NAZW_RODU
                 zOBYWATEL=OBYWATEL
                 zMIEJSC_ZAM=MIEJSC_ZAM
                 zGMINA=GMINA
                 zULICA=ULICA
                 zNR_DOMU=NR_DOMU
                 zNR_MIESZK=NR_MIESZK
                 zKOD_POCZT=KOD_POCZT
                 zPOCZTA=POCZTA
                 zTELEFON=TELEFON
                 zSKARB=SKARB
                 zZATRUD=ZATRUD
                 zDOWOD=DOWOD_OSOB
                 zRODZ_DOK=RODZ_DOK
                 zSTATUS=STATUS
                 zPARAM_WOJ=PARAM_WOJ
                 zPARAM_POW=PARAM_POW
                 zBANK=BANK
                 zKONTO=KONTO
                 zAKTYWNY := AKTYWNY
                 zRODZOBOW := RODZOBOW
//002 NOWE LINIE
                 zJAKI_PRZEL=JAKI_PRZEL
                 if zJAKI_PRZEL==' '
                    zJAKI_PRZEL='N'
                 endif
                 zKW_PRZELEW=KW_PRZELEW

//002 DO T¤D
                 zDOKIDKRAJ := DOKIDKRAJ
                 zZAGRNRID := ZAGRNRID
                 zDOKIDROZ := DOKIDROZ

                 sele urzedy
                 go zSKARB
                 zURZAD=miejsc_us+' - '+urzad
                 sele prac
              endif
              *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
              @ wiersz,1  get zNAZWISKO picture "@S29 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" valid v3_111()
              @ wiersz,31 get zIMIE1 picture    "@S14 !!!!!!!!!!!!!!!" valid v3_121()
              @ wiersz,46 get zIMIE2 picture    "@S14 !!!!!!!!!!!!!!!"
              @ wiersz,61 get zSTATUS picture  "!" when w3_131() valid v3_131()
              @ wiersz,69 get zPLEC   picture  "!" when w3_132() valid v3_132()
              @ wiersz,77 get zDOKIDKRAJ picture "!!"

              @ 12,12 get zPESEL picture "99999999999"
              @ 12,30 get zNIP picture "!!!!!!!!!!!!!"
              @ 12,56 get zRODZ_DOK picture "!" when w3_133() valid v3_133()
              @ 12,69 get zDOWOD picture "!!!999999"
              @ 13,19 get zDATA_UR pict '@D'
              @ 13,32 get zMIEJSC_UR picture "@S14 !!!!!!!!!!!!!!!!!!!!"
              @ 13,63 get zNAZW_RODU picture '@S15 '+repl('!',30) when rod()
              @ 14,15 get zIMIE_O picture "@S12 !!!!!!!!!!!!!!!"
              @ 14,34 get zIMIE_M picture "@S12 !!!!!!!!!!!!!!!"
              @ 14,63 get zOBYWATEL pict '@S16 '+repl('!',22)
              @ 15,23 get zMIEJSC_ZAM picture "!!!!!!!!!!!!!!!!!!!!"
              @ 15,52 get zKOD_POCZT picture "99-999"
              @ 15,68 get zPOCZTA picture "@S10 !!!!!!!!!!!!!!!!!!!!"
              @ 16,23 get zULICA picture "!!!!!!!!!!!!!!!!!!!!"
              @ 16,47 get zNR_DOMU picture "!!!!!"
              @ 16,55 get zNR_MIESZK picture "!!!!!"
              @ 16,68 get zTELEFON picture "@S10 !!!!!!!!!!!!!!!"
              @ 17, 8 get zGMINA picture "@S17 !!!!!!!!!!!!!!!!!!!!"
              @ 17,34 get zPARAM_POW picture "@S17 !!!!!!!!!!!!!!!!!!!!"
              @ 17,59 get zPARAM_WOJ picture "!!!!!!!!!!!!!!!!!!!!"
              @ 18,23 get zURZAD picture "!!!!!!!!!!!!!!!!!!!! - !!!!!!!!!!!!!!!!!!!!!!!!!" valid v3_141()
              @ 19,23 get zZATRUD picture '@S55 '+replicate('!',70)
              //002 zawezone parametry banku
              @ 20,7  get zBANK picture '@S15 '+repl('!',30)
              @ 20,29 get zKONTO picture '@S15 '+repl('!',32)
              //002 DWIE NOWE LINIE
              @ 20, 60 get zJAKI_PRZEL picture "!"  when wyb_przel() valid war_przel()
              @ 20, 71 get zKW_PRZELEW picture "99999.99" when wyl_przel() valid wyl_przel()
              @ 21, 16 get zZAGRNRID picture "!!!!!!!!!!!!!!!!!!!!"
              @ 21, 47 get zDOKIDROZ picture "9" WHEN PracDokidrozWhen() VALID PracDokidrozValid()

              read_()
              if lastkey()=27
                 break
              endif
              *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
              if ins
                 set orde to 4
                 do BLOKADA
                 go bott
                 IDPR=rec_no+1
                 set orde to 1
                 app()
                 repl_([FIRMA],IDENT_FIR)
                 repl_([REC_NO],IDPR)
                 sele etaty
                 for i=1 to 12
                     CURR=ColInf()
                     @ 24,0
                     center(24,'Dopisuje miesi&_a.c '+str(i,2))
                     setcolor(CURR)
                     app()
                     repl firma with ident_fir,;
                          ident with str(idpr,5),;
                          mc with str(i,2)
                     unlock
                 next
                 @ 24,0
              endif
              sele prac
              do BLOKADAR
              repl NREWID with zNREWID,;
                   NAZWISKO with zNAZWISKO,;
                   IMIE1 with zIMIE1,;
                   IMIE2 with zIMIE2,;
                   IMIE_O with zIMIE_O,;
                   IMIE_M with zIMIE_M,;
                   PLEC with zPLEC,;
                   PESEL with zPESEL,;
                   NIP with zNIP,;
                   MIEJSC_UR with zMIEJSC_UR,;
                   DATA_UR with zDATA_UR,;
                   NAZW_RODU with zNAZW_RODU,;
                   OBYWATEL with zOBYWATEL,;
                   MIEJSC_ZAM with zMIEJSC_ZAM,;
                   GMINA with zGMINA,;
                   ULICA with zULICA,;
                   NR_DOMU with zNR_DOMU,;
                   NR_MIESZK with zNR_MIESZK,;
                   KOD_POCZT with zKOD_POCZT,;
                   POCZTA with zPOCZTA,;
                   TELEFON with zTELEFON,;
                   PARAM_WOJ with zPARAM_WOJ,;
                   PARAM_POW with zPARAM_POW,;
                   SKARB with zSKARB,;
                   ZATRUD with zZATRUD,;
                   DOWOD_OSOB with zDOWOD,;
                   RODZ_DOK with zRODZ_DOK,;
                   STATUS with zSTATUS,;
                   BANK with zBANK,;
                   KONTO with zKONTO,;
                   JAKI_PRZEL with zJAKI_PRZEL,;
                   AKTYWNY WITH zAKTYWNY,;
                   RODZOBOW WITH zRODZOBOW,;
                   DOKIDKRAJ WITH zDOKIDKRAJ,;
                   DOKIDROZ WITH zDOKIDROZ,;
                   ZAGRNRID WITH zZAGRNRID
                   if (zJAKI_PRZEL='P').and.(zKW_PRZELEW > 100)
                      savescreen()
                      tone(500,4)
                      tone(500,4)
                      zKW_PRZELEW=100
                      ColErr()
                      @24,0 say padc('Nie mo&_z.e by&_c. wi&_e.cej niz 100 procent',80,' ')
                      pause(0)
                      czysc()
                      restscreen()
                   endif
                   if zKW_PRZELEW < 0
                      savescreen()
                      tone(500,4)
                      tone(500,4)
                      zKW_PRZELEW=0
                      ColErr()
                      @24,0 say padc('Warto&_s.&_c. przelewu nie mo&_z.e by&_c. warto&_s.ci&_a. ujemn&_a.',80,' ')
                      pause(0)
                      czysc()
                      restscreen()
                   endif
                   repl KW_PRZELEW with zKW_PRZELEW
//002 powyzej obsluga kwot przelewu
//002 UWAGA!!! jesli procentowy & kwota>100 to kwota = 100
              commit_()
              unlock
              *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
              _row=int((_row_g+_row_d)/2)
              if .not.ins
                 break
              endif
              *@ _row_d,_col_l say &_proc
              scroll(_row_g,_col_l,_row_d,_col_p,1)
              @ _row_d,_col_l say [                             ³              ³              ³       ³       ³  ]
        end
        _disp=ins.or.lastkey()#27
        kl=iif(lastkey()=27.and._row=-1,27,kl)
        @ 23,0
        *################################ KASOWANIE #################################
   case kl=7.or.kl=46
        RECS=rec_no
        sele umowy
        seek '+'+str(RECS,5)
        if .not.found().and.;
           (empty(prac->data_przy).or.(.not.empty(prac->data_przy).and.str(year(prac->data_przy),4)<param_rok).and.(.not.empty(prac->data_zwol).and.str(year(prac->data_zwol),4)<param_rok)).and.;
           (empty(prac->data_zwol).or.(.not.empty(prac->data_zwol).and.str(year(prac->data_zwol),4)<param_rok))
           sele prac
           @ 1,47 say [          ]
           ColStb()
           center(23,[þ                   þ])
           ColSta()
           center(23,[K A S O W A N I E])
           ColStd()
           _disp=tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
           if _disp
              do BLOKADAR
              del()
*              repl del with '-'
              unlock
              seek '+'+ident_fir

              select etaty
              seek [+]+ident_fir+str(RECS,5)
              do while del=[+].and.firma=ident_fir.and.ident=str(RECS,5)
                 do BLOKADAR
                 del()
                 unlock
                 skip
              enddo
              select nieobec
              seek [+]+ident_fir+str(RECS,5)
              do while del=[+].and.firma=ident_fir.and.ident=str(RECS,5)
                 do BLOKADAR
                 del()
                 unlock
                 skip
              enddo
              select wyplaty
              seek [+]+ident_fir+str(RECS,5)
              do while del=[+].and.firma=ident_fir.and.ident=str(RECS,5)
                 do BLOKADAR
                 del()
                 unlock
                 skip
              enddo
              select zaliczki
              seek [+]+ident_fir+str(RECS,5)
              do while del=[+].and.firma=ident_fir.and.ident=str(RECS,5)
                 do BLOKADAR
                 del()
                 unlock
                 skip
              enddo
              select umowy
              seek [+]+ident_fir+str(RECS,5)
              do while del=[+].and.firma=ident_fir.and.ident=str(RECS,5)
                 do BLOKADAR
                 del()
                 unlock
                 skip
              enddo
           endif
           *====================================
        else
           kom(3,[*u],[ Kasowanie niemo&_z.liwe. Pracownik pracowa&_l. lub pracuje dla firmy ])
           keyboard chr(27)
           inkey()
        endif
        sele prac
        @ 23,0
        *################################# SZUKANIE #################################
   case kl=-9.or.kl=247
        @ 1,47 say [          ]
        ColStb()
        center(23,[þ                 þ])
        ColSta()
        center(23,[S Z U K A N I E])
        ColStd()
        f10=space(30)
        @ _row,1 get f10 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        read_()
        _disp=.not.empty(f10).and.lastkey()#27
        if _disp
           seek [+]+ident_fir+dos_l(f10)
           if &_bot
              skip -1
           endif
           _row=int((_row_g+_row_d)/2)
        endif
        @ 23,0
   *############################### WYDRUK EWIDENCJI ###########################
   case kl=13
      IF prac->dokidkraj == 'PL' .OR. prac->dokidkraj == '  '
        menuDrkDek = menuDeklaracjaDruk(6, .F.)
        IF LastKey() != 27
           save screen to scr_
           do pit_811 with 0,0,1,menuDrkDek
           restore screen from scr_
        ENDIF
      ELSE
         SWITCH MenuEx( 6, 4, { "P - Deklaracja PIT-11", "I - Deklaracja IFT-1/IFT-1R" }, 1 )
         CASE 1
            menuDrkDek = menuDeklaracjaDruk(6, .F.)
            IF LastKey() != 27
               save screen to scr_
               do pit_811 with 0,0,1,menuDrkDek
               restore screen from scr_
            ENDIF
            EXIT
         CASE 2
            menuDrkDek = menuDeklaracjaDruk(6, .F.)
            IF LastKey() != 27
               save screen to scr_
               IFT1_Rob( menuDrkDek == 'X' )
               Select( 'PRAC' )
               restore screen from scr_
            ENDIF
            EXIT
         ENDSWITCH
      ENDIF
*################################### USTAW AKTYWNY/NIEAKTYWNY ###############
   CASE (kl=65.OR.kl=97)//.AND.(.NOT.&_top_bot)
        IF .NOT.Empty(prac->data_zwol)
           IF tnesc([*i],[   Czy ukry&_c. pracownika? (T/N)   ])
              select prac
              blokadar()
              REPLACE aktywny WITH iif(aktywny=='T','N','T')
              commit_()
              seek '+'+ident_fir
           ENDIF
        ELSE
           kom(3,[*u],[ Ukrywanie niemo&_z.liwe. Pracownik pracuje dla firmy ])
           keyboard chr(27)
           inkey()
        ENDIF
*################################### FILTR AKTYWNY/NIEAKTYWNY ###############
   CASE kl=-4
        _prac_aktywny := iif(_prac_aktywny == 'T', 'N', 'T')
        SELECT prac
        SET FILTER TO prac->aktywny == _prac_aktywny
        GO TOP
        IF _prac_aktywny == 'T'
           @  3, 0 say '           '
        ELSE
           popKolor = ColStb()
           @  3, 0 say 'NIEAKTYWNI'
           SetColor(popKolor)
        ENDIF
*################################### POMOC ##################################
   case kl=28
        save screen to scr_
        @ 1,47 say [          ]
        declare p[20]
        *---------------------------------------
        p[ 1]='                                                        '
        p[ 2]='   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja  '
        p[ 3]='   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
        p[ 4]='   [Home/End]..............pierwsza/ostatnia pozycja    '
        p[ 5]='   [Enter].................deklaracja PIT-11 lub PIT-8B '
        p[ 6]='   [Ins]...................wpisywanie                   '
        p[ 7]='   [M].....................modyfikacja pozycji          '
        p[ 8]='   [Del]...................kasowanie pozycji            '
        p[ 9]='   [F10]...................szukanie                     '
        p[10]='   [A].....................aktywny / nieaktywny         '
        p[11]='   [F5]....................pokaz aktywnych/nieaktywnych '
        p[12]='   [Esc]...................wyj&_s.cie                      '
        p[13]='                                                        '
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
   ******************** ENDCASE
   endcase
enddo
close_()
*################################## FUNKCJE #################################
procedure say31
RETURN SubStr(NAZWISKO, 1, 29)+[³]+SubStr(IMIE1, 1, 14)+[³]+SubStr(IMIE2, 1, 14)+[³]+iif(STATUS<>'U',iif(STATUS='E','Etatowy','Zlecen.'),'Uniwers')+[³]+iif(PLEC='M','M&_e.&_z.czyz','Kobieta')+[³]+DOKIDKRAJ
*############################################################################
procedure say31s
   LOCAL cRodzajDokIdStr

clear type
set color to +w
*_iledni=year(date()-DATA_UR)
*_newdate=_iledni/365
   @ 11,4  say transform(str(int((date()-DATA_UR)/365),2),'99')+' lat'

   @ 12,12 say PESEL
   @ 12,30 say NIP
   @ 12,56 say RODZ_DOK+iif(RODZ_DOK='D','ow&_o.d   ','aszport')
   @ 12,69 say DOWOD_OSOB
   @ 13,19 say DATA_UR
   @ 13,32 say substr(MIEJSC_UR,1,14)
   @ 13,63 say substr(NAZW_RODU,1,15)
   @ 14,15 say substr(IMIE_O,1,12)
   @ 14,34 say substr(IMIE_M,1,12)
   @ 14,63 say substr(OBYWATEL,1,16)
   @ 15,23 say MIEJSC_ZAM
   @ 15,52 say KOD_POCZT
   @ 15,68 say substr(POCZTA,1,10)
   @ 16,23 say ULICA
   @ 16,47 say NR_DOMU
   @ 16,55 say NR_MIESZK
   @ 16,68 say substr(TELEFON,1,10)
   @ 17, 8 say substr(GMINA,1,17)
   @ 17,34 say substr(PARAM_POW,1,17)
   @ 17,59 say PARAM_WOJ
   sele urzedy
   go prac->skarb
   zurzad=miejsc_us+' - '+urzad
   @ 18,23 say zURZAD
   sele prac
   @ 19,23 say substr(ZATRUD,1,55)
                 //002 skrocenia pol banku
   @ 20,7  say substr(BANK,1,15)
   @ 20,29 say substr(KONTO,1,15)
               //002 nowe linie
   if JAKI_PRZEL==' '
      @ 20,60 say 'N'
   else
      @ 20, 60 say JAKI_PRZEL
   endif
   @ 20, 61 say iif(JAKI_PRZEL='K','wotowo:   ',iif(JAKI_PRZEL='P','rocentowo:','ie przel. '))
   if JAKI_PRZEL$' N'=.f.
      @ 20, 71 say KW_PRZELEW
   else
      @ 20, 71 say space(8)
   endif
            //002 DO T¤D
   @ 21, 16 say prac->zagrnrid
   @ 21, 47 say prac->dokidroz + ' - ' + SubStr( PadR( PracDokRodzajStr( prac->dokidroz ), 28 ), 1, 28 )
set color to
return
***************************************************
function v3_111
if empty(zNAZWISKO)
   return .f.
endif
return .t.
***************************************************
function v3_121
if empty(zIMIE1)
   return .f.
endif
return .t.
***************************************************
function w3_131
ColInf()
@ 24,0 say padc('Wpisz: E - pracownik etatowy , Z - pracownik na zlecenie lub U - uniwersalny',80,' ')
ColStd()
@ wiersz,62 say iif(zSTATUS<>'U',iif(zSTATUS='E','tatowy','lecen.'),'niwers')
return .t.
***************************************************
function v3_131
R=.f.
if zSTATUS$'EZU'
   ColStd()
   @ wiersz,62 say iif(zSTATUS<>'U',iif(zSTATUS='E','tatowy','lecen.'),'niwers')
   @ 24,0
   IF zSTATUS <> 'Z'
      zDOKIDKRAJ := 'PL'
   ENDIF
   R=.t.
endif
return R
***************************************************
function w3_132
ColInf()
@ 24,0 say padc('Wpisz: M - m&_e.&_z.czyzna lub K - kobieta',80,' ')
ColStd()
@ wiersz,70 say iif(zPLEC='M','&_e.&_z.czyz','obieta')
return .t.
***************************************************
function v3_132
R=.f.
if zPLEC$'MK'
   ColStd()
   @ wiersz,70 say iif(zPLEC='M','&_e.&_z.czyz','obieta')
   @ 24,0
   R=.t.
endif
return R
***************************************************
function w3_133
ColInf()
@ 24,0 say padc('Wpisz: D - dow&_o.d osobisty lub P - paszport',80,' ')
ColStd()
@ 12,57 say iif(zRODZ_DOK='D','ow&_o.d   ','aszport')
return .t.
***************************************************
function v3_133
R=.f.
if zRODZ_DOK$'DP'
   ColStd()
   @ 12,57 say iif(zRODZ_DOK='D','ow&_o.d   ','aszport')
   @ 24,0
   R=.t.
endif
return R
***************************************************
function v3_141
if lastkey()=5
   return .t.
endif
save screen to scr2
select urzedy
seek [+]+substr(zurzad,1,20)+substr(zurzad,24)
if del#[+].or.miejsc_us#substr(zurzad,1,20).or.urzad#substr(zurzad,24)
   skip -1
endif
urzedy_()
restore screen from scr2
if lastkey()=13
   zurzad=miejsc_us+' - '+urzad
   set color to i
   @ 18,23 say zurzad
   set color to
   pause(.5)
endif
select prac
return .not.empty(zurzad)
***************************************************
function rod
if empty(zNAZW_RODU)
   zNAZW_RODU=zNAZWISKO
endif
return .t.
***************************************************
//002 nowe funkcje
function wyb_przel
if empty(zBANK) .or. empty(zKONTO) .or. zKONTO='  -        -'
   zJAKI_PRZEL='N'
   zKW_PRZELEW=0
else
   @ 20,61 say iif(zJAKI_PRZEL='K','wotowo:   ',iif(zJAKI_PRZEL='P','rocentowo:','ie przel. '))
endif
   war_przel()
   ColInf()
   @ 24,0 say padc('Wpisz: K - kwotowo, P - w procentach lub N - nie przelewa&_c',80,' ')
return .t.
***************************************************
function war_przel
if zJAKI_PRZEL$'KPN'
   ColStd()
   @ 20,61 say iif(zJAKI_PRZEL='K','wotowo:   ',iif(zJAKI_PRZEL='P','rocentowo:','ie przel. '))
   @ 24,0
   if (empty(zBANK) .or. empty(zKONTO)) .and. (zJAKI_PRZEL<>'N')
      tone(500,4)
      tone(500,4)
      ColErr()
      @24,0 say padc('Niekompletne dane banku. Musisz wybra&_c opcj&_e "N"',80,' ')
      zJAKI_PRZEL='N'
      R = .f.
   else
      R = .t.
   endif
else
   zJAKI_PRZEL='N'
   R = .f.
endif
return R
***************************************************
function wyl_przel
if zJAKI_PRZEL='N'
   zKW_PRZELEW=0
endif
czysc()
return .t.

function czysc
   ColStd()
   @ 24, 0
return .t.
*############################################################################

/*----------------------------------------------------------------------*/

FUNCTION PracDokidrozWhen()
   LOCAL cKolorTmp
   cEkranTmp := SaveScreen( 13, 10, 20, 60 )
   cKolorTmp := ColInf()
   @ 13, 10 CLEAR TO 20, 60
   @ 13, 10, 20, 60 BOX B_SINGLE + Space( 1 )
   @ 14, 12 SAY '1 - NUMER IDENTYFIKACYJNY TIN'
   @ 15, 12 SAY '2 - NUMER UBEZPIECZENIOWY'
   @ 16, 12 SAY '3 - PASZPORT'
   @ 17, 12 SAY '4 - URZ¨DOWY DOKUMENT STWIERDZAJ¤CY TO½SAMO—'
   @ 18, 12 SAY '8 - INNY RODZAJ IDENTYFIKACJI PODATKOWEJ'
   @ 19, 12 SAY '9 - INNY DOKUMENT POTWIERDZAJ¤CY TO½SAMO—'
   SetColor( cKolorTmp )
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION PracDokidrozValid()
   LOCAL lRes := zDOKIDROZ$'123489 '
      IF lRes
         RestScreen( 13, 10, 20, 60, cEkranTmp )
         @ 21, 48 SAY ' - ' + SubStr( PadR( PracDokRodzajStr( zDOKIDROZ ), 28 ), 1, 28 )
      ENDIF
   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION PracDokRodzajStr( cRodzaj )
   LOCAL cRodzajDokIdStr
   IF ! HB_ISCHAR( cRodzaj ) .OR. Len( cRodzaj ) == 0
      RETURN ''
   ENDIF
   DO CASE
   CASE cRodzaj == '1'
      cRodzajDokIdStr := 'NUMER IDENTYFIKACYJNY TIN'
   CASE cRodzaj == '2'
      cRodzajDokIdStr := 'NUMER UBEZPIECZENIOWY'
   CASE cRodzaj == '3'
      cRodzajDokIdStr := 'PASZPORT'
   CASE cRodzaj == '4'
      cRodzajDokIdStr := 'URZ¨DOWY DOKUMENT STWIERDZAJ¤CY TO½SAMO—'
   CASE cRodzaj == '8'
      cRodzajDokIdStr := 'INNY RODZAJ IDENTYFIKACJI PODATKOWEJ'
   CASE cRodzaj == '9'
      cRodzajDokIdStr := 'INNY DOKUMENT POTWIERDZAJ¤CY TO½SAMO—'
   OTHERWISE
      cRodzajDokIdStr := ''
   ENDCASE
   RETURN cRodzajDokIdStr

/*----------------------------------------------------------------------*/

FUNCTION CzyPracowPonizej26R( nMiesiac, nRok )

   IF nMiesiac == 12
      nMiesiac := 1
      nRok := nRok + 1
   ELSE
      nMiesiac := nMiesiac + 1
   ENDIF

   RETURN Int( ( hb_Date( nRok, nMiesiac, 1 ) - prac->data_ur ) / 365 ) < 26

/*----------------------------------------------------------------------*/

