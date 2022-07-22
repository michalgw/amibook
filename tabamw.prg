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

PROCEDURE TabAmWTxt()

private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
zid=str(rec_no,5)
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=128
      _strona=.t.
      _czy_mon=.t.
      _czy_close=.f.
      *------------------------------
      _szerokosc=128
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      czesc=1
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      vZBYLIK='likwidac.'
      sele kartst
      if len(alltrim(dtos(DATA_LIK)))=8
         if len(alltrim(dtos(DATA_SPRZ)))=8
            vZBYLIK=' zbycia  '
         else
            vZBYLIK='likwidac.'
         endif
      endif
      mon_drk([ö]+procname())
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk(padc([TABELA AMORTYZACJI &__S.RODKA TRWA&_L.EGO       FIRMA: ]+SYMBOL_FIR,128))
      mon_drk([ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³   Data  ³  Numer   ³                  Nazwa                 ³   Dow&_o.d  ³        ³Stawka³ Spos&_o.b ³Mno&_z.³     Cena    ³  Data   ³])
      mon_drk([³przyj&_e.cia³ewidencyj.³             &_s.rodka trwa&_l.ego            ³  zakupu  ³  KST   ³  %%  ³umorzen.³DEGR³    zakupu   ³]+vZBYLIK+[³])
      mon_drk([ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ])
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa=.t.
      *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
      k1=dtoc(data_zak)
      k2=krst
      k3=nrewid
      K4=nazwa
      K5=dowod_zak
      K7=str(stawka,6,2)
      K8=iif(sposob='L','Liniowo ',iif(sposob='J','Jednoraz','Degresyw'))
      K9=str(wspdeg,4,2)
      K10=transform(wartosc,'@E 999999999.99')
      K11=dtoc(data_lik)
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk(k1+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k2+[ ]+k7+[ ]+k8+[ ]+k9+[  ]+k10+[ ]+k11)
      mon_drk(repl([Ä],128))
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _koniec="del#[+].or.ident#zid"
      zid=str(rec_no,5)
      sele AMORT
      seek '+'+zid
      if found()
         startrok=rok
         do while .not.&_koniec
            endrok=rok
            skip
         enddo
         ilam=val(endrok)-val(startrok)
         for x=0 to 6
             seek '+'+zid+str(val(startrok)+(x*7),4)
             if found()
                k7=padr('Rok',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=padc(ROK,14)
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Warto&_s.&_c. pocz&_a.tkowa',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(WART_POCZ,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Mno&_z.nik aktualizac.',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(PRZEL,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Warto&_s.&_c. modyfikacji ',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(WART_MOD,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Warto&_s.&_c. pocz.aktual.',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(WART_AKT,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Umorzenie po aktual.',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(UMORZ_AKT,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Roczny odpis liniowo',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(LINIOWO,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Roczny odpis degres.',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(DEGRES,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                mon_drk([])
                sele AMORT
                for mmm=1 to 12
                    mmn=strtran(str(mmm,2),' ','0')
                    k7=padr(miesiac(mmm),20)
                    for y=0 to 6
                        seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                        zm=str(y,1)
                        if found()
                           k&zm=transform(MC&MMN,'@EZ 999 999 999.99')
                        else
                           k&zm=space(14)
                        endif
                    next
                    mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                    sele AMORT
                next
                k7=padr('Odpis za rok',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(ODPIS_ROK,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk([])
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Odpis narastaj&_a.co',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(ODPIS_SUM,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                mon_drk(repl([Ä],128))
                sele AMORT
             endif
         next
         sele KARTSTMO
         seek [+]+zid
         if found().and.[+]+zid==A->del+str(A->rec_no,5).and..not.eof()
            mon_drk([Zmiany wartosci srodka trwalego:])
            sele KARTSTMO
            do while del+ident==[+]+zid.and..not.eof()
               zDATA_MOD=DATA_MOD
               zWART_MOD=WART_MOD
               zOPIS_MOD=OPIS_MOD
               mon_drk('Dnia '+transform(zDATA_MOD,'@D')+' na kwote '+str(zWART_MOD,9,2)+' z tytulu '+zOPIS_MOD)
               sele KARTSTMO
               skip
            enddo
         endif
         sele kartst
         if len(alltrim(dtos(DATA_LIK)))=8
            vROK_LIK=substr(dtos(DATA_LIK),1,4)
            sele AMORT
            seek '+'+zid+vROK_LIK
            vWART_AKT=WART_AKT
            vODPIS_SUM=ODPIS_SUM
            sele kartst
            if len(alltrim(dtos(DATA_SPRZ)))=8
* sprzedaz
               mon_drk([&__S.rodek trwa&_l.y zosta&_l. zbyty dnia........]+dtoc(DATA_SPRZ)+[   Warto&_s.&_c. &_s.rodka nierozliczona ratami: ]+str(vWART_AKT-vODPIS_SUM,12,2))
            else
               mon_drk([&__S.rodek trwa&_l.y zosta&_l. zlikwidowany dnia.]+dtoc(DATA_LIK)+[   Warto&_s.&_c. &_s.rodka nierozliczona ratami: ]+str(vWART_AKT-vODPIS_SUM,12,2))
            endif
         endif
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([])
      mon_drk([                     U&_z.ytkownik programu komputerowego])
      mon_drk([             ]+dos_c(code()))
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([þ])
end
if _czy_close
   close_()
endif
sele KARTST
set orde to 2
seek val(ZID)
set orde to 1

   RETURN NIL

PROCEDURE TabAmWGr()

   LOCAL aDane, nRokPocz, nRokKon, nI, nJ, nR, cR, aRok, aMod

   aDane := { ;
      'lata' => {}, ;
      'modyfikacje' => {}, ;
      'Firma'       => AllTrim( symbol_fir ), ;
      'uzytkownik'  => AllTrim( code() ), ;
      'DataZak'     => kartst->data_zak, ;
      'krst'        => AllTrim( kartst->krst ), ;
      'NrEwid'      => AllTrim( kartst->nrewid ), ;
      'Nazwa'       => AllTrim( kartst->nazwa ), ;
      'DowodZak'    => AllTrim( kartst->dowod_zak ), ;
      'Stawka'      => kartst->stawka, ;
      'Sposob'      => iif( kartst->sposob == 'L', 'Liniowo', iif( kartst->sposob =='J', 'Jednorazowo', 'Degresywnie' ) ), ;
      'WspDeg'      => kartst->wspdeg, ;
      'Wartosc'     => kartst->wartosc, ;
      'DataLik'     => iif( Empty( kartst->data_lik ), '', kartst->data_lik ), ;
      'DataZby'     => iif( Empty( kartst->data_sprz ), '', kartst->data_sprz ), ;
      'DataL'       => '', ;
      'RodzL'       => '', ;
      'WartAkt'     => 0, ;
      'OdpisSum'    => 0, ;
      'JestLikw'    => 0, ;
      'LikwTekst'   => '' }

   IF ! Empty( kartst->data_lik )
      aDane[ 'JestLikw' ] := 1
      IF ! Empty( kartst->data_sprz )
         aDane[ 'DataL' ] := kartst->data_sprz
         aDane[ 'RodzL' ] := 'Zbycie'
         aDane[ 'LikwTekst' ] := 'zbyty'
      ELSE
         aDane[ 'DataL' ] := kartst->data_lik
         aDane[ 'RodzL' ] := 'Likwidacja'
         aDane[ 'LikwTekst' ] := 'zlikwidowany'
      ENDIF
   ENDIF

   IF amort->( dbSeek( '+' + Str( kartst->rec_no, 5 ) ) )
      nRokPocz := Val( amort->rok )
      DO WHILE amort->del == '+' .AND. amort->ident == Str( kartst->rec_no, 5 ) .AND. ! amort->( Eof() )
         nRokKon := Val( amort->rok )
         amort->( dbSkip() )
      ENDDO
      nI := 1
      nR := nRokPocz
      amort->( dbSeek( '+' + Str( kartst->rec_no, 5 ) ) )
      DO WHILE amort->del == '+' .AND. amort->ident == Str( kartst->rec_no, 5 ) .AND. ! amort->( Eof() )
         IF nI == 1
            aRok := { => }
            FOR nJ := 1 TO 7
               cR := Str( nJ, 1 )
               aRok[ 'Rok' + cR ] := 0
               aRok[ 'Wartosc' + cR ] := 0
               aRok[ 'Mnoznik' + cR ] := 0
               aRok[ 'WartMod' + cR ] := 0
               aRok[ 'WartPoMod' + cR ] := 0
               aRok[ 'UmorzPoMod' + cR ] := 0
               aRok[ 'OdpL' + cR ] := 0
               aRok[ 'OdpD' + cR ] := 0
               aRok[ 'm01' + cR ] := 0
               aRok[ 'm02' + cR ] := 0
               aRok[ 'm03' + cR ] := 0
               aRok[ 'm04' + cR ] := 0
               aRok[ 'm05' + cR ] := 0
               aRok[ 'm06' + cR ] := 0
               aRok[ 'm07' + cR ] := 0
               aRok[ 'm08' + cR ] := 0
               aRok[ 'm09' + cR ] := 0
               aRok[ 'm10' + cR ] := 0
               aRok[ 'm11' + cR ] := 0
               aRok[ 'm12' + cR ] := 0
               aRok[ 'OdpisR' + cR ] := 0
               aRok[ 'OdpisN' + cR ] := 0
            NEXT
            AAdd( aDane[ 'lata' ], aRok )
         ENDIF

         cR := Str( nI, 1 )
         aRok[ 'Rok' + cR ] := Val( amort->rok )
         aRok[ 'Wartosc' + cR ] := amort->wart_pocz
         aRok[ 'Mnoznik' + cR ] := amort->przel
         aRok[ 'WartMod' + cR ] := amort->wart_mod
         aRok[ 'WartPoMod' + cR ] := amort->wart_akt
         aRok[ 'UmorzPoMod' + cR ] := amort->umorz_akt
         aRok[ 'OdpL' + cR ] := amort->liniowo
         aRok[ 'OdpD' + cR ] := amort->degres
         aRok[ 'm01' + cR ] := amort->mc01
         aRok[ 'm02' + cR ] := amort->mc02
         aRok[ 'm03' + cR ] := amort->mc03
         aRok[ 'm04' + cR ] := amort->mc04
         aRok[ 'm05' + cR ] := amort->mc05
         aRok[ 'm06' + cR ] := amort->mc06
         aRok[ 'm07' + cR ] := amort->mc07
         aRok[ 'm08' + cR ] := amort->mc08
         aRok[ 'm09' + cR ] := amort->mc09
         aRok[ 'm10' + cR ] := amort->mc10
         aRok[ 'm11' + cR ] := amort->mc11
         aRok[ 'm12' + cR ] := amort->mc12
         aRok[ 'OdpisR' + cR ] := amort->odpis_rok
         aRok[ 'OdpisN' + cR ] := amort->odpis_sum

         IF nR == nRokKon
            aDane[ 'WartAkt' ] := amort->wart_akt
            aDane[ 'OdpisSum' ] := amort->odpis_sum
         ENDIF

         nI++
         nR++
         IF nI > 7
            nI := 1
         ENDIF
         amort->( dbSkip() )
      ENDDO
   ENDIF

   IF kartstmo->( dbSeek( '+' + Str( kartst->rec_no, 5 ) ) )
      DO WHILE kartstmo->del == '+' .AND. kartstmo->ident == Str( kartst->rec_no, 5 ) .AND. ! kartstmo->( Eof() )
         aMod := { ;
            'DataMod' => kartstmo->data_mod, ;
            'WartMod' => kartstmo->wart_mod, ;
            'OpisMod' => AllTrim( kartstmo->opis_mod ) }
         AAdd( aDane[ 'modyfikacje' ], aMod )
         kartstmo->( dbSkip() )
      ENDDO
   ENDIF

   FRDrukuj( 'frf\sttabam.frf', aDane )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE TabAmW()

   SWITCH GraficznyCzyTekst( "TabAmW" )
   CASE 1
      TabAmWGr()
      EXIT
   CASE 2
      TabAmWTxt()
      EXIT
   ENDSWITCH

   RETURN NIL

/*----------------------------------------------------------------------*/
