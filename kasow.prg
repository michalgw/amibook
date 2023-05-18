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

FUNCTION Kasow()

@ 3,42 clear to 22,79
@ 11,44 to 16,79 double
set color to *i
@ 11,45 say [                                  ]
@ 12,45 say [            U W A G A             ]
@ 13,45 say [ Przed skasowaniem nale&_z.y wykona&_c. ]
@ 14,45 say [ kopiowanie  danych  za  pomoc&_a.    ]
@ 15,45 say [ funkcji "Kopiowanie danych".     ]
@ 16,45 say [                                  ]
set color to
if .not.tnesc([*u],[ Czy posiadasz kopie archiwaln&_a. danych z ca&_l.ego roku na dyskietkach? (T/N) ])
return
endif
@ 3,42 clear to 22,79
@ 11,49 to 16,74 double
set color to *i
@ 11,50 say '                        '
@ 12,50 say '     U W A G A  !!!     '
@ 13,50 say '                        '
@ 14,50 say '   Dane z ca&_l.ego roku   '
@ 15,50 say '   zostan&_a. wykasowane   '
@ 16,50 say '                        '
set color to
IF param_dzw='T'
tone(500,4)
tone(500,4)
tone(500,4)
endif
if tnesc([*i],[   Jeste&_s. pewny? (T/N)   ])
   set cursor on
   do czekaj
   set cursor off
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ KASOWANIE @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   do while.not.dostepex('OPER')
   enddo
   do SETIND with 'OPER'
   zap_()
   do while.not.dostepex('EWID')
   enddo
   do SETIND with 'EWID'
   zap_()
   do while.not.dostepex('SUMA_MC')
   enddo
   set inde to suma_mc
   do while del=[+]
      zero_(5)
      skip
   enddo
   do while.not.dostepex('FAKTURY')
   enddo
   do SETIND with 'FAKTURY'
   zap_()
   do while.not.dostepex('FAKTURYW')
   enddo
   do SETIND with 'FAKTURYW'
   zap_()
   do while.not.dostepex('POZYCJE')
   enddo
   set inde to pozycje
   zap_()
   do while.not.dostepex('POZYCJEW')
   enddo
   set inde to pozycjew
   zap_()
   do while.not.dostepex('TRESC')
   enddo
   SetInd( 'TRESC' )
   do while .not.eof()
      repl_([stan],0)
      skip
   enddo
   do while.not.dostepex('FIRMA')
   enddo
   do SETIND with 'FIRMA'
   do while .not.eof()
      repl_([nr_fakt],1)
      repl_([nr_faktw],1)
      repl_([nr_rach],1)
      repl_([liczba],1)
*      repl_([liczba_wyp],1)
      skip
   enddo
   do while.not.dostepex('DANE_MC')
   enddo
   set inde to dane_mc
   do while .not.eof()
      zero_(5)
      repl_([g_udzial1],[ 1/1  ])
      repl_([g_udzial2],[ 1/1  ])
      repl_([n_udzial1],[ 1/1  ])
      repl_([n_udzial2],[ 1/1  ])
      skip
   enddo
   do while.not.dostepex('SPOLKA')
   enddo
   set inde to spolka,spolka1
   do while .not.eof()
      for i=12 to 2 step -1
          zm=[udzial]+ltrim(str(i))
          if [   /   ]#&zm
             repl_([udzial1],&zm     )
          endif
          repl_(zm,[   /   ])
      next
      skip
   enddo
   do while.not.dostepex('REJS')
   enddo
   do SETIND with 'REJS'
   zap_()
   do while.not.dostepex('REJZ')
   enddo
   do SETIND with 'REJZ'
   zap_()
   do while.not.dostepex('DZIENNE')
   enddo
   do SETIND with 'DZIENNE'
   zap_()
   do while.not.dostepex('ETATY')
   enddo
   do SETIND with 'ETATY'
   do while del=[+]
      zero_(6)
      skip
   enddo
   do while.not.dostepex('NIEOBEC')
   enddo
   do SETIND with 'NIEOBEC'
   zap_()
   do while.not.dostepex('WYPLATY')
   enddo
   do SETIND with 'WYPLATY'
   zap_()
   do while.not.dostepex('ZALICZKI')
   enddo
   do SETIND with 'ZALICZKI'
   zap_()
   do while.not.dostepex('UMOWY')
   enddo
   do SETIND with 'UMOWY'
   zap_()
   do while.not.dostepex('EWIDPOJ')
   enddo
   do SETIND with 'EWIDPOJ'
   zap_()
   do while.not.dostepex('RACHPOJ')
   enddo
   do SETIND with 'RACHPOJ'
   zap_()
   do while.not.dostepex('TRESCKOR')
   enddo
   do SETIND with 'TRESCKOR'
   zap_()
*   do while.not.dostepex('DOWEW')
*   enddo
*   do SETIND with 'DOWEW'
*   zap_()
   do while.not.dostepex('EDEKLAR')
   enddo
   do SETIND with 'EDEKLAR'
   zap_()
   do while.not.dostepex('VAT7ZD')
   enddo
   do SETIND with 'VAT7ZD'
   zap_()
   do while.not.dostepex('EWIDZWR')
   enddo
   do SETIND with 'EWIDZWR'
   zap_()
   do while.not.dostepex('OSSREJ')
   enddo
   do SETIND with 'OSSREJ'
   zap_()
   do while.not.dostepex('VIUDOKOR')
   enddo
   do SETIND with 'VIUDOKOR'
   zap_()
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   close_()
   Indeks()
   !cmd /C "del /Q /F XML\*.*"
   IF param_dzw='T'
   tone(300,5)
   endif
endif
