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

* max 999 firm

PROCEDURE Firma1()

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

   private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
   @ 1,47 say [          ]
   public symbol_fir,ident_fir
   * ,VAT,DETALISTA,RYCZALT
   *################################# GRAFIKA ##################################
   @  3,42 say [ÉÍÍÍÍÍÍÍÍÍÍPe&_l.na nazwa firmyÍÍÍÍÍÍÍÍÍ»]
   @  4,42 say [º   ..............................   º]
   @  5,42 say [º   ..............................   º]
   @  6,42 say [ÌÍÍSYMBOLÍÍËÍÍÍÍÍÍÍÍMiejscowo&_s.&_c.ÍÍÍÍÍÍ¼]
   @  7,42 say [º          º  ³ .................... ³]
   @  8,42 say [º          º  ÃÄÄÄDzielnica/GminaÄÄÄÄ´]
   @  9,42 say [º          º  ³ .................... ³]
   @ 10,42 say [º          º  ÃÄÄÄÄÄÄÄÄUlicaÄÄÄÄÄÄÄÄÄ´]
   @ 11,42 say [º          º  ³ .................... ³]
   @ 12,42 say [º          º  ÃÄÄNr domuÄÄÄNr mieszkÄ´]
   @ 13,42 say [º          º  ³   .....       .....  ³]
   @ 14,42 say [º          º  ÃKod pocztÄÄÄÄPocztaÄÄÄ´]
   @ 15,42 say [º          º  ³...... ...............³]
   @ 16,42 say [º          º  ÃÄÄÄTelÄÄÄÄÄÄÄÄÄFaxÄÄÄÄ´]
   @ 17,42 say [º          º  ³..........  ..........³]
   @ 18,42 say [º          º  ÃÄÄÄKrajÄÄÄÄÄÄÄSp&_o.&_l.kaÄÄ´]
   @ 19,42 say [º          º  ³..........     ...    ³]
   @ 20,42 say [º          º  ÃÄÄÄData rozpocz&_e.ciaÄÄÄ´]
   @ 21,42 say [ÈÍÍÍÍÍÍÍÍÍÍ¼  ³     dzia&_l.alno&_s.ci     ³]
   @ 22,42 say [              ³      ..........      ³]
   @ 23,42 say [              ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ]
   *############################### OTWARCIE BAZ ###############################
   select 3
   if dostep('SPOLKA')
      set inde TO spolka
   else
      close_()

      return
   endif
   select 2
   if dostep('SUMA_MC')
      set inde to suma_mc
   else
      close_()

      return
   endif
   select 1
   if dostep('FIRMA')
      set inde to firma
   else
      close_()
      return
   endif
   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g=7
   _col_l=43
   _row_d=20
   _col_p=52
   _invers=[i]
   _curs_l=0
   _curs_p=0
   _esc=[27,-9,247,22,48,77,109,7,46,28,13,1006,75,107]
   _top=[.f.]
   _bot=[del#'+']
   _stop=[]
   _sbot=[-]
   _proc=[linia10()]
   _row=int((_row_g+_row_d)/2)
   _proc_spe=[firma_]
   _disp=.t.
   _cls=''
   *----------------------
   kl=0
   do while kl#27
      ColSta()
      @ 1,47 say '[F1]-pomoc'
      set color to
      _row=wybor(_row)
      ColStd()
      kl=lastkey()
      do case
      *############################ INSERT/MODYFIKACJA ############################
      case kl=22.or.kl=48.or._row=-1.or.kl=77.or.kl=109
         @ 1,47 say [          ]
         ins=kl#77.and.kl#109
         if ins
            ColStb()
            center(23,[ş                     ş])
            ColSta()
            center(23,[W P I S Y W A N I E])
            ColStd()
            restscreen(_row_g,_col_l,_row_d+1,_col_p,_cls)
            wiersz=_row_d
         else
            ColStb()
            center(23,[ş                       ş])
            ColSta()
            center(23,[M O D Y F I K A C J A])
            ColStd()
            wiersz=_row
         endif
         do while .t.
            *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ ZMIENNE ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ
            if ins
               zsymbol=space(10)
               znazwa=space(60)
               zmiejsc=space(20)
               zgmina=space(20)
               zulica=space(20)
               znr_domu=space(5)
               znr_mieszk=space(5)
               zkod_p=space(6)
               zpoczta=space(20)
               ztel=space(10)
               zfax=space(10)
               ztlx=space(10)
               zdata_zal=ctod('    .  .  ')
               zspolka='N'
            else
               zsymbol=symbol
               znazwa=nazwa
               zmiejsc=miejsc
               zgmina=gmina
               zulica=ulica
               znr_domu=nr_domu
               znr_mieszk=nr_mieszk
               zkod_p=kod_p
               zpoczta=poczta
               ztel=tel
               zfax=fax
               ztlx=tlx+space(10-len(alltrim(tlx)))
               zdata_zal=data_zal
               zspolka=iif(spolka,'T','N')
            endif
            *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ GET ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ
            @  4,43 clear to 5,78
            ColStd()
            @ wiersz,43 get zsymbol picture repl("!",10) valid v10_1()
            @  4,43 get znazwa picture '@S36 '+repl("!",60)
            @  7,58 get zmiejsc picture repl("!",20)
            @  9,58 get zgmina picture  repl("!",20)
            @ 11,58 get zulica picture  repl("!",20)
            @ 13,60 get znr_domu picture [!!!!!]
            @ 13,72 get znr_mieszk picture [!!!!!]
            @ 15,57 get zkod_p picture [99-999]
            @ 15,64 get zpoczta picture '@S15 '+repl('!',20)
            @ 17,57 get ztel picture [!!!!!!!!!!]
            @ 17,69 get zfax picture [!!!!!!!!!!]
            @ 19,57 get ztlx picture [!!!!!!!!!!]
            @ 19,72 get zspolka picture [!] when w3_1321() valid v3_1321()
            @ 22,63 get zdata_zal picture [@D 9999.99.99]
            read_()
            if lastkey()=27
               exit
            endif
            zsymbol=dos_l(zsymbol)
            *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ REPL ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ
            if ins
               app()
               zero_(3)
               repl_([nr_fakt],1)
               repl_([nr_faktw],1)
               repl_([nr_rach],1)
               repl_([liczba],1)
               repl_([liczba_wyp],1)
               repl_( "RODZNRKS", "R" )
               repl_( "RODZAJDRFV", "G" )
            endif
            do BLOKADAR
            repl_([symbol],zsymbol)
            repl_([NAZWA    ],zNAZWA)
            repl_([MIEJSC   ],zMIEJSC   )
            repl_([GMINA    ],zGMINA    )
            repl_([ULICA    ],zULICA    )
            repl_([NR_DOMU  ],zNR_DOMU  )
            repl_([NR_MIESZK],zNR_MIESZK)
            repl_([KOD_P    ],zKOD_P    )
            repl_([POCZTA   ],zPOCZTA   )
            repl_([TEL      ],zTEL      )
            repl_([FAX      ],zFAX      )
            repl_([TLX      ],zTLX      )
            repl_([DATA_ZAL ],zDATA_ZAL )
            repl_([SPOLKA   ],iif(zspolka='T',.t.,.f.))
            COMMIT
            unlock
            ident=str(recno(),3)
            select suma_mc
            if ins
               for i=1 to 12
                  app()
                  repl_([firma],ident)
                  repl_([mc],str(i,2))
                  zero_(5)
                  COMMIT
                  unlock
               next
            endif
            select firma
            commit_()
            *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ
            _row=int((_row_g+_row_d)/2)
            if .not.ins
               exit
            endif
            @ _row_d,_col_l say &_proc
            scroll(_row_g,_col_l,_row_d,_col_p,1)
            @ _row_d,_col_l say [        ]
         enddo
         _disp=ins.or.lastkey()#27
         kl=iif(lastkey()=27.and._row=-1,27,kl)
         @ 23,0 say space(56)
      *################################ KASOWANIE #################################
      case kl=7.or.kl=46
         ColSta()
         @ 1,47 say [          ]
         ColStb()
         center(23,[ş                   ş])
         ColSta()
         center(23,[K A S O W A N I E])
         ColStd()
         begin sequence
            if .not.tnesc([*i],[ UWAGA! Informacje firmy ]+rtrim(symbol)+[ zostan&_a. zniszczone - czy skasowa&_c.? (T/N) ])
            break
            endif
            jestespewien := "   "
            ColErr()
            @ 24, 0
            @ 24, 25 SAY 'Jeste˜ pewny? (wprowad« "TAK")' GET jestespewien PICTURE '!!!' VALID jestespewien == "TAK"
            READ
            ColStd()
            IF LastKey() == 23 .OR. jestespewien <> 'TAK'
               BREAK
            ENDIF
            //if .not.tnesc([*i],[   Jeste&_s. pewny? (T/N)   ])
            //break
            //endif
            do czekaj
            zident=str(recno(),3)
            *====================================
            select 100
            do while.not.dostep('NOTES')
            enddo
            do SETIND with 'NOTES'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               dele
               COMMIT
               unlock
               skip
            enddo
            select 100
            do while.not.dostep('OPER')
            enddo
            do SETIND with 'OPER'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo
            select 100
            do while.not.dostep('EWID')
            enddo
            do SETIND with 'EWID'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('DZIENNE')
            enddo
            do SETIND with 'DZIENNE'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               dele
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('KAT_ZAK')
            enddo
            do SETIND with 'KAT_ZAK'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               dele
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('KAT_SPR')
            enddo
            do SETIND with 'KAT_SPR'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               dele
               COMMIT
               unlock
               skip
            enddo

            select 100
            do while.not.dostep('REJS')
            enddo
            do SETIND with 'REJS'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               repl_([del],[-])
               COMMIT
               unlock
               seek [+]+zident
            enddo

            select 100
            do while.not.dostep('REJZ')
            enddo
            do SETIND with 'REJZ'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               repl_([del],[-])
               COMMIT
               unlock
               seek [+]+zident
            enddo

            select 101
            do while.not.dostep('DANE_MC')
            enddo
            set inde to dane_mc
            select 3
            //do while.not.dostep('SPOLKA')
            //enddo
            //do setind with 'SPOLKA'
            seek [+]+zident
            do while del=[+].and.firma=zident
               zm=str(recno(),5)
               select dane_mc
               seek [+]+zm
               do while del=[+].and.ident=zm
                  do BLOKADAR
                  del()
                  COMMIT
                  unlock
                  skip
               enddo
               select spolka
               do BLOKADAR
               repl_([del],[-])
               COMMIT
               unlock
               seek [+]+zident
            enddo

            select 104
            do while.not.dostep('PRAC_HZ')
            enddo
            do setind with 'PRAC_HZ'
            select 103
            do while.not.dostep('NIEOBEC')
            enddo
            do SETIND with 'NIEOBEC'
            select 102
            do while.not.dostep('ETATY')
            enddo
            do SETIND with 'ETATY'
            select 101
            do while.not.dostep('UMOWY')
            enddo
            do SETIND with 'UMOWY'
            select 100
            do while.not.dostep('PRAC')
            enddo
            do setind with 'PRAC'
            seek [+]+zident
            do while del=[+].and.firma=zident
               zm=str(rec_no,5)
               select umowy
               seek [+]+zm
               do while del=[+].and.ident=zm
                  do BLOKADAR
                  del()
                  COMMIT
                  unlock
                  skip
               enddo
               select etaty
               seek [+]+zident+zm
               do while del=[+].and.firma=zident.and.ident=zm
                  do BLOKADAR
                  del()
                  COMMIT
                  unlock
                  skip
               enddo
               select nieobec
               seek [+]+zident+zm
               do while del=[+].and.firma=zident.and.ident=zm
                  do BLOKADAR
                  del()
                  COMMIT
                  unlock
                  skip
               enddo
               select prac_hz
               seek [+]+zident+Str(prac->id,8)
               do while del=[+].and.firma=zident.and.pracid=prac->id
                  do BLOKADAR
                  del()
                  COMMIT
                  unlock
                  skip
               enddo
               select prac
               do BLOKADAR
               repl_([del],[-])
               COMMIT
               unlock
               seek [+]+zident
            enddo

            select 101
            do while.not.dostep('POZYCJE')
            enddo
            set inde to pozycje
            select 100
            do while.not.dostep('FAKTURY')
            enddo
            do SETIND with 'FAKTURY'
            seek [+]+zident
            do while del=[+].and.firma=zident
               zm=str(rec_no,8)
               select pozycje
               seek [+]+zm
               do while del=[+].and.ident=zm
                  do BLOKADAR
                  del()
                  COMMIT
                  unlock
                  skip
               enddo
               select faktury
               do BLOKADAR
               del()
               *repl_([del],[-])
               COMMIT
               unlock
               seek [+]+zident
            enddo

            select 101
            do while.not.dostep('POZYCJEW')
            enddo
            set inde to pozycjew
            select 100
            do while.not.dostep('FAKTURYW')
            enddo
            do SETIND with 'FAKTURYW'
            seek [+]+zident
            do while del=[+].and.firma=zident
               zm=str(rec_no,8)
               select pozycjew
               seek [+]+zm
               do while del=[+].and.ident=zm
                  do BLOKADAR
                  del()
                  COMMIT
                  unlock
                  skip
               enddo
               select fakturyw
               do BLOKADAR
               del()
               *repl_([del],[-])
               COMMIT
               unlock
               seek [+]+zident
            enddo

            select 102
            do while.not.dostep('KARTSTMO')
            enddo
            do SETIND with 'KARTSTMO'
            select 101
            do while.not.dostep('AMORT')
            enddo
            set inde to amort
            select 100
            do while.not.dostep('KARTST')
            enddo
            do SETIND with 'KARTST'
            seek [+]+zident
            do while del=[+].and.firma=zident
               zm=str(rec_no,5)
               select amort
               seek [+]+zm
               do while del=[+].and.ident=zm
                  do BLOKADAR
                  del()
                  COMMIT
                  unlock
                  skip
               enddo
               select kartstmo
               seek [+]+zm
               do while del=[+].and.ident=zm
                  do BLOKADAR
                  del()
                  COMMIT
                  unlock
                  skip
               enddo
               select kartst
               do BLOKADAR
               del()
               COMMIT
               unlock
               seek [+]+zident
            enddo

            do while.not.dostep('KONTR')
            enddo
            do setind with 'KONTR'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('TRESC')
            enddo
            set inde to tresc
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('WYPOSAZ')
            enddo
            set inde to wyposaz
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               dele
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('PRZELEWY')
            enddo
            do setind with 'PRZELEWY'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('PRZELPOD')
            enddo
            do setind with 'PRZELPOD'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('EWIDPOJ')
            enddo
            do setind with 'EWIDPOJ'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('RACHPOJ')
            enddo
            do setind with 'RACHPOJ'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('RELACJE')
            enddo
            do setind with 'RELACJE'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('SAMOCHOD')
            enddo
            do setind with 'SAMOCHOD'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('ROZR')
            enddo
            do setind with 'ROZR'
            seek zident
            do while firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            do while.not.dostep('DOWEW')
            enddo
            do setind with 'DOWEW'
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            *====================================
            select suma_mc
            seek [+]+zident
            do while del=[+].and.firma=zident
               do BLOKADAR
               del()
               COMMIT
               unlock
               skip
            enddo

            select firma
            skip
            _nrrr_rec=recno()
            skip -1
            do BLOKADAR
            repl_([del],[-])
            COMMIT
            unlock
            go _nrrr_rec
            if del#[+]
               skip -1
               if del#[+]
                  skip -1
               endif
            endif
            commit_()
            if &_bot
               skip -1
            endif
            _disp=.t.
         end
         @ 23,0 say space(56)
         @ 24,0
      *################################# SZUKANIE #################################
      case kl=-9.or.kl=247
         @ 1,47 say [          ]
         ColStb()
         center(23,[ş                 ş])
         ColSta()
         center(23,[S Z U K A N I E])
         f10=space(10)
         ColStd()
         @ _row,43 get f10 picture "!!!!!!!!!!"
         read_()
         _disp=.not.empty(f10).and.lastkey()#27
         if _disp
            seek [+]+dos_l(f10)
            if &_bot
               skip -1
            endif
         _row=int((_row_g+_row_d)/2)
         endif
         @ 23,0 say space(56)
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
         p[ 5]='   [Ins]...................wpisywanie                   '
         p[ 6]='   [M].....................modyfikacja pozycji          '
         p[ 7]='   [K].....................konwersja ryczaˆt <> PKPiR   '
         p[ 8]='   [Del]...................kasowanie pozycji            '
         p[ 9]='   [F10]...................szukanie                     '
         p[10]='   [Enter].................akceptacja firmy             '
         p[11]='   [Esc]...................wyj&_s.cie                      '
         p[12]='                                                        '
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

      *################################### EKSPORT ################################
      CASE kl == Asc( 'K' ) .OR. kl == Asc( 'k' )
         Firma_Konwertuj()

      *################################### WYBOR ##################################
      case kl=13 .OR. kl == 1006
         zhaslo=space(10)
         if .not.empty(haslo)
            Cocul=ColErr()
            @ 24,0 clear
            @ 24,28 say 'Podaj haslo:'
            set curs on
            set colo to X/X,X/X
            @ 24,40 get zhaslo
            read
            set curs off
            set colo to cocul
            @ 24,0 clear
         endif
         if haslo==zhaslo
            symbol_fir=symbol
            ident_fir=str(recno(),3)
            Firma_RodzNrKs := firma->rodznrks
            restore screen from scr
            ColSta()
            @ 0,41 say 'Alt+K=kalkul. Alt+N=notes'
            @ 0,67 say [Symbol firmy]
            set color to +w
            @ 1,66 say [  ]+dos_c(symbol_fir)+[  ]
            *ZVAT=VAT
            *ZVATOKRES=iif(VATOKRES='K','K','M')
            zVAT=iif(VAT=' ','N',VAT)
            zVATOKRES=iif(VATOKRES=' ','M',VATOKRES)
            zVATOKRESDR=VATOKRESDR
            if VATFORDR=='  '
               if zVATOKRES='M'
                  *if zVATOKRESDR='M'
                     zVATFORDR='7 '
                  *else
                     *zVATFORDR='7D'
                  *endif
               else
                  zVATFORDR='7K'
               endif
            else
               zVATFORDR=VATFORDR
            endif
            zUEOKRES=iif(UEOKRES='K','K','M')
            DETALISTA=DETAL
            ZRYCZALT=RYCZALT
            pzROZRZAPK=ROZRZAPK
            pzROZRZAPS=ROZRZAPS
            pzROZRZAPZ=ROZRZAPZ
            pzROZRZAPF=ROZRZAPF
            firma_rodzajdrfv := iif( rodzajdrfv $ 'GT', rodzajdrfv, 'T' )
            *m->parap_puw=parap_puw
            m->parap_fuw=parap_fuw
            m->parap_fww=parap_fww

            bufor_dok := { 'oper' => {}, 'rycz' => {}, 'rejs' => {}, 'rejz' => {}, 'faktury' => {}, 'faktury3' => {} }

            set color to
            @ 0,0 clear to 0,40
            @ 0,3 say iif(zVAT='T','VAT-'+zVATFORDR,'')+iif(zRYCZALT='T','Rycza&_l.t ','')+iif(DETALISTA='T','Detal ','')
            save screen to scr
            exit
         endif
      ******************** ENDCASE
      endcase
   enddo
   close_()

   RETURN NIL

*################################## FUNKCJE #################################
function linia10

   return symbol

***************************************************
procedure firma_
   LOCAL cRodz := ""

   @  4,43 clear to 5,78
   set color to +w
   @  4,46 say iif(empty(left(nazwa,30)),repl([.],30),dos_c(left(nazwa,30)))
   @  5,46 say iif(empty(right(nazwa,30)),repl([.],30),dos_c(right(nazwa,30)))
   @  7,58 say iif(empty(miejsc),repl([.],20),dos_c(miejsc))
   @  9,58 say iif(empty(gmina),repl([.],20),dos_c(gmina))
   @ 11,58 say iif(empty(ulica),repl([.],20),dos_c(ulica))
   @ 13,60 say iif(empty(nr_domu),repl([.],5),dos_c(nr_domu))
   @ 13,72 say iif(empty(nr_mieszk),repl([.],5),dos_c(nr_mieszk))
   @ 15,57 say iif(empty(kod_p).or.kod_p=[  -   ],repl([.],6),kod_p)
   @ 15,64 say iif(empty(poczta),repl([.],15),padc(alltrim(poczta),15))
   @ 17,57 say iif(empty(tel),repl([.],10),dos_c(tel))
   @ 17,69 say iif(empty(fax),repl([.],10),dos_c(fax))
   @ 19,57 say iif(empty(tlx),repl([.],10),tlx)
   @ 19,72 say iif(spolka,'Tak','Nie')
   @ 22,63 say iif(empty(data_zal),repl([.],10),dos_c(dtoc(data_zal)))
   podatki=space(13)
   if VATFORDR=='  '
      if VATOKRES='K'
         *if VATOKRESDR='M'
            zVATFORDR='7K'
         *else
            *zVATFORDR='7D'
         *endif
      else
         zVATFORDR='7 '
      endif
   else
      zVATFORDR=VATFORDR
   endif
   IF firma->ryczalt <> 'T' .AND. spolka->( dbSeek( "+" + Str( firma->( RecNo() ), 3 ) ) )
      DO CASE
      CASE spolka->sposob == 'L'
         cRodz := "Lin"
      CASE spolka->sposob == 'P'
         cRodz := "Prog"
      ENDCASE
   ENDIF
   podatki=iif(VAT='T','VAT'+zVATFORDR,'')+iif(RYCZALT='T','Rycz','')+iif(DETAL='T','Det','')
   IF Len( cRodz ) > 0
      podatki := podatki + " " + cRodz
   ENDIF
   @ 22,42 say iif(empty(podatki),repl([ ],13),padc(podatki,13,' '))
   do notes with .f.
   set color to
***************************************************
function v10_1
   if empty(zsymbol)
      return .f.
   endif
   nr_rec=recno()
   seek [+]+dos_l(zsymbol)
   fou=found()
   rec=recno()
   go nr_rec
   if fou.and.(ins.or.rec#nr_rec)
      set cursor off
      kom(3,[*u],'Taki symbol ju&_z. istnieje')
      set cursor on
      return .f.
   endif
   return .t.
***************************************************
function w3_1321
   ColInf()
   @ 24,0 say padc('Wpisz: T - je&_z.eli firma jest sp&_o.&_l.ka lub N - je&_z.eli osob&_a. fizyczn&_a.',80,' ')
   ColStd()
   @ 19,73 say iif(zSPOLKA='T','ak','ie')
   return .t.
***************************************************
function v3_1321
   R=.f.
   if zSPOLKA$'TN'
      ColStd()
      @ 19,73 say iif(zSPOLKA='T','ak','ie')
      @ 24,0
      R=.t.
   endif
   return R
*############################################################################

FUNCTION Firma_WczytajEmail()

   LOCAL cEmail := ""
   LOCAL nWorkNo := Select()

   IF DostepPro( "FIRMA", , .T., "FIRMAEM" )
      firmaem->( dbGoto( Val( ident_fir ) ) )
      cEmail := AllTrim( firmaem->email )
      firmaem->( dbCloseArea() )
   ENDIF

   dbSelectArea( nWorkNo )

   RETURN cEmail

/*----------------------------------------------------------------------*/

PROCEDURE Firma_ZapiszEmail( cEmail )

   LOCAL nWorkNo := Select()

   IF DostepPro( "FIRMA", , .T., "FIRMAEM" )
      firmaem->( dbGoto( Val( ident_fir ) ) )
      firmaem->( RLock() )
      firmaem->email := cEmail
      firmaem->( dbCommit() )
      firmaem->( dbCloseArea() )
   ENDIF

   dbSelectArea( nWorkNo )

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION Firma_Wczytaj( aPola )

   LOCAL aRes := hb_Hash()
   LOCAL nWorkNo := Select()
   LOCAL nI, cPole

   IF DostepPro( "FIRMA", , .T., "FIRMAPO" )
      firmapo->( dbGoto( Val( ident_fir ) ) )
      FOR nI := 1 TO Len( aPola )
         cPole := aPola[ nI ]
         aRes[ aPola[ nI ] ] := firmapo->&cPole
      NEXT
      firmapo->( dbCloseArea() )
   ENDIF

   dbSelectArea( nWorkNo )

   RETURN aRes

/*----------------------------------------------------------------------*/

PROCEDURE Firma_Zapisz( aPola )

   LOCAL aRes := hb_Hash()
   LOCAL nWorkNo := Select()
   LOCAL nI

   IF DostepPro( "FIRMA", , .T., "FIRMAPO" )
      firmapo->( dbGoto( Val( ident_fir ) ) )
      firmapo->( RLock() )
      FOR nI := 1 TO Len( aPola )
         firmapo->&( hb_HKeyAt( aPola, nI ) ) := hb_HValueAt( aPola, nI )
      NEXT
      firmapo->( dbCommit() )
      firmapo->( dbCloseArea() )
   ENDIF

   dbSelectArea( nWorkNo )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION Firma_UtworzTabliceExp( cNazwa, cPlik, cAlias, nWA )

   LOCAL aTabInfo := dbfZnajdzTablice( cNazwa )
   LOCAL aDbStruct := {}

   hb_default( @nWA, 0 )

   IF aTabInfo <> NIL
      aDbStruct := AClone( aTabInfo[ 3 ] )
      AAdd( aDbStruct, { "RECNO_", "N", 8, 0 } )
      IF aDbStruct[ 1 ][ 2 ] == "+"
         aDbStruct[ 1 ][ 2 ] := "N"
         aDbStruct[ 1 ][ 3 ] := 8
      ENDIF
      dbCreate( cPlik, aDbStruct, "ARRAYRDD" )

      IF HB_ISCHAR( cAlias ) .AND. ! Empty( cAlias )
         IF nWA > 0
            dbSelectArea( nWA )
         ENDIF
         dbUseArea( nWA == 0, "ARRAYRDD", cPlik, cAlias, .F. )
      ENDIF

      RETURN .T.
   ENDIF

   RETURN .F.

/*----------------------------------------------------------------------*/

FUNCTION Firma_ImportRec( cAliasFrom, cAliasTo, aStructFrom, aStructTo, aSkip, aValues, lDoAppend )

   LOCAL nWAFrom := Select( cAliasFrom ), nWATo := Select( cAliasTo )
   LOCAL nCnt := 0, nI, aTmpStruct
   LOCAL cFldName, nFldFrom, nFldTo

   hb_default( @aSkip, {} )
   hb_default( @aValues, {=>} )
   hb_default( @lDoAppend, .T. )

   IF ! HB_ISARRAY( aStructFrom )
      aStructFrom := {}
      aTmpStruct := ( nWAFrom )->( dbStruct() )
      AEval( aTmpStruct, { | aFld | AAdd( aStructFrom, aFld[ 1 ] ) } )
   ENDIF
   IF ! HB_ISARRAY( aStructTo )
      aStructTo := {}
      aTmpStruct := ( nWATo )->( dbStruct() )
      AEval( aTmpStruct, { | aFld | AAdd( aStructTo, aFld[ 1 ] ) } )
   ENDIF

   IF lDoAppend
      ( nWATo )->( dbAppend() )
   ENDIF

   FOR nI := 1 TO Len( aStructFrom )
      IF ( nFldTo := AScan( aStructTo, aStructFrom[ nI ] ) ) > 0 .AND. AScan( aSkip, aStructFrom[ nI ] ) == 0
         ( nWATo )->( FieldPut( nFldTo, ( nWAFrom )->( FieldGet( nI ) ) ) )
      ENDIF
   NEXT

   IF AScan( aStructTo, "RECNO_" ) > 0
      ( nWATo )->recno_ := ( nWAFrom )->( RecNo() )
   ENDIF

   hb_HEval( aValues, { | cKey, xValue |
      LOCAL nFld := AScan( aStructTo, Upper( cKey ) )
      IF nFld > 0
         ( nWATo )->( FieldPut( nFld, xValue ) )
      ENDIF
      RETURN NIL
   } )

   IF lDoAppend
      ( nWATo )->( dbCommit() )
   ENDIF

   RETURN nCnt

/*----------------------------------------------------------------------*/

PROCEDURE Firma_Konwertuj()

   LOCAL cSymbol, cKolSp, cKolZk
   LOCAL cEkran, cKolor
   LOCAL nI, nCnt
   LOCAL cIdentFirmy
   LOCAL aStructFrom, aStructTo
   LOCAL cRyczalt
   LOCAL bVSymbol := { | |
      LOCAL nTmpNrRec := firma->( RecNo() )
      LOCAL lRes := .T.
      IF Empty( cSymbol )
         RETURN .F.
      ENDIF
      IF firma->( dbSeek( "+" + dos_l( cSymbol ) ) )
         Komun( "Taki symbol ju¾ istnieje" )
         lRes := .F.
      ENDIF
      firma->( dbGoto( nTmpNrRec ) )
      RETURN lRes
   }

   IF firma->vat <> 'T' .OR. AScan( { "7", "7K" }, AllTrim( firma->vatfordr ) ) == 0
      Komun( "Konwersja jest mo¾liwa tylko dla pˆatnik¢w VAT" )
      RETURN
   ENDIF

   cEkran := SaveScreen()
   cKolor := ColStd()

   cRyczalt := iif( firma->ryczalt == "T", "N", "T" )

   cSymbol := AllTrim( firma->symbol )
   IF Len( cSymbol ) < 10
      cSymbol := Pad( cSymbol + "K", 10 )
   ELSE
      cSymbol := SubStr( cSymbol, 1, 9 ) + "K"
   ENDIF

   IF cRyczalt == "T"
      cKolSp := " 5"
   ELSE
      cKolSp := "7"
   ENDIF

   @ 12, 10 CLEAR TO 16, 65
   @ 12, 10 TO 16, 65
   @ 13, 11 SAY "Konwersja " + iif( firma->ryczalt == "T", "RYCZAT", "ZASADY OGàLNE" ) + " -> " + iif( firma->ryczalt == "T", "ZASADY OGàLNE", "RYCZAT" )
   @ 14, 11 SAY "Nowy symbol firmy:" GET cSymbol VALID Eval( bVSymbol )
   IF cRyczalt <> "T"
      @ 15, 11 SAY "Domy˜lna kolumna ksi©gi dla sprzeda¾y (7,8):" GET cKolSp VALID cKolSp $ '78'
   ELSE
      @ 15, 11 SAY "Domy˜lna kolumna ewidencji dla sprzeda¾y (5-13):" GET cKolSp PICTURE '@K 99' VALID Val( cKolSp ) >= 5 .AND. Val( cKolSp ) <= 13
   ENDIF
   READ

   RestScreen( , , , , cEkran )

   IF LastKey() == 27
      SetColor( cKolor )
      RETURN
   ENDIF

   @ 10, 18 CLEAR TO 14, 62
   @ 10, 18 TO 14, 62
   @ 11, 20 SAY "Konwersja... prosz© czeka†..."
   @ 12, 20 SAY "Krok 1 z 6: pobieranie danych firmy      "

   cIdentFirmy := Str( firma->( RecNo() ), 3 )

   dbfInicjujDane()

   Firma_UtworzTabliceExp( "FIRMA", "FIRMA_EXP", "FIRMA_EXP", 200 )
   Firma_UtworzTabliceExp( "KAT_SPR", "KAT_SPR_EXP", "KAT_SPR_EXP", 201 )
   Firma_UtworzTabliceExp( "KAT_ZAK", "KAT_ZAK_EXP", "KAT_ZAK_EXP", 202 )
   Firma_UtworzTabliceExp( "SPOLKA", "SPOLKA_EXP", "SPOLKA_EXP", 203 )
   Firma_UtworzTabliceExp( "REJS", "REJS_EXP", "REJS_EXP", 204 )
   Firma_UtworzTabliceExp( "REJZ", "REJZ_EXP", "REJZ_EXP", 205 )
   //Firma_UtworzTabliceExp( "ROZR", "ROZR_EXP", "ROZR_EXP", 206 )

   Firma_ImportRec( "FIRMA", "FIRMA_EXP" )
   firma_exp->ryczalt := iif( firma->ryczalt == "T", "N", "T" )
   firma_exp->( dbCommit() )

   aStructFrom := NIL
   aStructTo := NIL
   IF spolka->( dbSeek( "+" + cIdentFirmy ) )
      DO WHILE spolka->del == "+" .AND. spolka->firma == cIdentFirmy .AND. ! spolka->( Eof() )
         Firma_ImportRec( "SPOLKA", "SPOLKA_EXP", @aStructFrom, @aStructTo )
         spolka->( dbSkip() )
      ENDDO
   ENDIF

   aStructFrom := NIL
   aStructTo := NIL
   DO WHILE ! DostepPro( "KAT_SPR", , , , "KAT_SPR" )
   ENDDO
   IF kat_spr->( dbSeek( "+" + cIdentFirmy ) )
      DO WHILE kat_spr->del == "+" .AND. kat_spr->firma == cIdentFirmy .AND. ! kat_spr->( Eof() )
         Firma_ImportRec( "KAT_SPR", "KAT_SPR_EXP", @aStructFrom, @aStructTo )
         kat_spr->( dbSkip() )
      ENDDO
   ENDIF
   kat_spr->( dbCloseArea() )

   aStructFrom := NIL
   aStructTo := NIL
   DO WHILE ! DostepPro( "KAT_ZAK", , , , "KAT_ZAK" )
   ENDDO
   IF kat_zak->( dbSeek( "+" + cIdentFirmy ) )
      DO WHILE kat_zak->del == "+" .AND. kat_zak->firma == cIdentFirmy .AND. ! kat_zak->( Eof() )
         Firma_ImportRec( "KAT_ZAK", "KAT_ZAK_EXP", @aStructFrom, @aStructTo )
         kat_zak->( dbSkip() )
      ENDDO
   ENDIF
   kat_zak->( dbCloseArea() )

   @ 12, 20 SAY "Krok 2 z 6: pobieranie rejestru sprzeda¾y"
   aStructFrom := NIL
   aStructTo := NIL
   DO WHILE ! DostepPro( "REJS", , , , "REJS" )
   ENDDO
   IF rejs->( dbSeek( "+" + cIdentFirmy ) )
      DO WHILE rejs->del == "+" .AND. rejs->firma == cIdentFirmy .AND. ! rejs->( Eof() )
         Firma_ImportRec( "REJS", "REJS_EXP", @aStructFrom, @aStructTo )
         rejs->( dbSkip() )
      ENDDO
   ENDIF
   rejs->( dbCloseArea() )

   @ 12, 20 SAY "Krok 3 z 6: pobieranie rejestru zakup¢w  "
   aStructFrom := NIL
   aStructTo := NIL
   DO WHILE ! DostepPro( "REJZ", , , , "REJZ" )
   ENDDO
   IF rejz->( dbSeek( "+" + cIdentFirmy ) )
      DO WHILE rejz->del == "+" .AND. rejz->firma == cIdentFirmy .AND. ! rejz->( Eof() )
         Firma_ImportRec( "REJZ", "REJZ_EXP", @aStructFrom, @aStructTo )
         rejz->( dbSkip() )
      ENDDO
   ENDIF
   rejz->( dbCloseArea() )

   @ 12, 20 SAY "Krok 4 z 6: zapisywanie danych firmy     "
   Firma_ImportRec( "FIRMA_EXP", "FIRMA", , , { "ID" }, { "SYMBOL" => cSymbol } )

   cIdentFirmy := Str( firma->( RecNo() ), 3 )

   FOR nI := 1 TO 12
      suma_mc->( dbAppend() )
      suma_mc->del := "+"
      suma_mc->firma := cIdentFirmy
      suma_mc->mc := Str( nI, 2 )
      suma_mc->( dbCommit() )
      suma_mc->( dbRUnlock() )
   NEXT

   aStructFrom := NIL
   aStructTo := NIL
   DO WHILE ! DostepPro( "DANE_MC", , , , "DANE_MC" )
   ENDDO
   spolka_exp->( dbGoTop() )
   DO WHILE ! spolka_exp->( Eof() )
      Firma_ImportRec( "SPOLKA_EXP", "SPOLKA", @aStructFrom, @aStructTo, { "ID" }, { "FIRMA" => cIdentFirmy } )
      FOR nI := 1 TO 12
         dane_mc->( dbAppend() )
         dane_mc->del := "+"
         dane_mc->ident := Str( spolka->( RecNo() ), 5 )
         dane_mc->mc := Str( nI, 2 )
         dane_mc->g_udzial1 := " 1/1  "
         dane_mc->g_udzial2 := " 1/1  "
         dane_mc->n_udzial1 := " 1/1  "
         dane_mc->n_udzial2 := " 1/1  "
         dane_mc->( dbCommit() )
      NEXT
      spolka_exp->( dbSkip() )
   ENDDO
   dane_mc->( dbCloseArea() )

   aStructFrom := NIL
   aStructTo := NIL
   DO WHILE ! DostepPro( "KAT_SPR", , , , "KAT_SPR" )
   ENDDO
   kat_spr_exp->( dbGoTop() )
   DO WHILE ! kat_spr_exp->( Eof() )
      Firma_ImportRec( "KAT_SPR_EXP", "KAT_SPR", @aStructFrom, @aStructTo, { "ID" }, { "FIRMA" => cIdentFirmy } )
      kat_spr_exp->( dbSkip() )
   ENDDO
   kat_spr->( dbCloseArea() )

   aStructFrom := NIL
   aStructTo := NIL
   DO WHILE ! DostepPro( "KAT_ZAK", , , , "KAT_ZAK" )
   ENDDO
   kat_zak_exp->( dbGoTop() )
   DO WHILE ! kat_zak_exp->( Eof() )
      Firma_ImportRec( "KAT_ZAK_EXP", "KAT_ZAK", @aStructFrom, @aStructTo, { "ID" }, { "FIRMA" => cIdentFirmy } )
      kat_zak_exp->( dbSkip() )
   ENDDO
   kat_zak->( dbCloseArea() )

   @ 12, 20 SAY "Krok 5 z 6: zapis rejestru sprzeda¾y     "

   ident_fir := cIdentFirmy
   miesiac := ' 1'

   symbol_fir=firma->symbol
   ident_fir=str( firma->( RecNo() ), 3 )
   Firma_RodzNrKs := firma->rodznrks
   zVAT=iif(firma->VAT=' ','N',firma->VAT)
   zVATOKRES=iif(firma->VATOKRES=' ','M',firma->VATOKRES)
   zVATOKRESDR=firma->VATOKRESDR
   if firma->VATFORDR=='  '
      if zVATOKRES='M'
         *if zVATOKRESDR='M'
            zVATFORDR='7 '
         *else
            *zVATFORDR='7D'
         *endif
      else
         zVATFORDR='7K'
      endif
   else
      zVATFORDR=firma->VATFORDR
   endif
   zUEOKRES=iif(firma->UEOKRES='K','K','M')
   DETALISTA=firma->DETAL
   ZRYCZALT=firma->RYCZALT
   pzROZRZAPK=firma->ROZRZAPK
   pzROZRZAPS=firma->ROZRZAPS
   pzROZRZAPZ=firma->ROZRZAPZ
   pzROZRZAPF=firma->ROZRZAPF

   liczba := 1

   spolka->( dbCloseArea() )
   suma_mc->( dbCloseArea() )
   firma->( dbCloseArea() )

   nCnt := rejs_exp->( RecCount() )
   nI := 1

   OpenOper( "REJS" )

   rejs_exp->( dbGoTop() )
   DO WHILE ! rejs_exp->( Eof() )

      ins := .T.

      miesiac := rejs_exp->mc

      suma_mc->( dbSeek( "+" + cIdentFirmy + miesiac ) )

      DO CASE
      CASE miesiac == ' 1' .OR. miesiac == ' 3' .OR. miesiac == ' 5' .OR. miesiac == ' 7' .OR. miesiac == ' 8' .OR. miesiac == '10' .OR. miesiac == '12'
         DAYM := '31'
      CASE miesiac == ' 4' .OR. miesiac == ' 6' .OR. miesiac == ' 9' .OR. miesiac == '11'
         DAYM := '30'
      CASE miesiac == ' 2'
         DAYM := '29'
         IF Day( CToD( param_rok + '.' + miesiac + '.' + DAYM ) ) == 0
            DAYM := '28'
         ENDIF
      ENDCASE

      zDZIEN := rejs_exp->dzien
      znazwa := rejs_exp->nazwa
      zNR_IDENT := rejs_exp->nr_ident
      zNUMER := JPKImp_NrDokumentu( rejs_exp->numer )
      zADRES := rejs_exp->adres
      zTRESC := rejs_exp->tresc
      zROKS := rejs_exp->roks
      zMCS := rejs_exp->mcs
      zDZIENS := rejs_exp->dziens
      zDATAS := hb_Date( Val( rejs_exp->roks ), Val( rejs_exp->mcs ), Val( rejs_exp->dziens ) )
      zDATATRAN := rejs_exp->datatran
      zKOLUMNA := cKolSp
      zuwagi := rejs_exp->uwagi
      zWARTZW := rejs_exp->wartzw
      zWART08 := rejs_exp->wart08
      zWART00 := rejs_exp->wart00
      zWART02 := rejs_exp->wart02
      zVAT02 := rejs_exp->vat02
      zWART07 := rejs_exp->wart07
      zVAT07 := rejs_exp->vat07
      zWART22 := rejs_exp->wart22
      zVAT22 := rejs_exp->vat22
      zWART12 := rejs_exp->wart12
      zVAT12 := rejs_exp->vat12
      zBRUTZW := rejs_exp->wartzw
      zBRUT08 := rejs_exp->wart08
      zBRUT00 := rejs_exp->wart00
      zBRUT02 := rejs_exp->wart02 + rejs_exp->vat02
      zBRUT07 := rejs_exp->wart07 + rejs_exp->vat07
      zBRUT22 := rejs_exp->wart22 + rejs_exp->vat22
      zBRUT12 := rejs_exp->wart12 + rejs_exp->vat12
      zRODZDOW := rejs_exp->rodzdow
      zVATMARZA := rejs_exp->vatmarza
      zNETTO := rejs_exp->netto + rejs_exp->netto2
      zExPORT := rejs_exp->export
      zUE := rejs_exp->ue
      zKRAJ := rejs_exp->kraj
      zSEK_CV7 := rejs_exp->sek_cv7
      zRACH := rejs_exp->rach
      zDETAL := rejs_exp->detal
      zKOREKTA :=  rejs_exp->korekta
      zROZRZAPS := rejs_exp->rozrzaps
      zZAP_TER := rejs_exp->zap_ter
      zZAP_DAT := rejs_exp->zap_dat
      zZAP_WART := rejs_exp->zap_wart
      zTROJSTR := rejs_exp->trojstr
      zSYMB_REJ := rejs_exp->symb_rej
      zTRESC := rejs_exp->tresc
      zOPCJE := rejs_exp->opcje
      zPROCEDUR := rejs_exp->procedur
      zKOL36 := rejs_exp->kol36
      zKOL37 := rejs_exp->kol37
      zKOL38 := rejs_exp->kol38
      zKOL39 := rejs_exp->kol39
      zNETTO2 := 0 //rejs_exp->netto2
      zKOLUMNA2 := ' ' //rejs_exp->kolumna2
      zDATA_ZAP := rejs_exp->data_zap

      KRejS_Ksieguj()

      rejs_exp->( dbSkip() )

      @ 13, 20 SAY Pad( "Zapisano " + AllTrim( Str( nI ) ) + " z " + AllTrim( Str( nCnt ) ), 20 )

      nI++
   ENDDO

   FOR nI := 1 TO 199
      ( nI )->( dbCloseArea() )
   NEXT

   @ 12, 20 SAY "Krok 6 z 6: zapis rejestru zakup¢w       "

   nCnt := rejz_exp->( RecCount() )
   nI := 1

   miesiac := ' 1'

   OpenOper( "REJZ" )

   rejz_exp->( dbGoTop() )
   DO WHILE ! rejz_exp->( Eof() )

      ins := .T.

      miesiac := rejz_exp->mc

      suma_mc->( dbSeek( "+" + cIdentFirmy + miesiac ) )

      DO CASE
      CASE miesiac == ' 1' .OR. miesiac == ' 3' .OR. miesiac == ' 5' .OR. miesiac == ' 7' .OR. miesiac == ' 8' .OR. miesiac == '10' .OR. miesiac == '12'
         DAYM := '31'
      CASE miesiac == ' 4' .OR. miesiac == ' 6' .OR. miesiac == ' 9' .OR. miesiac == '11'
         DAYM := '30'
      CASE miesiac == ' 2'
         DAYM := '29'
         IF Day( CToD( param_rok + '.' + miesiac + '.' + DAYM ) ) == 0
            DAYM := '28'
         ENDIF
      ENDCASE

      zDZIEN := rejz_exp->dzien
      znazwa := rejz_exp->nazwa
      zNR_IDENT := rejz_exp->NR_IDENT
      zNUMER := JPKImp_NrDokumentu( rejz_exp->NUMER )
      zADRES := rejz_exp->ADRES
      zTRESC := rejz_exp->TRESC
      zROKS := rejz_exp->ROKS
      zMCS := rejz_exp->MCS
      zDZIENS := rejz_exp->DZIENS
      zDATAS := hb_Date( Val( rejz_exp->roks ), Val( rejz_exp->mcs ), Val( rejz_exp->dziens ) )
      zDATAKS := rejz_exp->DATAKS
      zDATATRAN := rejz_exp->DATATRAN
      IF cRyczalt <> 'T'
         zKOLUMNA := '10' // rejz_exp->KOLUMNA
      ELSE
         zKOLUMNA := '  '
      ENDIF
      zuwagi := rejz_exp->uwagi
      zWARTZW := rejz_exp->WARTZW
      zWART00 := rejz_exp->WART00
      zWART02 := rejz_exp->WART02
      zVAT02 := rejz_exp->VAT02
      zWART07 := rejz_exp->WART07
      zVAT07 := rejz_exp->VAT07
      zWART22 := rejz_exp->WART22
      zVAT22 := rejz_exp->VAT22
      zWART12 := rejz_exp->WART12
      zVAT12 := rejz_exp->VAT12
      zBRUTZW := rejz_exp->WARTZW
      zBRUT00 := rejz_exp->WART00
      zBRUT02 := rejz_exp->WART02 + rejz_exp->vat02
      zBRUT07 := rejz_exp->wart07 + rejz_exp->vat07
      zBRUT22 := rejz_exp->wart22 + rejz_exp->vat22
      zBRUT12 := rejz_exp->wart12 + rejz_exp->vat12
      IF cRyczalt <> 'T' .AND. rejz_exp->NETTO + rejz_exp->NETTO2 == 0
         zNETTO := rejz_exp->WARTZW + rejz_exp->WART00 + rejz_exp->WART02 + rejz_exp->WART07 + rejz_exp->WART22 + rejz_exp->WART12
      ELSE
         zNETTO := rejz_exp->NETTO + rejz_exp->NETTO2
      ENDIF
      zExPORT := rejz_exp->ExPORT
      zUE := rejz_exp->UE
      zKRAJ := rejz_exp->KRAJ
      zSEK_CV7 := rejz_exp->SEK_CV7
      zRACH := rejz_exp->RACH
      zDETAL := rejz_exp->DETAL
      zKOREKTA := rejz_exp->KOREKTA
      zROZRZAPZ := rejz_exp->ROZRZAPZ
      zZAP_TER := rejz_exp->ZAP_TER
      zZAP_DAT := rejz_exp->ZAP_DAT
      zZAP_WART := rejz_exp->ZAP_WART
      zTROJSTR := rejz_exp->TROJSTR
      zSYMB_REJ := rejz_exp->SYMB_REJ
      zTRESC := rejz_exp->TRESC
      zUSLUGAUE := rejz_exp->USLUGAUE
      zWEWDOS := rejz_exp->WEWDOS
      zPALIWA := rejz_exp->PALIWA
      zPOJAZDY := rejz_exp->POJAZDY
      zSP22 := rejz_exp->SP22
      zSP12 := rejz_exp->SP12
      zSP07 := rejz_exp->SP07
      zSP02 := rejz_exp->SP02
      zSP00 := rejz_exp->SP00
      zSPZW := rejz_exp->SPZW
      zZOM22 := rejz_exp->ZOM22
      zZOM00 := rejz_exp->ZOM00
      zZOM12 := rejz_exp->ZOM12
      zZOM07 := rejz_exp->ZOM07
      zZOM02 := rejz_exp->ZOM02
      zOPCJE := rejz_exp->OPCJE

      zKOL47 := rejz_exp->KOL47
      zKOL48 := rejz_exp->KOL48
      zKOL49 := rejz_exp->KOL49
      zKOL50 := rejz_exp->KOL50

      zNETTO2 := 0  //rejz_exp->NETTO2
      zKOLUMNA2 := '  '  //rejz_exp->KOLUMNA2

      zRODZDOW := rejz_exp->RODZDOW
      zVATMARZA := rejz_exp->VATMARZA

      KRejZ_Ksieguj()

      rejz_exp->( dbSkip() )

      @ 13, 20 SAY Pad( "Zapisano " + AllTrim( Str( nI ) ) + " z " + AllTrim( Str( nCnt ) ), 20 )

      nI++
   ENDDO

   Close_()

   SELECT 3
   DO WHILE ! Dostep( 'SPOLKA' )
   ENDDO
   SET INDEX TO spolka

   SELECT 2
   DO WHILE ! Dostep('SUMA_MC')
   ENDDO
   SET INDEX TO suma_mc

   SELECT 1
   DO WHILE ! Dostep('FIRMA')
   ENDDO
   SET INDEX TO firma

   RestScreen( , , , , cEkran )
   SetColor( cKolor )
   SELECT firma

   Komun( "Konwersja zakoäczona" )

   RETURN

/*----------------------------------------------------------------------*/

