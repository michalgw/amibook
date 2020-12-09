      /************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michaà Gawrycki (gmsystems.pl)

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

#include "Inkey.ch"

*±±±±±± NAGLOWEK KEDU ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE KEDU_POCZ()

   ?? "<!DOCTYPE KEDU PUBLIC '-//ZUS//DTD KEDU 1.3//PL'["
   ? "<!ENTITY wersja '001.300'>"
   ? "<!ENTITY strona.kodowa 'ISO 8859-2'>]>"
   ? "<KEDU>"
   ? "<naglowek.KEDU>"
   ? Space( 139 )
   ? "</naglowek.KEDU>"

   RETURN

*±±±±±± STOPKA KEDU ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE KEDU_KON()

   ? "<stopka.KEDU>"
   ? "</stopka.KEDU>"
   ? "</KEDU>"

   RETURN

*±±±±±± RAPORT z KEDU ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE KEDU_RAPO( plik_k )

   CurCol := ColStd()
   SET COLOR TO w
   @ 12, 43 SAY PadC( 'Utworzono plik ' + plik_k, 35 )
   @ 13, 43 SAY PadC( 'Zaimportuj go Programem P&_l.atnika', 35 )
   @ 14, 43 SAY PadC( 'Poszczeg&_o.lne znaki w nazwie', 35 )
   @ 15, 43 SAY PadC( 'pliku '+plik_k+' oznaczaj&_a.:', 35 )
   SET COLOR TO w+
   @ 16, 43 SAY SubStr( plik_k, 1, 1 ) PICTURE '!!'
   @ 17, 43 SAY SubStr( plik_k, 2, 1 ) PICTURE '!!'
   @ 18, 43 SAY SubStr( plik_k, 3, 2 ) PICTURE '!!'
   @ 19, 43 SAY SubStr( plik_k, 5, 1 ) PICTURE '!!'
   @ 20, 43 SAY SubStr( plik_k, 6, 1 ) PICTURE '!!'
   @ 21, 43 SAY SubStr( plik_k, 7, 2 ) PICTURE '!!'
   ColStd()
   @ 16, 45 SAY '-ko&_n.c&_o.wka roku ' + param_rok
   @ 17, 45 SAY '-nr miesi&_a.ca (dla zg&_l.osze&_n. 0)(HEX)'
   @ 18, 45 SAY '-nr firmy (S35)'
   DO CASE
   CASE SubStr( plik_k, 5, 1 ) = '1'
      symfor := 'ZUA'
   CASE SubStr( plik_k, 5, 1 ) = '2'
      symfor := 'ZCZA'
   CASE SubStr( plik_k, 5, 1 ) = '3'
      symfor := 'ZCNA'
   CASE SubStr( plik_k, 5, 1 ) = '4'
      symfor := 'ZPA'
   CASE SubStr( plik_k, 5, 1 ) = '5'
      symfor := 'ZFA'
   CASE SubStr( plik_k, 5, 1 ) = '7'
      symfor := 'RNA'
   CASE SubStr( plik_k, 5, 1 ) = '8'
      symfor := 'RCA'
   CASE SubStr( plik_k, 5, 1 ) = '9'
      symfor := 'DRA'
   CASE SubStr( plik_k, 5, 1 ) = 'A'
      symfor := 'RZA'
   OTHERWISE
      symfor := ''
   ENDCASE
   @ 19, 45 SAY '-symbol formularza (' + symfor + ')'
   DO CASE
   CASE SubStr( plik_k, 6, 1 ) = 'W'
      sympod := 'w&_l.a&_s.ciciel'
   CASE SubStr( plik_k, 6, 1 ) = 'P'
      sympod := 'pracownik'
   CASE SubStr( plik_k, 6, 1 ) = 'F'
      sympod := 'firma'
   CASE SubStr( plik_k, 6, 1 ) = 'R'
      sympod := 'rodzina'
   OTHERWISE
      sympod := ''
   endcase
   @ 20, 45 SAY '-podmiot formularza (' + sympod + ')'
   @ 21, 45 SAY '-nr podmiotu (S35)'
   SET COLOR TO &CurCol
   Inkey( 0, INKEY_KEYBOARD )

   RETURN

*±±±±±± NAGLOWEK DP ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DP_POCZ( FORMA )

   ? '<ZUS' + FORMA + '.DP>'
   ? '<naglowek.DP>'
   ? Space( 245 )
   ? '</naglowek.DP>'

   RETURN

*±±±±±± STOPKA DP ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DP_KON( FORMA )

   ? '<stopka.DP>'
   ? '</stopka.DP>'
   ? '</ZUS' + FORMA + '.DP>'

   RETURN

*±±±±±± ZUSWYMIAR    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ZUSWYMIAR( WYML, WYMM )

   WYMIZUS := StrTran( Str( WYML, 3 ) + Str( WYMM, 3 ), ' ', '0' )
   IF WYMIZUS = '000000'
      WYMIZUS := Space( 6 )
   ENDIF

   RETURN WYMIZUS

*±±±±±± ADKB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ADKB()

   ? '<ADKB>'
   ? Space( 5 )
   ? Space( 26 )
   ? Space( 30 )
   ? Space( 7 )
   ? Space( 7 )
   ? Space( 5 )
   ? Space( 12 )
   ? Space( 12 )
   ? Space( 30 )
   ? '</ADKB>'

   RETURN

*±±±±±± ADKP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ADKP()

   ? '<ADKP>'
   ? Space(5)
   ? Space(26)
   ? Space(30)
   ? Space(7)
   ? Space(7)
   ? Space(12)
   ? Space(5)
   ? Space(12)
   ? Space(12)
   ? Space(30)
   ? '</ADKP>'

   RETURN

*±±±±±± ADZA     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ADZA()

   ? '<ADZA>'
   ? Space(5)
   ? Space(26)
   ? Space(26)
   ? Space(30)
   ? Space(7)
   ? Space(7)
   ? Space(12)
   ? Space(12)
   ? '</ADZA>'

   RETURN

*±±±±±± ASPL     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ASPL( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
   PTEL, PFAX )

   ? '<ASPL>'
   ? lat_iso( PadR( StrTran( PKOD_POCZT, '-', '' ), 5 ) )
   ? lat_iso( PadR( PMIEJSCE, 26 ) )
   ? lat_iso( PadR( PGMINA, 26 ) )
   ? lat_iso( PadR( PULICA, 30 ) )
   ? lat_iso( PadR( PNR_DOMU, 7 ) )
   ? lat_iso( PadR( PNR_LOKAL, 7 ) )
   ? lat_iso( PadR( PTEL, 12 ) )
   ? lat_iso( PadR( PFAX, 12 ) )
   ? Space( 30 )
   ? '</ASPL>'

   RETURN

*±±±±±± ASZP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ASZP( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
   PTEL, PFAX )

   ? '<ASZP>'
   ? lat_iso( PadR( StrTran( PKOD_POCZT, '-', '' ), 5 ) )
   ? lat_iso( PadR( PMIEJSCE, 26 ) )
   ? lat_iso( PadR( PGMINA, 26 ) )
   ? lat_iso( PadR( PULICA, 30 ) )
   ? lat_iso( PadR( PNR_DOMU, 7 ) )
   ? lat_iso( PadR( PNR_LOKAL, 7 ) )
   ? lat_iso( PadR( PTEL, 12 ) )
   ? lat_iso( PadR( PFAX, 12 ) )
   ? Space( 30 )
   ? '</ASZP>'

   RETURN

*±±±±±± AZMO     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE AZMO( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
   PTEL, PFAX )

   ? '<AZMO>'
   ? lat_iso( PadR( StrTran( PKOD_POCZT, '-', '' ), 5 ) )
   ? lat_iso( PadR( PMIEJSCE, 26 ) )
   ? lat_iso( PadR( PGMINA, 26 ) )
   ? lat_iso( PadR( PULICA, 30 ) )
   ? lat_iso( PadR( PNR_DOMU, 7 ) )
   ? lat_iso( PadR( PNR_LOKAL, 7 ) )
   ? lat_iso( PadR( PTEL, 12 ) )
   ? lat_iso( PadR( PFAX, 12 ) )
   ? '</AZMO>'

   RETURN

*±±±±±± DADRA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DADRA( PTERMIN, PMM, PRRRR )

   ? '<DADRA>'
   ? PTERMIN
   ? '01' + StrTran( pmm, ' ', '0' ) + prrrr
   ? Space( 8 )
   ? Space( 6 )
   ? Space( 12 )
   ? '</DADRA>'

   RETURN

*±±±±±± DAIP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DAIP( PNIP, PREGON, PSKROT )

   ? '<DAIP>'
   ? PadR( StrTran( PNIP, '-', '' ), 10 )
   ? PadR( SubStr( StrTran( PREGON, '-', '' ), 1, 9 ), 14 )
   ? lat_iso( PadR( qq( PSKROT ), 31 ) )
   ? Space( 16 )
   ? Space( 16 )
   ? '  '
   ? '</DAIP>'

   RETURN

*±±±±±± DAPL     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DAPL( PNAZWA, PDATA_REJ, PNUMER_REJ, PORGAN, PDATA_ZAL )

   ? '<DAPL>'
   ? lat_iso( PadR( qq( PNAZWA ), 62 ) )
   ? ' '
   ? 'X'
   ? Space( 31 )
   ? 'X'
   ? SubStr( DToS( PDATA_REJ ), 7, 2 ) + SubStr( DToS( PDATA_REJ ), 5, 2 ) + SubStr( DToS( PDATA_REJ ), 1, 4 )
   ? PadR( PNUMER_REJ, 15 )
   ? lat_iso( PadR( PORGAN, 72 ) )
   ? '        '
   pdata_zal := iif( DToS( Pdata_zal ) < '19990101', CToD( '1998/12/31' ), pdata_zal )
   ? SubStr( DToS( PDATA_ZAL ), 7, 2 ) + SubStr( DToS( PDATA_ZAL ), 5, 2 ) + SubStr( DToS( PDATA_ZAL ), 1, 4 )
   ? '</DAPL>'

   RETURN

*±±±±±± DAU      ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DAU( PPESEL, PNIP, PRODZ_DOK, PDOWOD_OSOB, PNAZWISKO, PIMIE, PDATA_UR )

   ? '<DAU>'
   ? PadR( PPESEL, 11 )
   ? PadR( StrTran( PNIP, '-', '' ), 10 )
   ? iif( Empty( PDOWOD_OSOB ), ' ', iif( PRODZ_DOK = 'D', '1', iif( PRODZ_DOK = 'P', '2', ' ' ) ) )
   ? lat_iso( PadR( PDOWOD_OSOB, 9 ) )
   ? lat_iso( PadR( PNAZWISKO, 31 ) )
   ? lat_iso( PadR( PIMIE, 22 ) )
   ? SubStr( DToS( PDATA_UR ), 7, 2 ) + SubStr( DToS( PDATA_UR ), 5, 2 ) + SubStr( DToS( PDATA_UR ), 1, 4 )
   ? Space( 16 )
   ? Space( 16 )
   ? '  '
   ? '</DAU>'

   RETURN

*±±±±±± DDDU     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DDDU( PTYT, PPODS, PPODSZDR )

   ? '<DDDU>'
   ? PadR( PTYT, 6 )
   IF .NOT. Empty( ptyt )
      ? StrTran( Str( ppods * 100, 10 ), ' ', '0' )
      ? StrTran( Str( ppods * 100, 10 ), ' ', '0' )
      ? StrTran( Str( ppodszdr * 100, 10 ), ' ', '0' )
   ELSE
      ? Space( 10 )
      ? Space( 10 )
      ? Space( 10 )
   ENDIF
   ? ' '
   ? '</DDDU>'

   RETURN

*±±±±±± DDORCA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DDORCA( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
   PPODSCHO, PPODSZDR, PWAR_PUE, PWAR_PUR, PWAR_PUC, PWAR_PUZ, PWAR_FUE, ;
   PWAR_FUR, PWAR_FUW, PWAR_PF3, PWAR_SUM, PILOSORODZ, PWARRODZ, PILOSOPIEL, ;
   PWARPIEL, PSUM_ZAS )

   ? '<DDORCA>'
   ? lat_iso( PadR( PNAZWISKO, 31 ) )
   ? lat_iso( PadR( PIMIE, 22 ) )
   ? PTYPID
   ? PadR( PNRID, 11 )
   ? PTYTUB
   ? ' '
   ? PWYMIAR
   ? StrTran( Str( ppodseme * 100, 8 ), ' ', '0' )
   ? StrTran( Str( ppodscho * 100, 8 ), ' ', '0' )
   ? StrTran( Str( ppodszdr * 100, 8 ), ' ', '0' )
   ? StrTran( Str( pwar_pue * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_pur * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_puc * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_puz * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_fue * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_fur * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_fuw * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_pf3 * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_sum * 100, 8 ), ' ', '0' )
   ? StrTran( Str( pilosorodz, 2 ), ' ', '0' )
   ? StrTran( Str( pwarrodz * 100, 7 ),' ', '0' )
   ? '0000000'
   ? StrTran( Str( pilosopiel, 2 ), ' ', '0' )
   ? StrTran( Str( pwarpiel * 100, 7 ), ' ', '0' )
   ? StrTran( Str( psum_zas * 100, 8 ), ' ', '0' )
   ? repl( '0', 16 )
   ? repl( '0', 16 )
   ? '  '
   ? '</DDORCA>'

   RETURN

*±±±±±± DDORNA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DDORNA( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
   PPODSCHO, PPODSZDR, PWAR_PUE, PWAR_PUR, PWAR_PUC, PWAR_PUZ, PWAR_FUE, ;
   PWAR_FUR, PWAR_FUW, PWAR_PF3, PWAR_SUM, PILOSORODZ, PWARRODZ, PILOSOPIEL, ;
   PWARPIEL, PSUM_ZAS, PDATA, PZASAD, PPREMIA, PINNE, PSUMSKLA, PKODSKLA )

   ? '<DDORNA>'
   ? lat_iso( PadR( PNAZWISKO, 31 ) )
   ? lat_iso( PadR( PIMIE, 22 ) )
   IF PTYPID = 'D'
      PTYPID := '1'
   ENDIF
   ? PTYPID
   ? PadR( PNRID, 11 )
   ? PTYTUB
   ? ' '
   ? PWYMIAR
   ? StrTran( Str( ppodseme * 100, 8 ), ' ', '0' )
   ? StrTran( Str( ppodscho * 100, 8 ), ' ', '0' )
   ? StrTran( Str( ppodszdr * 100, 8 ), ' ', '0' )
   ? StrTran( Str( pwar_pue * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_pur * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_puc * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_puz * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_fue * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_fur * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_fuw * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_pf3 * 100, 7 ), ' ', '0' )
   ? StrTran( Str( pwar_sum * 100, 8 ), ' ', '0' )
   ? StrTran( Str( pilosorodz, 2 ), ' ', '0' )
   ? StrTran( Str( pwarrodz * 100, 7 ), ' ', '0' )
   ? '0000000'
   ? StrTran( Str( pilosopiel, 2 ), ' ', '0' )
   ? StrTran( Str( pwarpiel * 100, 7 ), ' ', '0' )
   ? StrTran( Str( psum_zas * 100, 8 ), ' ', '0' )
   ? '  '
   ? '  '
   ? PKODSKLA
   IF DToC( PDATA ) == '    .  .  '
      ? '        '
      ? '        '
   ELSE
      ? '01' + SubStr( DToS( PDATA ), 5, 2 ) + SubStr( DToS( PDATA ), 1, 4 )
      ? SubStr( DToS( PDATA ), 7, 2 ) + SubStr( DToS( PDATA ), 5, 2 ) + SubStr( DToS( PDATA ), 1, 4 )
   ENDIF
   ? StrTran( Str( pzasad * 100, 8 ), ' ', '0' )
   IF ppremia # 0
      ? '21'
      ? '01' + SubStr( DToS( PDATA ), 5, 2 ) + SubStr( DToS( PDATA ), 1, 4 )
      ? SubStr( DToS( PDATA ), 7, 2 ) + SubStr( DToS( PDATA ), 5, 2 ) + SubStr( DToS( PDATA ), 1, 4 )
      ? StrTran( Str( ppremia * 100, 8 ), ' ', '0' )
   ELSE
      ? '  '
      ? '        '
      ? '        '
      ? '        '
   ENDIF
   IF pinne # 0
      ? '50'
      ? '01' + SubStr( DToS( PDATA ), 5, 2 ) + SubStr( DToS( PDATA ), 1, 4 )
      ? SubStr( DToS( PDATA ), 7, 2 ) + SubStr( DToS( PDATA ), 5, 2 ) + SubStr( DToS( PDATA ), 1, 4 )
      ? StrTran( Str( pinne * 100, 8 ), ' ', '0' )
   ELSE
      ? '  '
      ? '        '
      ? '        '
      ? '        '
   ENDIF
   ? '  '
   ? '        '
   ? '        '
   ? '        '
   ? '  '
   ? '        '
   ? '        '
   ? '        '
   ? '  '
   ? '        '
   ? '        '
   ? '        '
   ? '  '
   ? '        '
   ? '        '
   ? '        '
   ? '  '
   ? '        '
   ? '        '
   ? '        '
   ? '  '
   ? '        '
   ? '        '
   ? '        '
   ? '  '
   ? '        '
   ? '        '
   ? '        '
   ? StrTran( Str( psumskla * 100, 9 ), ' ', '0' )
   ? repl( '0', 16 )
   ? repl( '0', 16 )
   ? '  '
   ? '</DDORNA>'

   RETURN

*±±±±±± DDORZA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DDORZA( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PPODSTAWA, PSUMSKLA )

   ? '<DDORZA>'
   ? lat_iso( PadR( PNAZWISKO, 31 ) )
   ? lat_iso( PadR( PIMIE, 22 ) )
   ? PTYPID
   ? PadR( PNRID, 11 )
   ? PTYTUB
   ? StrTran( Str( ppodstawa * 100, 8 ), ' ', '0' )
   ? StrTran( Str( psumskla * 100, 7 ), ' ', '0' )
   ? repl( '0', 16 )
   ? repl( '0', 16 )
   ? '  '
   ? '</DDORZA>'

   RETURN

*±±±±±± DEOZ     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DEOZ( PIMIE2, PNAZW_RODU, POBYWATEL, PPLEC )

   ? '<DEOZ>'
   ? lat_iso( padr( PIMIE2, 22 ) )
   ? lat_iso( padr( PNAZW_RODU, 31 ) )
   ? lat_iso( padr( POBYWATEL, 22 ) )
   ? PPLEC
   ? ' '
   ? ' '
   ? '</DEOZ>'

   RETURN

*±±±±±± DEPL     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DEPL( PIMIE2, PMIEJSC_UR, POBYWATEL )

   ? '<DEPL>'
   ? lat_iso( PadR( PIMIE2, 22 ) )
   ? lat_iso( PadR( PMIEJSC_UR, 26 ) )
   ? lat_iso( PadR( POBYWATEL, 22 ) )
   ? '</DEPL>'

   RETURN

*±±±±±± DIPL     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DIPL( PNIP, PREGON, PPESEL, PRODZ_DOK, PDOWOD_OSOB, PSKROT, PNAZWISKO, ;
     PIMIE, PDATA_UR )

   ? '<DIPL>'
   ? PadR( StrTran( PNIP, '-', '' ), 10 )
   ? PadR( SubStr( StrTran( PREGON, '-', '' ), 1, 9 ), 14 )
   ? PadR( PPESEL, 11 )
   ? iif( Empty( PDOWOD_OSOB ), ' ', iif( PRODZ_DOK = 'D', '1', iif( PRODZ_DOK = 'P', '2', ' ' ) ) )
   ? PadR( PDOWOD_OSOB, 9 )
   ? lat_iso( padr( qq( PSKROT ), 31 ) )
   ? lat_iso( padr( PNAZWISKO, 31 ) )
   ? lat_iso( padr( PIMIE, 22 ) )
   ? SubStr( DToS( PDATA_UR ), 7, 2 ) + SubStr( DToS( PDATA_UR ), 5, 2 ) + SubStr( DToS( PDATA_UR ), 1, 4 )
   ? Space( 16 )
   ? Space( 16 )
   ? '  '
   ? '</DIPL>'

   RETURN

*±±±±±± DOBR     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOBR( PNIP, PREGON, PSKROT )

   ? '<DOBR>'
   ? PadR( StrTran( PNIP, '-', '' ), 10 )
   ? PadR( SubStr( StrTran( PREGON, '-', '' ), 1, 9 ), 14 )
   ? lat_iso( PadR( qq( PSKROT ), 31 ) )
   ? Space( 16 )
   ? Space( 16 )
   ? '  '
   ? '</DOBR>'

   RETURN

*±±±±±± DOBU     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOBU()

   ? '<DOBU>'
   ? ' '
   ? Space( 8 )
   ? ' '
   ? Space( 8 )
   ? ' '
   ? Space( 8 )
   ? '</DOBU>'

   RETURN

*±±±±±± DOCRA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOCRA()

   ? '<DOCRA>'
   ? ' '
   ? Space( 8 )
   ? Space( 11 )
   ? Space( 10 )
   ? Space( 1 )
   ? Space( 9 )
   ? Space( 31 )
   ? Space( 22 )
   ? Space( 8 )
   ? '  '
   ? ' '
   ? ' '
   ? ' '
   ? Space( 5 )
   ? Space( 26 )
   ? Space( 26 )
   ? Space( 30 )
   ? Space( 7 )
   ? Space( 7 )
   ? Space( 12 )
   ? Space( 12 )
   ? repl( '0', 16 )
   ? repl( '0', 16 )
   ? '00'
   ? '</DOCRA>'

   RETURN

*±±±±±± DOCRBA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOCRBA()

   ? '<DOCRBA>'
   ? ' '
   ? Space( 8 )
   ? Space( 11 )
   ? Space( 10 )
   ? Space( 1 )
   ? Space( 9 )
   ? Space( 31 )
   ? Space( 22 )
   ? Space( 8 )
   ? '  '
   ? ' '
   ? ' '
   ? ' '
   ? repl( '0', 16 )
   ? repl( '0', 16 )
   ? '00'
   ? '</DOCRBA>'

   RETURN

*±±±±±± DODU   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DODU()

   ? '<DODU>'
   ? Space( 8 )
   ? Space( 9 )
   ? '</DODU>'

   RETURN

*±±±±±± DOKC     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOKC( PKOD_KASY )

   ? '<DOKC>'
   ? PKOD_KASY
   DO CASE
   CASE PKOD_KASY = '01R'
      ? lat_iso( PadR( 'DOLNOóL§SKA RKCH', 23 ) )
   CASE PKOD_KASY = '02R'
      ? lat_iso( PadR( 'KUJAWSKO-POMORSKA RKCH', 23 ) )
   CASE PKOD_KASY = '03R'
      ? lat_iso( PadR( 'LUBELSKA RKCH', 23 ) )
   CASE PKOD_KASY = '04R'
      ? lat_iso( PadR( 'LUBUSKA RKCH', 23 ) )
   CASE PKOD_KASY = '05R'
      ? lat_iso( PadR( 'ù‡DZKA RKCH', 23 ) )
   CASE PKOD_KASY = '06R'
      ? lat_iso( PadR( 'MAùOPOLSKA RKCH', 23 ) )
   CASE PKOD_KASY = '07R'
      ? lat_iso( PadR( 'MAZOWIECKA RKCH', 23 ) )
   CASE PKOD_KASY = '08R'
      ? lat_iso( PadR( 'OPOLSKA RKCH', 23 ) )
   CASE PKOD_KASY = '09R'
      ? lat_iso( PadR( 'PODKARPACKA RKCH', 23 ) )
   CASE PKOD_KASY = '10R'
      ? lat_iso( PadR( 'PODLASKA RKCH', 23 ) )
   CASE PKOD_KASY = '11R'
      ? lat_iso( PadR( 'POMORSKA RKCH', 23 ) )
   CASE PKOD_KASY = '12R'
      ? lat_iso( PadR( 'óL§SKA RKCH', 23 ) )
   CASE PKOD_KASY = '13R'
      ? lat_iso( PadR( 'óWI®TOKRZYSKA RKCH', 23 ) )
   CASE PKOD_KASY = '14R'
      ? lat_iso( PadR( 'WARMI„SKO-MAZURSKA RKCH', 23 ) )
   CASE PKOD_KASY = '15R'
      ? lat_iso( PadR( 'WIELKOPOLSKA RKCH', 23 ) )
   CASE PKOD_KASY = '16R'
      ? lat_iso( PadR( 'ZACHODNIOPOMORSKA RKCH', 23 ) )
   CASE PKOD_KASY = '17R'
      ? lat_iso( PadR( 'BKCH SùUΩB MUNDUROWYCH', 23 ) )
   OTHERWISE
      ? Space( 23 )
   ENDCASE
   ? '        '
   ? '</DOKC>'

   RETURN

*±±±±±± DOOU     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOOU()

   ? '<DOOU>'
   ? '        '
   ? '</DOOU>'

   RETURN

*±±±±±± DORB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DORB( PKONTO )

   ? '<DORB>'
   *PKONTO=iif(substr(PKONTO,9,1)='-',substr(PKONTO,1,8)+substr(PKONTO,10),PKONTO)
   ? lat_iso( PadR( PKONTO, 36 ) )
   ? ' '
   ? '</DORB>'

   RETURN

*±±±±±± DORCA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DORCA( PMM, PRRRR, PSUMA )

   ? '<DORCA>'
   ? '01' + StrTran( pmm, ' ', '0' ) + prrrr
   ? '00001'
   ? repl( '0', 9 )
   ? StrTran( Str( psuma * 100, 9 ), ' ', '0' )
   ? '</DORCA>'

   RETURN

*±±±±±± DORNA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DORNA( PMM, PRRRR, PSUMA )

   ? '<DORNA>'
   ? '01' + StrTran( pmm, ' ', '0' ) + prrrr
   ? '00001'
   ? repl( '0', 10 )
   ? StrTran( Str( psuma * 100, 10 ), ' ', '0' )
   ? '</DORNA>'

   RETURN

*±±±±±± DORZA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DORZA( PMM, PRRRR, PSUMA )

   ? '<DORZA>'
   ? '01' + StrTran( pmm, ' ', '0' ) + prrrr
   ? '0001'
   ? repl( '0', 8 )
   ? StrTran( Str( psuma * 100, 8 ), ' ', '0' )
   ? '</DORZA>'

   RETURN

*±±±±±± DOWP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOWP( PWYMIAR, PUE, PUR, PUC, PUW )

   ? '<DOWP>'
   ? PWYMIAR
   ? '        '
   ? PadR( PUE, 1 )
   ? PadR( PUR, 1 )
   ? PadR( PUC, 1 )
   ? PadR( PUW, 1 )
   ? '</DOWP>'

   RETURN

*±±±±±± DOZCBA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOZCBA()

   ? '<DOZCBA>'
   ? Space( 8 )
   ? Space( 6 )
   ? '</DOZCBA>'

   RETURN

*±±±±±± DOZPF    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOZPF()

   ? '<DOZPF>'
   ? 'X'
   ? ' '
   ? Space( 8 )
   ? Space( 6 )
   ? '</DOZPF>'

   RETURN

*±±±±±± DOZUA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOZUA()

   ? '<DOZUA>'
   ? 'X'
   ? ' '
   ? ' '
   ? Space( 8 )
   ? Space( 6 )
   ? '</DOZUA>'

   RETURN

*±±±±±± IDO1     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE IDO1()

   ? '<IDO1>'
   ? ' '
   ? Space( 8 )
   ? Space( 8 )
   ? ' '
   ? '</IDO1>'

   RETURN

*±±±±±± IDOP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE IDOP()

   ? '<IDOP>'
   ? ' '
   ? Space( 8 )
   ? Space( 8 )
   ? Space( 8 )
   ? ' '
   ? '</IDOP>'

   RETURN

*±±±±±± INN7     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE INN7( PILUB, PILET, PSTAW_WYP )

   ? '<INN7>'
   ? StrTran( Str( pilub, 6 ), ' ', '0' )
   ? StrTran( Str( pilet * 100, 8 ), ' ', '0' )
   ? '0'
   ? StrTran( Str( pstaw_wyp * 100, 4 ), ' ', '0' )
   ? '</INN7>'

   RETURN

*±±±±±± IODZ     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE IODZ()

   ? '<IODZ>'
   ? '  '
   ? ' '
   ? '01'
   ? Space( 16 )
   ? Space( 7 )
   ? Space( 6 )
   ? Space( 16 )
   ? '  '
   ? Space( 9 )
   ? Space( 16 )
   ? '</IODZ>'

   RETURN

*±±±±±± KNDK     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE KNDK()

   ? '<KNDK>'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '00000000000'
   ? '</KNDK>'

   RETURN

*±±±±±± LSKD     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE LSKD( PWAR_PUZ )

   ? '<LSKD>'
   ? '000000000000'
   ? '</LSKD>'

   RETURN

*±±±±±± OPL1     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE OPL1()

   ? '<OPL1>'
   ? '        '
   ? '</OPL1>'

   RETURN

*±±±±±± OPL2     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE OPL2()

   ? '<OPL2>'
   ? '   '
   ? '   '
   ? '        '
   ? '</OPL2>'

   RETURN

*±±±±±± OPLR     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE OPLR( PDATA )

   ? '<OPLR>'
   ? '        '
   ? '</OPLR>'

   RETURN

*±±±±±± OPLS     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE OPLS()

   ?     '<OPLS>'
   ?'     '
   ?'     '
   ?'     '
   ?'     '
   ?'     '
   ?'     '
   ?'        '
   ?'        '
   ?    '</OPLS>'

   RETURN

*±±±±±± PPDB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE PPDB( PKOD, PNUMER_REJ, PORGAN, PDATA_REJ, PDATA_ZAL )

   ? '<PPDB>'
   ? PKOD
   ? PadR( PNUMER_REJ, 15 )
   ? lat_iso( PadR( PORGAN, 72 ) )
   ? SubStr( DToS( PDATA_REJ ), 7, 2 ) + SubStr( DToS( PDATA_REJ ), 5, 2 ) + SubStr( DToS( PDATA_REJ ), 1, 4 )
   pdata_zal := iif( DToS( Pdata_zal ) < '19990101', CToD( '1998/12/31' ), pdata_zal )
   ? SubStr( DToS( PDATA_ZAL ), 7, 2 ) + SubStr( DToS( PDATA_ZAL ), 5, 2 ) + SubStr( DToS( PDATA_ZAL ), 1, 4 )
   ? '</PPDB>'

   RETURN

*±±±±±± RIVDRA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE RIVDRA()

   ? '<RIVDRA>'
   ? '00000000000'
   ? '00000000000'
   ? '</RIVDRA>'

   RETURN

*±±±±±± TYUB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE TYUB( PTYTUB )

   ? '<TYUB>'
   ? PTYTUB
   ? Space( 16 )
   ? '</TYUB>'

   RETURN

*±±±±±± ZDRAV    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ZDRAV( PWAR_Pfp, pwar_pfg, psum )

   ? '<ZDRAV>'
   ? StrTran( Str( pwar_pfp * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwar_pfg * 100, 10 ), ' ', '0' )
   ? StrTran( Str( psum * 100, 11 ), ' ', '0' )
   ? '</ZDRAV>'

   RETURN

*±±±±±± ZSDRA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ZSDRA( PWAR_PUZ )

   ? '<ZSDRA>'
   ? StrTran( Str( pwar_puz * 100, 10 ), ' ', '0' )
   ? '0000000000'
   ? '0000000000'
   ? StrTran( Str( pwar_puz * 100, 11 ), ' ', '0' )
   ? '</ZSDRA>'

   RETURN

*±±±±±± ZSDRAI   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ZSDRAI( PSUM_EME, PSUM_REN, PSUMEMEREN, PWAR_PUE, PWAR_PUR, PWARSUMP, ;
   PWAR_FUE, PWAR_FUR, PWARSUMF, PSUM_CHO, PSUM_WYP, PSUMCHOWYP, PWAR_PUC, ;
   PWAR_PUW, PWARSUMPC, PWAR_FUC, PWARSUMFC, PRAZEM )

   ? '<ZSDRAI>'
   ? StrTran( Str( psum_eme * 100, 10 ), ' ', '0' )
   ? StrTran( Str( psum_ren * 100, 10 ), ' ', '0' )
   ? StrTran( Str( psumemeren * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwar_pue * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwar_pur * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwarsump * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwar_fue * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwar_fur * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwarsumf * 100, 10 ), ' ', '0' )
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? StrTran( Str( psum_cho * 100, 10 ), ' ', '0' )
   ? StrTran( Str( psum_wyp * 100, 10 ), ' ', '0' )
   ? StrTran( Str( psumchowyp * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwar_puc * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwar_puw * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwarsumpc * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwar_fuc * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwarsumfc * 100, 10 ), ' ', '0' )
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? StrTran( Str( prazem * 100, 11 ), ' ', '0' )
   ? '</ZSDRAI>'

   RETURN

*±±±±±± ZWDRA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ZWDRA()

   ? '<ZWDRA>'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '00000000000'
   ? '</ZWDRA>'

   RETURN

*±±±±±± LAT_ISO  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION LAT_ISO( lancuch )

   lancuch := StrTran( lancuch, '§', Chr( 161 ) )
   lancuch := StrTran( lancuch, 'è', Chr( 198 ) )
   lancuch := StrTran( lancuch, '®', Chr( 202 ) )
   lancuch := StrTran( lancuch, 'ù', Chr( 163 ) )
   lancuch := StrTran( lancuch, '„', Chr( 209 ) )
   lancuch := StrTran( lancuch, '‡', Chr( 211 ) )
   lancuch := StrTran( lancuch, 'ó', Chr( 166 ) )
   lancuch := StrTran( lancuch, 'Ω', Chr( 175 ) )
   lancuch := StrTran( lancuch, 'ç', Chr( 172 ) )

   RETURN lancuch

*±±±±±± QQ       ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION QQ( lanc )

   lanc := strtran( lanc, '"', ' ' )
   lanc := strtran( lanc, ',', ' ' )
   lanc := strtran( lanc, '/', ' ' )
   lanc := StrTran( lanc, "'", ' ' )

   RETURN lanc

*±±±±±± HI36     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION HI36( _liczba )

   RETURN _int( _liczba / 35 )

*±±±±±± LO36     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION LO36( _liczba )

   RETURN _liczba - ( _int( _liczba / 35 ) * 35 )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± K O N I E C ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
