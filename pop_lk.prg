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

para mcpop

   ***************************************************
   *** Wyliczenie podatku do poprzedniego miesiaca ***
   ***************************************************
   MMM=miesiac
   miesiac_=mcpop
   *-----remanenty-----
if miesiac>' 1'
   miesiac_=str(val(miesiac_)-1,2)
   select oper
   seek [+]+ident_fir+miesiac_+chr(254)
   fou=found()
   pz_m=iif(fou,ZAKUP+UBOCZNE+REKLAMA+WYNAGR_G+WYDATKI,0)
   store 0 to prem,prem_
   for i=val(miesiac_) to val(mc_rozp) step -1
       seek [+]+ident_fir+str(i,2)+chr(1)
       if found()
          if fou
             zm=[udz]+ltrim(str(i))
             prem=prem+ZAKUP+UBOCZNE+REKLAMA+WYNAGR_G+WYDATKI-pz_m
             prem_=prem_+(ZAKUP+UBOCZNE+REKLAMA+WYNAGR_G+WYDATKI-pz_m)*val(left(&zm ,3))/val(right(&zm ,3))
          endif
          pz_m=ZAKUP+UBOCZNE+REKLAMA+WYNAGR_G+WYDATKI
          if i>val(mc_rozp)
             seek [+]+ident_fir+str(i-1,2)+chr(254)
             pz_m=iif(found(),ZAKUP+UBOCZNE+REKLAMA+WYNAGR_G+WYDATKI,pz_m)
          endif
          fou=.t.
       endif
   next
   *-------------------
   select suma_mc
   seek [+]+ident_fir+mc_rozp
   pprzychod=0
   pkoszty=prem_
   do while del=[+].and.firma=ident_fir.and.mc<=miesiac_
      zm=[udz]+ltrim(mc)
      pprzychod=pprzychod+_round((WYR_TOW+USLUGI)*val(left(&zm ,3))/val(right(&zm ,3)),2)
      pkoszty=pkoszty+_round((ZAKUP+UBOCZNE+REKLAMA+WYNAGR_G+WYDATKI)*val(left(&zm ,3))/val(right(&zm ,3)),2)
      skip
   enddo
   select spolka
*  pk1=_round(pprzychod,2)
*  pk2=_round(pkoszty,2)
   pk1=pprzychod
   pk2=pkoszty
   pk3=max(0,pprzychod-pkoszty)
   pk4=abs(min(0,pprzychod-pkoszty))
   *****************************************************************************
   zident=str(recno(),5)
   select dane_mc
   seek [+]+zident+mc_rozp
   store 0 to pprzygos1,pprzygos2,pprzygos3,pprzygos4
   store 0 to pprzygos
   store 0 to pkoszgos1,pkoszgos2,pkoszgos3,pkoszgos4
   store 0 to pkoszgos
   store 0 to pdochody,pwydatki,pzaliczki,pzaliczkip,pzodseodmaj
   store 0 to pzpit566,pzpit567,pzpit5104,pzpit5105,pstraty,ppowodz
   store 0 to ppit5agosk,ppit5agosp,ppit5agoss
   store 0 to prop1_doch,prop1_stra,prop2_doch,prop2_stra
   store 0 to prop3_doch,prop3_stra,prop4_doch,prop4_stra
   store 0 to prop5_doch,prop5_stra
   store 0 to zg21,zh385,psumzdro,psumzdro1,sumzdroodl
   do while del=[+].and.ident=zident.and.mc<=miesiac_
      pprzygos1=pprzygos1+g_przych1
      pprzygos2=pprzygos2+g_przych2
      pprzygos3=pprzygos3+g_przych3
      pprzygos4=pprzygos4+g_przych4
      pkoszgos1=pkoszgos1+g_koszty1
      pkoszgos2=pkoszgos2+g_koszty2
      pkoszgos3=pkoszgos3+g_koszty3
      pkoszgos4=pkoszgos4+g_koszty4
      PSTRATY=PSTRATY+straty
      PPOWODZ=PPOWODZ+powodz

      PWYDATKI=PWYDATKI+skladki+skladkiw

      zg21=zg21+g21
      zh385=zh385+h385
      psumzdro=psumzdro+zdrowie+zdrowiew

      pzaliczki=pzaliczki+zaliczka
      if val(mc)<=val(miesiac_)-3
         pzaliczkip=pzaliczkip+zaliczkap
      endif

*   if zPITOKRES='K'
      do case
      case pitKW=1 .and. val(mc)>=1 .and. val(mc)<=3
           pzpit5105=pzpit5105+pit5105
           pzodseodmaj=pzodseodmaj+odseodmaj
      case pitKW=2 .and. val(mc)>=4 .and. val(mc)<=6
           pzpit5105=pzpit5105+pit5105
           pzodseodmaj=pzodseodmaj+odseodmaj
      case pitKW=3 .and. val(mc)>=7 .and. val(mc)<=9
           pzpit5105=pzpit5105+pit5105
           pzodseodmaj=pzodseodmaj+odseodmaj
      case pitKW=4 .and. val(mc)>=10 .and. val(mc)<=12
           pzpit5105=pzpit5105+pit5105
           pzodseodmaj=pzodseodmaj+odseodmaj
      endcase
*   else
*      pzpit5105=pit5105
*      pzodseodmaj=odseodmaj
*   endif

*      pzpit5105=pzpit5105+pit5105
      ppit5agosk=ppit5agosk+pit5agosk
      ppit5agosp=ppit5agosp+pit5agosp
      skip
   enddo
   select spolka
   *------------------------------------

   if miesiac=mcpop

   preman=pzpit5105
   pdochgos1=max(0,pprzygos1-pkoszgos1)
   pdochgos2=max(0,pprzygos2-pkoszgos2)
   pdochgos3=max(0,pprzygos3-pkoszgos3)
   pdochgos4=max(0,pprzygos4-pkoszgos4)
   pzpit566=max(0,ppit5agosp-ppit5agosk)

   pstragos1=abs(min(0,pprzygos1-pkoszgos1))
   pstragos2=abs(min(0,pprzygos2-pkoszgos2))
   pstragos3=abs(min(0,pprzygos3-pkoszgos3))
   pstragos4=abs(min(0,pprzygos4-pkoszgos4))
   ppit5agoss=max(0,ppit5agosk-ppit5agosp)

   gosprzy=pprzygos1+pprzygos2+pprzygos3+pprzygos4+ppit5agosp+pk1
   goskosz=pkoszgos1+pkoszgos2+pkoszgos3+pkoszgos4+ppit5agosk+pk2

   gosdoch=max(0,gosprzy-goskosz)
   gosstra=max(0,goskosz-gosprzy)

   prod1_doch=pdochgos1+pdochgos2+pdochgos3+pdochgos4+pk3+pzpit566
   prod1_stra=pstragos1+pstragos2+pstragos3+pstragos4+pk4+ppit5agoss

***pk5=p47 - DOCHODY
   pk5=gosdoch

***pkk7=p50 - DOCHOD po odliczeniu dochodu zwolnionego
   p51=PSTRATY+ppowodz

   if P51>pk5
      P51=pk5
      PWYDATKI=0
   else
      if P51+PWYDATKI>pk5
         PWYDATKI=pk5-P51
      endif
   endif

   PKK7=pk5-(P51+PWYDATKI)

***pk6=dochod po odliczeniach

*  pk6=max(0,pkk7-pwydatki)

***pk75=p775 odliczenia od podatku
   pk75=zg21

   pk7=0
***pk7=p770 - podstawa
   if gosdoch>0
      pk7=pkk7+pk75
   else
      if gosdoch=0.and.(gosstra<pk75.or.gosstra=0)
         pk7=pk75-gosstra
      endif
   endif
   pk7=_round(pk7,0)

*   pk7=pkk7-pk6

   ppodst=pk7
   *--------------- podatek dochodowy wg tabeli
*   select tab_doch
*   go top
   ppodatek=0
   pzm=ppodst
   ppodatek=pzm*(param_lin/100)
   select spolka
   ppodatek=max(0,ppodatek)
   *---------------
   pk8=ppodatek

   sumzdroodl=min(pk8,psumzdro)
   psumzdro1=max(0,pk8-sumzdroodl)

*******************************************
*  Nowe zaokraglenia w 2006 roku
*  pk12=_round(P97MMM,1)
*  pk13=_round(max(0,psumzdro1-pk12),1)
*  P97MMM=pk12+pk13
*******************************************
   pk12=P97MMM
   pk13=_round(max(0,psumzdro1-pk12),0)
   P97MMM=pk12+pk13

   P887MMMa=P887MMMa+P887MMM
   P887MMM=_round(min(pk13,zh385-P887MMMa),1)

*   wartprzek_=0
*   do case
*   case miesiac='11'
*        if zPITOKRES='M'
*           wartprzek_=(pk13*2)+preman+pzodseodmaj-P887MMM
*        else
*           wartprzek_=pk13+preman+pzodseodmaj-P887MMM
*        endif
*   other
        wartprzek_=pk13-pzaliczkip
*        wartprzek_=pk13+preman+pzodseodmaj-P887MMM
*   endcase

   if val(miesiac_)<12
      sele dane_mc
      recdmc=recno()
      seek '+'+zident+str(val(miesiac_)-2,2)
      if del='+' .and. ident=zident .and. mc=str(val(miesiac_)-2,2)
         do blokadar
         repl zaliczkap with 0
         unlock
      endif
      seek '+'+zident+str(val(miesiac_)-1,2)
      if del='+' .and. ident=zident .and. mc=str(val(miesiac_)-1,2)
         do blokadar
         repl zaliczkap with 0
         unlock
      endif
      seek '+'+zident+miesiac_
      if del='+' .and. ident=zident .and. mc=miesiac_
         do blokadar
         repl zaliczkap with wartprzek_
         unlock
      endif

*      seek '+'+zident+MMM
*      if del='+' .and. ident=zident .and. mc=MMM
*         do blokadar
*         if zPITOKRES='M'
*            repl zaliczkap with wartprzek_
*         else
*            repl zaliczkap with 0
*         endif
*         unlock
*      endif

      go recdmc
   endif

   endif

else
   P97MMM=0
   P887MMM=0
endif
*   miesiac=MMM
   ***************************************************
   *** KONIEC wyliczenia podatku z poprz. miesiaca ***
   ***************************************************
