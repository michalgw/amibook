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

#include "inkey.ch"

FUNCTION Suma_MC( lGraficzny )

   LOCAL aDane := {}, hPoz, nK16, xRem
   PRIVATE _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
   PRIVATE _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15

   hb_default( @lGraficzny, .T. )

   BEGIN SEQUENCE

      @ 1, 47 SAY Space(10)
      *-----parametry wewnetrzne-----
      _lewa := 1
      _prawa := 123
      _papsz := 1
      _strona := .F.
      _czy_mon := .T.
      _czy_close := .T.
      czesc := 1
      *------------------------------
      _szerokosc := 123
      _koniec := "del#[+].or.firma#ident_fir.or.mc>str(do_mc,2)"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      od_mc := 1
      do_mc := 12
      @ 23, 1  CLEAR TO 23, 75
      @ 23, 10 SAY 'Od m-ca' GET od_mc PICTURE '99'
      @ 23, 22 SAY 'Do m-ca' GET do_mc PICTURE '99'
      read_()
      IF LastKey() == K_ESC
         BREAK
      ENDIF
      IF od_mc > do_mc
         kom( 3, '*u', ' Nieprawid&_l.owy zakres ' )
         BREAK
      ENDIF
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      SELECT 3
      IF dostep( 'OPER' )
         SET INDEX TO oper
      ELSE
         SELECT 1
         BREAK
      ENDIF
      SELECT 2
      IF dostep( 'FIRMA' )
         GO Val( ident_fir )
      ELSE
         SELECT 1
         BREAK
      ENDIF
      SELECT 1
      IF dostep('SUMA_MC')
         SET INDEX TO suma_mc
         SEEK '+' + ident_fir + Str( od_mc, 2 )
      ELSE
         SELECT 1
         BREAK
      ENDIF
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      IF &_koniec
         kom( 3, '*w', 'b r a k   d a n y c h' )
         BREAK
      ENDIF

   IF lGraficzny

      xRem := TNEsc( .T., "Uwzgl©dni† remanent pocz¥tkowy? (Tak/Nie)" )
      @ 24, 0
      IF xRem == K_ESC
         BREAK
      ENDIF
      xRem := xRem == Asc( 'T' ) .OR. xRem == Asc( 't' )

      SELECT suma_mc
      DO WHILE ! &_koniec
         hPoz := hb_Hash()
         hPoz[ 'miesiac' ] := AllTrim( miesiac( Val( suma_mc->mc ) ) )
         hPoz[ 'P7' ] := suma_mc->wyr_tow
         hPoz[ 'P8' ] := suma_mc->uslugi
         hPoz[ 'P9' ] := suma_mc->wyr_tow + suma_mc->uslugi
         hPoz[ 'P10' ] := suma_mc->zakup
         hPoz[ 'P11' ] := suma_mc->uboczne
         hPoz[ 'P12' ] := suma_mc->wynagr_g
         hPoz[ 'P13' ] := suma_mc->wydatki
         hPoz[ 'P14' ] := suma_mc->wynagr_g + suma_mc->wydatki
         hPoz[ 'P15' ] := suma_mc->pusta
         hPoz[ 'RP7' ] := 0
         hPoz[ 'RP8' ] := 0
         hPoz[ 'RP9' ] := 0
         hPoz[ 'RP10' ] := 0
         hPoz[ 'RP11' ] := 0
         hPoz[ 'RP12' ] := 0
         hPoz[ 'RP13' ] := 0
         hPoz[ 'RP14' ] := 0
         hPoz[ 'RP15' ] := 0
         hPoz[ 'RP16' ] := 0
         hPoz[ 'RPJest' ] := 0
         // Pobrac wartosk kol 16 z pozycji
         nK16 := 0
         IF oper->( dbSeek( '+' + ident_fir + suma_mc->mc ) )
            DO WHILE oper->del == '+' .AND. oper->firma == ident_fir .AND. oper->mc == suma_mc->mc
               nK16 := nK16 + oper->k16wart

               IF xRem .AND. RTrim( oper->numer ) == Chr( 1 ) + 'REM-P'
                  hPoz[ 'RP7' ] := hPoz[ 'RP7' ] + oper->wyr_tow
                  hPoz[ 'RP8' ] := hPoz[ 'RP8' ] + oper->uslugi
                  hPoz[ 'RP9' ] := hPoz[ 'RP9' ] + oper->wyr_tow + oper->uslugi
                  hPoz[ 'RP10' ] := hPoz[ 'RP10' ] + oper->zakup
                  hPoz[ 'RP11' ] := hPoz[ 'RP11' ] + oper->uboczne
                  hPoz[ 'RP12' ] := hPoz[ 'RP12' ] + oper->wynagr_g
                  hPoz[ 'RP13' ] := hPoz[ 'RP13' ] + oper->wydatki
                  hPoz[ 'RP14' ] := hPoz[ 'RP14' ] + oper->wynagr_g + oper->wydatki
                  hPoz[ 'RP15' ] := hPoz[ 'RP15' ] + oper->pusta
                  hPoz[ 'RP16' ] := hPoz[ 'RP16' ] + oper->k16wart
                  hPoz[ 'RPJest' ] := 1
               ENDIF

               oper->( dbSkip() )
            ENDDO
         ENDIF
         hPoz[ 'P16' ] := nK16

         hPoz[ 'P7' ] += hPoz[ 'RP7' ]
         hPoz[ 'P8' ] += hPoz[ 'RP8' ]
         hPoz[ 'P9' ] += hPoz[ 'RP9' ]
         hPoz[ 'P10' ] += hPoz[ 'RP10' ]
         hPoz[ 'P11' ] += hPoz[ 'RP11' ]
         hPoz[ 'P12' ] += hPoz[ 'RP12' ]
         hPoz[ 'P13' ] += hPoz[ 'RP13' ]
         hPoz[ 'P14' ] += hPoz[ 'RP14' ]
         hPoz[ 'P15' ] += hPoz[ 'RP15' ]
         hPoz[ 'P16' ] += hPoz[ 'RP16' ]

         AAdd( aDane, hPoz )
         suma_mc->( dbSkip() )
      ENDDO

      @ 24, 0
      @ 24, 26 PROMPT '[ Monitor ]'
      @ 24, 44 PROMPT '[ Drukarka ]'
      IF trybSerwisowy
         @ 24, 70 PROMPT '[ Edytor ]'
      ENDIF
      CLEAR TYPE
      menu TO nMonDruk
      if lastkey() == K_ESC
         BREAK
      endif
      oRap := TFreeReport():New()
      oRap:LoadFromFile('frf\sumamc.frf')

      IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
         oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
      ENDIF

      FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
         hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

      oRap:AddValue('uzytkownik', code())
      oRap:AddValue('rok', param_rok)
      oRap:AddValue('firma', scal( AllTrim( firma->nazwa ) + ' ' + firma->miejsc + ' ul.' + firma->ulica + ' ' + firma->nr_domu + iif( Empty( firma->nr_mieszk ), ' ', '/' ) + firma->nr_mieszk ) )
      oRap:AddValue('rem', iif( xRem, 1, 0 ) )
      oRap:AddDataset('pozycje')
      AEval(aDane, { |aPoz| oRap:AddRow('pozycje', aPoz) })

      oRap:OnClosePreview := 'UsunRaportZListy(' + AllTrim(Str(DodajRaportDoListy(oRap))) + ')'
      oRap:ModalPreview := .F.

      SWITCH nMonDruk
      CASE 1
         oRap:ShowReport()
         EXIT
      CASE 2
         oRap:PrepareReport()
         oRap:PrintPreparedReport('', 1)
         EXIT
      CASE 3
         oRap:DesignReport()
         EXIT
      ENDSWITCH

      oRap := NIL

   ELSE

      mon_drk('ö' + ProcName() )
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      SELECT firma
      k1=scal(alltrim(nazwa)+[ ]+miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk)
      select suma_mc
      k1=k1+space(100-len(k1))
      mon_drk([               ]+k1)
      mon_drk([           ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([ Rok       ³               Przych&_o.d              ³    Zakup   ³          ³                 Wydatki (koszty)               ³])
      mon_drk([ ewiden-   ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ´   towar&_o.w  ³  Koszty  ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([ cyjny     ³  warto&_s.&_c.   ³ pozosta&_l.e ³   razem    ³ handlowych ³  uboczne ³wynagrodz.³  pozosta&_l.e ³    razem   ³           ³])
      mon_drk([ ]+param_rok+[      ³sprzedanych ³ przychody ³  przych&_o.d  ³i materia&_l.&_o.w³  zakupu  ³w got&_o.wce ³   wydatki  ³   wydatki  ³           ³])
      mon_drk([           ³towar.i us&_l..³           ³   (7+8)    ³wg cen zakup³          ³i w natur.³            ³   (12+13)  ³           ³])
      mon_drk([           ³    (7)     ³    (8)    ³    (9)     ³    (10)    ³   (11)   ³   (12)   ³    (13)    ³    (14)    ³   (15)    ³])
      mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´])
      store 0 to s0_2,s0_3,s0_4,s0_5,s0_6,s0_8,s0_9,s0_10,s0_11
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa=.t.

      if nr_uzytk=108
         do nsvdanemc1
      endif

      sele suma_mc
      do while .not.&_koniec
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k1=miesiac(val(mc))
         k2=wyr_tow
         k3=uslugi
         k4=k2+k3
         k5=zakup
         k6=uboczne
         k8=wynagr_g
         k9=wydatki
         k10=k8+k9
         k11=pusta

         if nr_uzytk=108
            do nsvdanemc2
         endif

         sele suma_mc

         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         s0_2=s0_2+k2
         s0_3=s0_3+k3
         s0_4=s0_4+k4
         s0_5=s0_5+k5
         s0_6=s0_6+k6
         s0_8=s0_8+k8
         s0_9=s0_9+k9
         s0_10=s0_10+k10
         s0_11=s0_11+k11
         kprzych=k4
         krozch=k5+k6+k10
         ksaldo=k4-(k5+k6+k10)
         k2 =tran(k2 ,'@EZ 999999999.99')
         k3 =tran(k3 ,'@EZ 99999999.99')
         k4 =tran(k4 ,'@EZ 999999999.99')
         k5 =tran(k5 ,'@EZ 999999999.99')
         k6 =tran(k6 ,'@EZ 9999999.99')
         k8 =tran(k8 ,'@EZ 9999999.99')
         k9 =tran(k9 ,'@EZ 999999999.99')
         k10=tran(k10,'@EZ 999999999.99')
         k11=tran(k11,'@EZ 99999999.99')
         mon_drk(k1+[³]+k2+[³]+k3+[³]+k4+[³]+k5+[³]+k6+[³]+k8+[³]+k9+[³]+k10+[³]+k11+[³])
         mon_drk([           ³            ³           ³+]+tran(kprzych,'@EZ 99999999.99')+[³            ³          ³          ³            ³-]+tran(krozch,'@EZ 99999999.99')+[³=]+tran(ksaldo,'@EZ 9999999.99')+[³])
         mon_drk([           ³            ³           ³            ³            ³          ³          ³            ³            ³           ³])
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=0
         do case
         endcase
         _grupa=.f.
      enddo
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´])
      kprzych=s0_4
      krozch=s0_5+s0_6+s0_10
      ksaldo=s0_4-(s0_5+s0_6+s0_10)
      l2 =tran(s0_2 ,'@E 999999999.99')
      l3 =tran(s0_3 ,'@E 99999999.99')
      l4 =tran(s0_4 ,'@E 999999999.99')
      l5 =tran(s0_5 ,'@E 999999999.99')
      l6 =tran(s0_6 ,'@E 9999999.99')
      l8 =tran(s0_8 ,'@E 9999999.99')
      l9 =tran(s0_9 ,'@E 999999999.99')
      l10=tran(s0_10,'@E 999999999.99')
      l11=tran(s0_11,'@E 99999999.99')
      mon_drk([R A Z E M  ³]+l2+[³]+l3+[³]+l4+[³]+l5+[³]+l6+[³]+l8+[³]+l9+[³]+l10+[³]+l11+[³])
      mon_drk([           ³            ³           ³+]+tran(kprzych,'@EZ 99999999.99')+[³            ³          ³          ³            ³-]+tran(krozch,'@EZ 99999999.99')+[³=]+tran(ksaldo,'@EZ 9999999.99')+[³])
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([þ])

      if nr_uzytk=108
         do nsvdanemc3
      endif

   ENDIF

   END

   IF _czy_close
      close_()
   ENDIF

   RETURN NIL

****************************
proc NSVDANEMC1
****************************
//tworzenie bazy roboczej

_konc_=substr(param_rok,3,2)
_plik_='MCDOCH'+_konc_

      if file(_plik_+'.dbf')=.f.
         dbcreate(_plik_,{;
                 {"NIPFIRMY", "C", 10, 0},;
                 {"NIPPODAT", "C", 10, 0},;
                 {"MC",       "N",  2, 0},;
                 {"SPRZEDAZ", "N", 15, 2},;
                 {"SPRINNE",  "N", 15, 2},;
                 {"PRZYCHODY","N", 15, 2},;
                 {"TOWARY",   "N", 15, 2},;
                 {"UBOCZNE",  "N", 15, 2},;
                 {"ZAKUPY",   "N", 15, 2},;
                 {"WYPLATY",  "N", 15, 2},;
                 {"KOSZTY",   "N", 15, 2},;
                 {"ROZCHODY", "N", 15, 2},;
                 {"PUSTA",    "N", 15, 2},;
                 {"DATAAKT",  "D",  8, 0}})
      endif
      select 11
      if dostepex(_plik_)
         index on nipfirmy+nippodat+str(mc) to &_plik_
         go top
      endif
****************************
proc NSVDANEMC2
****************************
//tworzenie bazy roboczej

_konc_=substr(param_rok,3,2)
_plik_='MCDOCH'+_konc_
      select 11
         if len(alltrim(strtran(firma->nip,'-','')))=10
            seek alltrim(strtran(firma->nip,'-',''))+alltrim(strtran(firma->nip,'-',''))+suma_mc->mc
            if found()
               repl SPRZEDAZ with k2,SPRINNE with k3,PRZYCHODY with k4,;
                    TOWARY with k5,UBOCZNE with k6,ZAKUPY with k5+k6,;
                    WYPLATY with k8,KOSZTY with k9,ROZCHODY with k10,;
                    PUSTA with k11,;
                    DATAAKT with date()
            else
               appe blan
               repl NIPFIRMY with alltrim(strtran(firma->nip,'-','')),NIPPODAT with alltrim(strtran(firma->nip,'-','')),;
                    MC with val(suma_mc->mc)
               repl SPRZEDAZ with k2,SPRINNE with k3,PRZYCHODY with k4,;
                    TOWARY with k5,UBOCZNE with k6,ZAKUPY with k5+k6,;
                    WYPLATY with k8,KOSZTY with k9,ROZCHODY with k10,;
                    PUSTA with k11,;
                    DATAAKT with date()
            endif
         endif
****************************
proc NSVDANEMC3
****************************
_konc_=substr(param_rok,3,2)
_plik_='MCDOCH'+_konc_

      select 11
      go top
      copy to &_plik_ all delimited
      use
****************************
