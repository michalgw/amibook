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
*±±±±±± PARAM    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul parametrow programu przechowywanych w pliku PARAM.MEM               ?
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*############################# PARAMETRY POCZATKOWE #########################
#include "hbgtinfo.ch"

FUNCTION Param()

   PRIVATE oGetKW

if .not.file([param.mem])
   save to param all like param_*
   return
endif
*################################# GRAFIKA ##################################
ColSta()
@  2,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
ColStd()
@  3,42 say ' Has&_l.o do programu º Rok ewidencyjny  '
@  4,42 say '                   º                  '
@  5,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@  6,42 say 'Odlicz.od pod.doch.º Sygna&_l. o VAT od  '
@  7,42 say '                   º                  '
@  8,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@  9,42 say 'Auto.tworz.kataloguº D«wi©ki programu '
@ 10,42 say 'kontrahentow       º                  '
@ 11,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@ 12,42 say ' Podatek liniowy %                    '
@ 13,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@ 14,42 say ' Czy ma by&_c. wy&_s.wietlana L.p. z ksi&_e.gi '
@ 15,42 say '                                      '
@ 16,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍDOMY&__S.LNEÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@ 17,42 say '   Wojew&_o.dztwo            Powiat      '
@ 18,42 say '                                      '
@ 19,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@ 20,42 say '    Obsˆuga myszki                    '
@ 21,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@ 22,42 say 'Wˆasny tytuˆ okna:                    '
*################################# OPERACJE #################################
do say_p
kl=0
do while kl#27
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   ColStd()
   kl=inkey(0)
   do case
   *############################### MODYFIKACJA ################################
   case kl=109.or.kl=77
        @ 1,47 say [          ]
        ColStb()
        center(23,[?                      ş])
        ColSta()
        center(23,[M O D Y F I K A C J A])
        ColStd()
        begin sequence
        *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ ZMIENNE ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ
              zparam_has=param_has
              zparam_rok=param_rok
              zparam_kw=param_kw
              zparam_kwd=param_kwd
              zparam_kw2=param_kw2
              zparam_kw3=iif( Date() < param_kwd, param_kw, param_kw2 )
              zparam_vat=param_vat
              zparam_aut=param_aut
              zparam_lin=param_lin
              zparam_lp=param_lp
              zparam_woj=param_woj
              zparam_pow=param_pow
              zparam_dzw=param_dzw
              zprofil_mysz=iif(hProfilUzytkownika['mysz'], 'T', 'N')
              IF Len(param_tyt) = 0
                 zparam_tyt = '                   '
              ELSE
                 zparam_tyt=param_tyt
              ENDIF
              *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ GET ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ
              @  4,48 get zparam_has picture [!!!!!!!!] valid vp_1()
              @  4,69 get zparam_rok picture "9999" valid vp_2()
              @  7,46 get zparam_kw3 picture "  9999999.99" WHEN ParmaKW3When()  //range 0,9999999
              oGetKW := ATail( GetList )
              @  7,66 get zparam_vat picture "999999.99" range 0,999999
              @ 10,56 get zparam_aut picture "!" valid vp_3()
              @ 10,69 get zparam_dzw picture "!" valid vp_3v()
              @ 12,70 get zparam_lin picture "99"
              @ 15,60 get zparam_lp picture "!" valid vp_5()
              @ 18,42 get zparam_woj picture "@S18 !!!!!!!!!!!!!!!!!!!!"
              @ 18,62 get zparam_pow picture "@S18 !!!!!!!!!!!!!!!!!!!!"
              @ 20,68 get zprofil_mysz picture "!" valid vp_mysz()
              @ 22,61 get zparam_tyt picture "XXXXXXXXXXXXXXXXXXX"
              ****************************
              clear type
              read_()
              if lastkey()=27
                 break
              endif
              *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ REPL ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ?
              param_has=zparam_has
              param_rok=zparam_rok
              param_kw=zparam_kw
              param_kwd=zparam_kwd
              param_kw2=zparam_kw2
              param_vat=zparam_vat
              param_aut=zparam_aut
              param_lin=zparam_lin
              param_lp=zparam_lp
              param_woj=zparam_woj
              param_pow=zparam_pow
              param_dzw=zparam_dzw
              param_tyt=zparam_tyt
              *--------------
              /*
              if param_lp=[T]
                 ColInb()
                 @ 24,0
                 center(24,[Trwa nadawanie liczby porz&_a.dkowej - prosz&_e. czeka&_c....])
                 ColStd()
                 select 2
                 do while.not.dostep('FIRMA')
                 enddo
                 select 1
                 do while.not.dostep('OPER')
                 enddo
                 do SETIND with 'OPER'
                 zfirma=[   ]
                 do BLOKADA
                 do while del=[+]
                    if firma#zfirma
                       zfirma=firma
                       select firma
                       go val(zfirma)
                       zlp=liczba
                       select oper
                    endif
                    repl_([lp],zlp)
                    zlp=zlp+1
                    skip
                 enddo
                 unlock
                 close_()
                 ColStd()
                 @ 24,0
              ENDIF
              */

              IF param_lp == 'T' .AND. TNEsc( , "Czy odbudowa† numeracj© ksi©gi? (T/N)" )
                 //Ksiega_Przenumeruj()
                 numeruj()
              ENDIF

              IF TNEsc( , "Czy przypsa† kwot© woln¥ do wszysztkich firm? (T/N)" )
                 UstawKwoteWolnaWFirmach()
              ENDIF

              IF Len(AllTrim(param_tyt)) > 0
                 hb_gtInfo(HB_GTI_WINTITLE, AllTrim(param_tyt) + " - AMi-BOOK " + wersprog)
              ELSE
                 hb_gtInfo(HB_GTI_WINTITLE, "AMi-BOOK " + wersprog)
              ENDIF
              save to param all like param_*
              hProfilUzytkownika['mysz'] := iif(zprofil_mysz == 'T', .T., .F.)

              ZapiszProfilUzytkownika()

              IF (hProfilUzytkownika['mysz'] == .T.)
                 SET EVENTMASK TO 255
                 mSetCursor( .t. )
              ENDIF

        end
        do say_p
        @ 23,0
        *################################### POMOC ##################################
   case kl=28
        save screen to scr_
        @ 1,47 say [          ]
        declare p[20]
        *---------------------------------------
        p[ 1]='                                                   '
        p[ 2]='     [M].....................modyfikacja           '
        p[ 3]='     [D].....................przywr¢c domy˜lne     '
        p[ 4]='     [Esc]...................wyj&_s.cie               '
        p[ 5]='                                                   '
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
   CASE kl == Asc( 'D' ) .OR. kl == Asc( 'd' )

      IF TNEsc( , "Czy przywr¢ci† domy˜lne parametry ? (Tak/Nie)" )
         DomParPrzywroc_Param( .T., DomParRok() )
         say_p()
         _disp := .T.
      ENDIF

   endcase
enddo
close_()
*################################## FUNKCJE #################################
procedure say_p
clear type
set colo to w+
@  4,48 say dos_c(param_has)
@  4,69 say param_rok
@  7,46 say iif( Date() < param_kwd, param_kw, param_kw2 ) picture "9 999 999.99"
@  7,66 say param_vat picture "999999.99"
@ 10,56 say iif(param_aut=[T],[Tak],[Nie])
@ 10,69 say iif(param_dzw=[T],[Tak],[Nie])
@ 12,70 say param_lin picture [99]
@ 15,60 say iif(param_lp=[T],[Tak],[Nie])
@ 18,42 say padc(alltrim(param_woj),18)
@ 18,62 say padc(alltrim(param_pow),18)
@ 20,68 say iif(hProfilUzytkownika['mysz'], 'Tak', 'Nie')
@ 22,61 say param_tyt
ColStd()
***************************************************
function vp_1
return .not.[ ]$alltrim(zparam_has)
***************************************************
function vp_2
if lastkey()=5
return .t.
endif
return .not.[ ]$zparam_rok
***************************************************
function vp_3
if lastkey()=5
return .t.
endif
   if .not.zparam_aut$[TN]
   zparam_aut=param_aut
   return .f.
   endif
set colo to w+
@ 10,57 say iif(zparam_aut=[T],[ak],[ie])
ColStd()
return .t.
***************************************************
function vp_3v
if lastkey()=5
return .t.
endif
   if .not.zparam_dzw$[TN]
   zparam_dzw=param_dzw
   return .f.
   endif
set colo to w+
@ 10,70 say iif(zparam_dzw=[T],[ak],[ie])
ColStd()
return .t.
***************************************************
/*function vp_41
if lastkey()=5
return .t.
endif
   if zparam_dru#'IBM'.and.zparam_dru#'EPS'.and.zparam_dru#'PCL'.AND.zparam_dru#'WIN'
      kom(2,[*u],[ Wpisz "IBM", "EPS", "PCL" lub "WIN" ])
      return .f.
   endif
   if zparam_dru='PCL'.OR.zparam_dru='WIN'
      zparam_cal=10
   endif
return .t.*/
***************************************************
/*function vp_4
if lastkey()=5
return .t.
endif
   if zparam_cal#10.and.zparam_cal#15
   kom(2,[*u],[ 10 lub 15 ])
   return .f.
   endif
return .t.*/
***************************************************
function vp_5
if lastkey()=5
return .t.
endif
   if .not.zparam_lp$[TN]
   zparam_lp=param_lp
   return .F.
   endif
   IF zparam_lp == 'N' .AND. param_kslp == '3'
      zparam_lp=param_lp
      komun('Nie mo¾na wyˆ¥czy† Lp. Jest wˆ¥czone sortowanie po tym polu')
      return .F.
   ENDIF
set colo to w+
@ 15,61 say iif(zparam_lp=[T],[ak],[ie])
ColStd()
return .t.
*############################################################################

FUNCTION vp_mysz()
if lastkey()=5
return .t.
endif
   if .not.zprofil_mysz$[TN]
   zprofil_mysz=iif(hProfilUzytkownika['mysz'],'T','N')
   return .f.
   endif
set colo to w+
@ 20,69 say iif(zparam_lp=[T],[ak],[ie])
ColStd()
return .T.

/*----------------------------------------------------------------------*/

FUNCTION WczytajProfilUzytkownika()

   LOCAL hRes := hb_Hash(), aStruct

   hRes['mysz'] := .F.
   hRes[ 'drukarka' ] := ''
   hRes[ 'marginl' ] := 5
   hRes[ 'marginp' ] := 5
   hRes[ 'marging' ] := 5
   hRes[ 'margind' ] := 15

   SELECT 1
   IF !dostep( 'profil' )
      RETURN hRes
   ENDIF

   SET FILTER TO AllTrim( profil->punkt ) == AllTrim( cPunktLogowania )
   profil->( dbGoTop() )
   IF profil->( Eof() )
      profil->( dbAppend() )
      profil->punkt := cPunktLogowania
      profil->mysz := .F.
      profil->marginl := 5
      profil->marginp := 5
      profil->marging := 5
      profil->margind := 15
      profil->( dbCommit() )
   ELSE
      hRes[ 'mysz' ] := profil->mysz
      hRes[ 'drukarka' ] := profil->drukarka
      hRes[ 'marginl' ] := profil->marginl
      hRes[ 'marginp' ] := profil->marginp
      hRes[ 'marging' ] := profil->marging
      hRes[ 'margind' ] := profil->margind
   ENDIF

   dbCloseArea()

   RETURN hRes

/*----------------------------------------------------------------------*/

FUNCTION ZapiszProfilUzytkownika()

   LOCAL lRes := .F.

   IF DostepPro( 'profil' )

      SET FILTER TO AllTrim( profil->punkt ) == AllTrim( cPunktLogowania )

      profil->( dbGoTop() )

      IF profil->( Eof() )
         dbAppend()
         profil->punkt := cPunktLogowania
      ELSE
         blokada()
      ENDIF

      profil->mysz := hProfilUzytkownika[ 'mysz' ]
      profil->drukarka := hProfilUzytkownika[ 'drukarka' ]
      profil->marginl := hProfilUzytkownika[ 'marginl' ]
      profil->marginp := hProfilUzytkownika[ 'marginp' ]
      profil->marging := hProfilUzytkownika[ 'marging' ]
      profil->margind := hProfilUzytkownika[ 'margind' ]

      profil->( dbCommit() )
      unlock
      close_()
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE Ksiega_Przenumeruj()

   LOCAL nLp := 1
   LOCAL cFirmaId := "   "
   LOCAL lMies, cMC
   LOCAL cKolor

   IF ! DostepPro( "FIRMA", , , , "FIRMA" )
      RETURN
   ENDIF

   IF ! DostepPro( "OPER", , , "OPER", "OPER" )
      firma->( dbCloseArea() )
      RETURN
   ENDIF

   IF param_kslp == '3'
      oper->( dbSetOrder( 4 ) )
   ENDIF

   IF ! BlokadaPro( "OPER" )
      oper->( dbCloseArea() )
      firma->( dbCloseArea() )
      RETURN
   ENDIF

   cKolor := ColInb()
   @ 24, 0
   Center( 24, 'Trwa nadawanie liczby porz¥dkowej - prosz© czeka†...' )

   DO WHILE oper->del == "+"
      IF oper->firma # cFirmaId
         cFirmaId := oper->firma
         firma->( dbGoto( Val( cFirmaId ) ) )
         nLp := firma->liczba
         lMies := firma->rodznrks == 'M'
      ENDIF
      oper->lp := nLp
      nLp++
      cMC := oper->mc
      oper->( dbSkip() )
      IF lMies .AND. oper->mc # cMC
         nLp := 1
      ENDIF
   ENDDO

   oper->( dbCommit() )
   oper->( dbUnlock() )
   oper->( dbCloseArea() )
   firma->( dbCloseArea() )

   ColStd()
   @ 24, 0
   SetColor( cKolor )

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION ParmaKW3When()

   LOCAL cScreen
   LOCAL GetList := {}

   SAVE SCREEN TO cScreen

   ColStd()

   @ 7, 42 CLEAR TO 10, 79
   @ 7, 42 TO 10, 79
   @ 8, 45 SAY '1. Kwota przed' GET zparam_kw PICTURE "9999999.99" range 0,9999999
   @ 9, 45 SAY '2. Od' GET zparam_kwd PICTURE "@D"
   @ 9, 62 SAY 'kwota' GET zparam_kw2 PICTURE "9999999.99" range 0,9999999
   READ

   IF LastKey() == 27
      zparam_kw := param_kw
      zparam_kwd := param_kwd
      zparam_kw2 := param_kw2
   ENDIF

   zparam_kw3 := iif( Date() < zparam_kwd, zparam_kw, zparam_kw2 )

   RESTORE SCREEN FROM cScreen

   IF ! Empty( oGetKW )
      oGetKW:display()
   ENDIF

   RETURN .F.

/*----------------------------------------------------------------------*/

PROCEDURE UstawKwoteWolnaWFirmach()

   ColInf()
   @ 24, 0 SAY PadC( "Ustawianie kwoty wolnej...", 80 )

   DO WHILE ! Dostep( 'SPOLKA' )
   ENDDO
   SetInd( 'SPOLKA' )

   spolka->( dbGoTop() )
   DO WHILE ! spolka->( Eof() )
      IF spolka->del == '+'
         spolka->( dbRLock() )
         spolka->param_kw := m->param_kw
         spolka->param_kwd := m->param_kwd
         spolka->param_kw2 := m->param_kw2
         spolka->( dbCommit() )
         spolka->( dbRUnlock() )
      ENDIF
      spolka->( dbSkip() )
   ENDDO
   spolka->( dbCloseArea() )

   ColStd()
   @ 24, 0
   RETURN NIL

/*----------------------------------------------------------------------*/

