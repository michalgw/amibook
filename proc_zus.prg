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

   IF paraz_wer == 2
      KEDU_POCZ2()
   ELSE
      KEDU_POCZ1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE KEDU_POCZ1()

   ?? "<!DOCTYPE KEDU PUBLIC '-//ZUS//DTD KEDU 1.3//PL'["
   ? "<!ENTITY wersja '001.300'>"
   ? "<!ENTITY strona.kodowa 'ISO 8859-2'>]>"
   ? "<KEDU>"
   ? "<naglowek.KEDU>"
   ? Space( 139 )
   ? "</naglowek.KEDU>"

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE KEDU_POCZ2()

   ?? '<?xml version="1.0" encoding="UTF-8"?>'
   ? '<KEDU wersja_schematu="1" xmlns="http://www.zus.pl/2021/KEDU_5_4" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.zus.pl/2021/KEDU_5_4 kedu_5_4.xsd">'
   ? '  <naglowek.KEDU>'
   ? '    <program>'
   ? '      <producent>GM Systems</producent>'
   ? '      <symbol>AMi-BOOK</symbol>'
   ? '      <wersja>' + wersprog +'</wersja>'
   ? '    </program>'
   ? '    <data_utworzenia_KEDU>' + date2strxml( Date() ) + '</data_utworzenia_KEDU>'
   ? '    <status_kontroli>0</status_kontroli>'
   ? '  </naglowek.KEDU>'

   RETURN

*±±±±±± STOPKA KEDU ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE KEDU_KON()

   IF paraz_wer == 2
      KEDU_KON2()
   ELSE
      KEDU_KON1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE KEDU_KON1()

   ? "<stopka.KEDU>"
   ? "</stopka.KEDU>"
   ? "</KEDU>"

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE KEDU_KON2()

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
   CASE SubStr( plik_k, 5, 1 ) = 'B'
      symfor := 'RSA'
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

*±±±±±± NAGLOWEK ZUS ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ZUS_POCZ( FORMA, nNumer )

   ? '<ZUS' + FORMA + iif( paraz_wer == 2, ' id_dokumentu="' + AllTrim( Str( nNumer ) ) + '"', '' ) + '>'

   RETURN

*±±±±±± STOPKA ZUS ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ZUS_KON( FORMA )

   ? '</ZUS' + FORMA + '>'

   RETURN

*±±±±±± NAGLOWEK DP ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DP_POCZ( FORMA )

   IF paraz_wer == 2
      DP_POCZ2( FORMA )
   ELSE
      DP_POCZ1( FORMA )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DP_POCZ1( FORMA )

   ? '<ZUS' + FORMA + '.DP>'
   ? '<naglowek.DP>'
   ? Space( 245 )
   ? '</naglowek.DP>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DP_POCZ2( FORMA, nIDDok )

   RETURN

*±±±±±± STOPKA DP ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DP_KON( FORMA )

   IF paraz_wer == 2
      DP_KON2( FORMA )
   ELSE
      DP_KON1( FORMA )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DP_KON1( FORMA )

   ? '<stopka.DP>'
   ? '</stopka.DP>'
   ? '</ZUS' + FORMA + '.DP>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DP_KON2( FORMA )

   RETURN

*±±±±±± ZUSWYMIAR    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ZUSWYMIAR( WYML, WYMM )

   IF paraz_wer == 2
      ZUSWYMIAR2( WYML, WYMM )
   ELSE
      ZUSWYMIAR1( WYML, WYMM )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION ZUSWYMIAR1( WYML, WYMM )

   WYMIZUS := StrTran( Str( WYML, 3 ) + Str( WYMM, 3 ), ' ', '0' )
   IF WYMIZUS = '000000'
      WYMIZUS := Space( 6 )
   ENDIF

   RETURN WYMIZUS

/*----------------------------------------------------------------------*/

FUNCTION ZUSWYMIAR2( WYML, WYMM )

   LOCAL WYMIZUS := ''
   IF WYML > 0 .OR. WYMM > 0
      WYMIZUS := '<p1>' + StrTran( Str( WYML, 3 ), ' ' , '0' ) + '</p1><p2>' + StrTran( Str( WYMM, 3 ), ' ' , '0' ) + '</p2>'
   ENDIF

   RETURN WYMIZUS

*±±±±±± ADKB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ADKB()

   IF paraz_wer == 2
      ADKB2()
   ELSE
      ADKB1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ADKB1()

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

/*----------------------------------------------------------------------*/

PROCEDURE ADKB2()

   RETURN

*±±±±±± ADKP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ADKP()

   IF paraz_wer == 2
      ADKP2()
   ELSE
      ADKP1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ADKP1()

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

/*----------------------------------------------------------------------*/

PROCEDURE ADKP2()

   RETURN

*±±±±±± ADZA     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ADZA()

   IF paraz_wer == 2
      ADZA2()
   ELSE
      ADZA1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ADZA1()

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

/*----------------------------------------------------------------------*/

PROCEDURE ADZA2()

   RETURN

*±±±±±± ASPL     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ASPL( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
   PTEL, PFAX )

   IF paraz_wer == 2
      ASPL2( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
         PTEL, PFAX )
   ELSE
      ASPL1( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
         PTEL, PFAX )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ASPL1( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
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

/*----------------------------------------------------------------------*/

PROCEDURE ASPL2( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
   PTEL, PFAX )

   ? '<VI>'
   ? '  <p1>' + str2sxml( StrTran( PKOD_POCZT, '-', '' ) ) + '</p1>'
   ? '  <p2>' + str2sxml( PMIEJSCE ) + '</p2>'
   ? '  <p3>' + str2sxml( PGMINA ) + '</p3>'
   ? '  <p4>' + str2sxml( PULICA ) + '</p4>'
   ? '  <p5>' + str2sxml( PNR_DOMU ) + '</p5>'
   ? '  <p6>' + str2sxml( PNR_LOKAL ) + '</p6>'
   ? '  <p7>' + str2sxml( PTEL ) + '</p7>'
   ? '</VI>'

   RETURN

*±±±±±± ASZP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ASZP( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
   PTEL, PFAX, cNode )

   IF paraz_wer == 2
      ASZP2( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
         PTEL, PFAX, cNode )
   ELSE
      ASZP1( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
         PTEL, PFAX )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ASZP1( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
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

/*----------------------------------------------------------------------*/

PROCEDURE ASZP2( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
   PTEL, PFAX, cNode )

   IF HB_ISCHAR( cNode )
      ? '<' + cNode + '>'
      ? '  <p1>' + str2sxml( StrTran( PKOD_POCZT, '-', '' ) ) + '</p1>'
      ? '  <p2>' + str2sxml( PMIEJSCE ) + '</p2>'
      ? '  <p3>' + str2sxml( PGMINA ) + '</p3>'
      ? '  <p4>' + str2sxml( PULICA ) + '</p4>'
      ? '  <p5>' + str2sxml( PNR_DOMU ) + '</p5>'
      ? '  <p6>' + str2sxml( PNR_LOKAL ) + '</p6>'
      ? '  <p7>' + str2sxml( PTEL ) + '</p7>'
      ? '</' + cNode + '>'
   ENDIF

   RETURN

*±±±±±± AZMO     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE AZMO( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
   PTEL, PFAX )

   IF paraz_wer == 2
      AZMO2( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
         PTEL, PFAX )
   ELSE
      AZMO1( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
         PTEL, PFAX )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE AZMO1( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
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

/*----------------------------------------------------------------------*/

PROCEDURE AZMO2( PKOD_POCZT, PMIEJSCE, PGMINA, PULICA, PNR_DOMU, PNR_LOKAL, ;
   PTEL, PFAX )

   ? '<XI>'
   ? '  <p1>' + str2sxml( StrTran( PKOD_POCZT, '-', '' ) ) + '</p1>'
   ? '  <p2>' + str2sxml( PMIEJSCE ) + '</p2>'
   ? '  <p3>' + str2sxml( PGMINA ) + '</p3>'
   ? '  <p4>' + str2sxml( PULICA ) + '</p4>'
   ? '  <p5>' + str2sxml( PNR_DOMU ) + '</p5>'
   ? '  <p6>' + str2sxml( PNR_LOKAL ) + '</p6>'
   ? '  <p7>' + str2sxml( PTEL ) + '</p7>'
   ? '</XI>'

   RETURN

*±±±±±± DADRA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DADRA( PTERMIN, PMM, PRRRR )

   IF paraz_wer == 2
      DADRA2( PTERMIN, PMM, PRRRR )
   ELSE
      DADRA1( PTERMIN, PMM, PRRRR )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DADRA1( PTERMIN, PMM, PRRRR )

   ? '<DADRA>'
   ? PTERMIN
   ? '01' + StrTran( pmm, ' ', '0' ) + prrrr
   ? Space( 8 )
   ? Space( 6 )
   ? Space( 12 )
   ? '</DADRA>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DADRA2( PTERMIN, PMM, PRRRR )

   ? '<I>'
   ? '  <p1>' + PTERMIN + '</p1>'
   ? '  <p2><p1>01</p1><p2>' + prrrr + '-' + StrTran( pmm, ' ', '0' ) + '</p2></p2>'
   ? '</I>'

   RETURN

*±±±±±± DAIP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DAIP( PNIP, PREGON, PSKROT )

   IF paraz_wer == 2
      DAIP2( PNIP, PREGON, PSKROT )
   ELSE
      DAIP1( PNIP, PREGON, PSKROT )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DAIP1( PNIP, PREGON, PSKROT )

   ? '<DAIP>'
   ? PadR( StrTran( PNIP, '-', '' ), 10 )
   ? PadR( SubStr( StrTran( PREGON, '-', '' ), 1, 9 ), 14 )
   ? lat_iso( PadR( qq( PSKROT ), 31 ) )
   ? Space( 16 )
   ? Space( 16 )
   ? '  '
   ? '</DAIP>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DAIP2( PNIP, PREGON, PSKROT )

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

   IF paraz_wer == 2
      DAPL2( PNAZWA, PDATA_REJ, PNUMER_REJ, PORGAN, PDATA_ZAL )
   ELSE
      DAPL1( PNAZWA, PDATA_REJ, PNUMER_REJ, PORGAN, PDATA_ZAL )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DAPL1( PNAZWA, PDATA_REJ, PNUMER_REJ, PORGAN, PDATA_ZAL )

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

/*----------------------------------------------------------------------*/

PROCEDURE DAPL2( PNAZWA, PDATA_REJ, PNUMER_REJ, PORGAN, PDATA_ZAL )

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

   IF paraz_wer == 2
      DAU2( PPESEL, PNIP, PRODZ_DOK, PDOWOD_OSOB, PNAZWISKO, PIMIE, PDATA_UR )
   ELSE
      DAU1( PPESEL, PNIP, PRODZ_DOK, PDOWOD_OSOB, PNAZWISKO, PIMIE, PDATA_UR )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DAU1( PPESEL, PNIP, PRODZ_DOK, PDOWOD_OSOB, PNAZWISKO, PIMIE, PDATA_UR )

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

/*----------------------------------------------------------------------*/

PROCEDURE DAU2( PPESEL, PNIP, PRODZ_DOK, PDOWOD_OSOB, PNAZWISKO, PIMIE, PDATA_UR )

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

   IF paraz_wer == 2
      DDDU2( PTYT, PPODS, PPODSZDR )
   ELSE
      DDDU1( PTYT, PPODS, PPODSZDR )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DDDU1( PTYT, PPODS, PPODSZDR )

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

/*----------------------------------------------------------------------*/

PROCEDURE DDDU2( PTYT, PPODS, PPODSZDR )

   IF .NOT. Empty( ptyt )
      ? '<X>'
      ? '  <p1>' + ZUS_KodTytulu( ptyt ) + '</p1>'
      ? '  <p2>' + TKwota2( ppods ) + '</p2>'
      ? '  <p3>' + TKwota2( ppods ) + '</p3>'
      ? '  <p4>' + TKwota2( ppods ) + '</p4>'
      ? '  <p5>' + TKwota2( ppodszdr ) + '</p5>'
      ? '</X>'
   ENDIF

   RETURN

*±±±±±± DDORCA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DDORCA( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
   PPODSCHO, PPODSZDR, PWAR_PUE, PWAR_PUR, PWAR_PUC, PWAR_PUZ, PWAR_FUE, ;
   PWAR_FUR, PWAR_FUW, PWAR_PF3, PWAR_SUM, PILOSORODZ, PWARRODZ, PILOSOPIEL, ;
   PWARPIEL, PSUM_ZAS, nNumer, nRodzaj, nDochodPop, nDochodPopRok )

   IF paraz_wer == 2
      DDORCA2( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
         PPODSCHO, PPODSZDR, PWAR_PUE, PWAR_PUR, PWAR_PUC, PWAR_PUZ, PWAR_FUE, ;
         PWAR_FUR, PWAR_FUW, PWAR_PF3, PWAR_SUM, PILOSORODZ, PWARRODZ, PILOSOPIEL, ;
         PWARPIEL, PSUM_ZAS, nNumer, nRodzaj, nDochodPop, nDochodPopRok )
   ELSE
      DDORCA1( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
         PPODSCHO, PPODSZDR, PWAR_PUE, PWAR_PUR, PWAR_PUC, PWAR_PUZ, PWAR_FUE, ;
         PWAR_FUR, PWAR_FUW, PWAR_PF3, PWAR_SUM, PILOSORODZ, PWARRODZ, PILOSOPIEL, ;
         PWARPIEL, PSUM_ZAS )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DDORCA1( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
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

/*----------------------------------------------------------------------*/

PROCEDURE DDORCA2( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
   PPODSCHO, PPODSZDR, PWAR_PUE, PWAR_PUR, PWAR_PUC, PWAR_PUZ, PWAR_FUE, ;
   PWAR_FUR, PWAR_FUW, PWAR_PF3, PWAR_SUM, PILOSORODZ, PWARRODZ, PILOSOPIEL, ;
   PWARPIEL, PSUM_ZAS, nNumer, nRodzaj, nDochodPop, nDochodPopRok )

   LOCAL cTmp

   ? '<III id_bloku="' + AllTrim( Str( nNumer ) ) + '">'
   ? '  <A>'
   ? '    <p1>' + str2sxml( PNAZWISKO ) + '</p1>'
   ? '    <p2>' + str2sxml( PIMIE ) + '</p2>'
   ? '    <p3>' + PTYPID + '</p3>'
   ? '    <p4>' + AllTrim( PNRID ) + '</p4>'
   ? '  </A>'
   ? '  <B>'
   IF ( cTmp := ZUS_KodTytulu( PTYTUB ) ) <> ""
      ? '    <p1>' + cTmp + '</p1>'
   ENDIF
   IF ! Empty( PWYMIAR )
      ? '    <p3>' + PWYMIAR + '</p3>'
   ENDIF
   ? '    <p4>' + TKwota2( ppodseme ) + '</p4>'
   ? '    <p5>' + TKwota2( ppodscho ) + '</p5>'
   //? '    <p6>' + TKwota2( ppodszdr ) + '</p6>'
   ? '    <p6>' + TKwota2( ppodscho ) + '</p6>'
   ? '    <p7>' + TKwota2( pwar_pue ) + '</p7>'
   ? '    <p8>' + TKwota2( pwar_pur ) + '</p8>'
   ? '    <p9>' + TKwota2( pwar_puc ) + '</p9>'
   ? '    <p10>0.00</p10>'
   //? '    <p10>' + TKwota2( pwar_puz ) + '</p10>'
   ? '    <p11>' + TKwota2( pwar_fue ) + '</p11>'
   ? '    <p12>' + TKwota2( pwar_fur ) + '</p12>'
   ? '    <p13>0.00</p13>'
   ? '    <p14>' + TKwota2( pwar_fuw ) + '</p14>'
   ? '    <p15>0.00</p15>'
   ? '    <p16>0.00</p16>'
   ? '    <p17>0.00</p17>'
   ? '    <p18>0.00</p18>'
   ? '    <p19>0.00</p19>'
   ? '    <p20>0.00</p20>'
   ? '    <p21>0.00</p21>'
   ? '    <p22>0.00</p22>'
   ? '    <p23>0.00</p23>'
   ? '    <p24>0.00</p24>'
   ? '    <p25>0.00</p25>'
   ? '    <p26>0.00</p26>'
   ? '    <p27>0.00</p27>'
   ? '    <p28>0.00</p28>'
   ? '    <p29>' + TKwota2( pwar_sum ) + '</p29>'
   ? '  </B>'
   ? '  <C>'
   ? '    <p1>' + TKwota2( ppodszdr ) + '</p1>'
   ? '    <p2>0.00</p2>'
   ? '    <p3>0.00</p3>'
   ? '    <p4>' + TKwota2( pwar_puz ) + '</p4>'
   ? '    <p5>0.00</p5>'
   ? '  </C>'
   ? '  <D>'
   ? '    <p4>0.00</p4>'
   ? '  </D>'
   IF ! Empty( nRodzaj )
      ZUS_FormaOpodat( nRodzaj, ppodszdr, pwar_puz, nDochodPop, nDochodPopRok, 'E' )
      /*
      ? '  <E>'
      DO CASE
      CASE nRodzaj == 1  // Zasady ogolne
         ? '    <p1>true</p1>'
         ? '    <p2>' + TKwota2( nDochodPop ) + '</p2>'
         ? '    <p3>' + TKwota2( ppodszdr ) + '</p3>'
         ? '    <p4>' + TKwota2( pwar_puz ) + '</p4>'
      CASE nRodzaj == 2  // Liniowo
         ? '    <p5>true</p5>'
         ? '    <p6>' + TKwota2( nDochodPop ) + '</p6>'
         ? '    <p7>' + TKwota2( ppodszdr ) + '</p7>'
         ? '    <p8>' + TKwota2( pwar_puz ) + '</p8>'
      CASE nRodzaj == 3  // Ryczalt
         ? '    <p12>true</p12>'
         ? '    <p13>' + TKwota2( nDochodPop ) + '</p13>'
      CASE nRodzaj == 4  // Ryczalt na podstawie dochodu za poprzedni rok
         ? '    <p14>true</p14>'
         ? '    <p15>' + TKwota2( nDochodPopRok ) + '</p15>'
         ? '    <p16>' + TKwota2( ppodszdr ) + '</p16>'
         ? '    <p17>' + TKwota2( pwar_puz ) + '</p17>'
      ENDCASE
      ? '  </E>'
      */
   ENDIF
   ? '</III>'

   RETURN

*±±±±±± DDORNA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DDORNA( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
   PPODSCHO, PPODSZDR, PWAR_PUE, PWAR_PUR, PWAR_PUC, PWAR_PUZ, PWAR_FUE, ;
   PWAR_FUR, PWAR_FUW, PWAR_PF3, PWAR_SUM, PILOSORODZ, PWARRODZ, PILOSOPIEL, ;
   PWARPIEL, PSUM_ZAS, PDATA, PZASAD, PPREMIA, PINNE, PSUMSKLA, PKODSKLA )

   IF paraz_wer == 2
      DDORNA2( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
         PPODSCHO, PPODSZDR, PWAR_PUE, PWAR_PUR, PWAR_PUC, PWAR_PUZ, PWAR_FUE, ;
         PWAR_FUR, PWAR_FUW, PWAR_PF3, PWAR_SUM, PILOSORODZ, PWARRODZ, PILOSOPIEL, ;
         PWARPIEL, PSUM_ZAS, PDATA, PZASAD, PPREMIA, PINNE, PSUMSKLA, PKODSKLA )
   ELSE
      DDORNA1( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
         PPODSCHO, PPODSZDR, PWAR_PUE, PWAR_PUR, PWAR_PUC, PWAR_PUZ, PWAR_FUE, ;
         PWAR_FUR, PWAR_FUW, PWAR_PF3, PWAR_SUM, PILOSORODZ, PWARRODZ, PILOSOPIEL, ;
         PWARPIEL, PSUM_ZAS, PDATA, PZASAD, PPREMIA, PINNE, PSUMSKLA, PKODSKLA )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DDORNA1( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
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

/*----------------------------------------------------------------------*/

PROCEDURE DDORNA2( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PWYMIAR, PPODSEME, ;
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

   IF paraz_wer == 2
      DDORZA2( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PPODSTAWA, PSUMSKLA )
   ELSE
      DDORZA1( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PPODSTAWA, PSUMSKLA )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DDORZA1( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PPODSTAWA, PSUMSKLA )

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

/*----------------------------------------------------------------------*/

PROCEDURE DDORZA2( PNAZWISKO, PIMIE, PTYPID, PNRID, PTYTUB, PPODSTAWA, PSUMSKLA )

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

   IF paraz_wer == 2
      DEOZ2( PIMIE2, PNAZW_RODU, POBYWATEL, PPLEC )
   ELSE
      DEOZ1( PIMIE2, PNAZW_RODU, POBYWATEL, PPLEC )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DEOZ1( PIMIE2, PNAZW_RODU, POBYWATEL, PPLEC )

   ? '<DEOZ>'
   ? lat_iso( padr( PIMIE2, 22 ) )
   ? lat_iso( padr( PNAZW_RODU, 31 ) )
   ? lat_iso( padr( POBYWATEL, 22 ) )
   ? PPLEC
   ? ' '
   ? ' '
   ? '</DEOZ>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DEOZ2( PIMIE2, PNAZW_RODU, POBYWATEL, PPLEC )

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

   IF paraz_wer == 2
      DEPL2( PIMIE2, PMIEJSC_UR, POBYWATEL )
   ELSE
      DEPL1( PIMIE2, PMIEJSC_UR, POBYWATEL )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DEPL1( PIMIE2, PMIEJSC_UR, POBYWATEL )

   ? '<DEPL>'
   ? lat_iso( PadR( PIMIE2, 22 ) )
   ? lat_iso( PadR( PMIEJSC_UR, 26 ) )
   ? lat_iso( PadR( POBYWATEL, 22 ) )
   ? '</DEPL>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DEPL2( PIMIE2, PMIEJSC_UR, POBYWATEL )

   ? '<DEPL>'
   ? lat_iso( PadR( PIMIE2, 22 ) )
   ? lat_iso( PadR( PMIEJSC_UR, 26 ) )
   ? lat_iso( PadR( POBYWATEL, 22 ) )
   ? '</DEPL>'

   RETURN

*±±±±±± DIPL     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DIPL( PNIP, PREGON, PPESEL, PRODZ_DOK, PDOWOD_OSOB, PSKROT, PNAZWISKO, ;
   PIMIE, PDATA_UR )

   IF paraz_wer == 2
      DIPL2( PNIP, PREGON, PPESEL, PRODZ_DOK, PDOWOD_OSOB, PSKROT, PNAZWISKO, ;
         PIMIE, PDATA_UR )
   ELSE
      DIPL1( PNIP, PREGON, PPESEL, PRODZ_DOK, PDOWOD_OSOB, PSKROT, PNAZWISKO, ;
         PIMIE, PDATA_UR )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DIPL1( PNIP, PREGON, PPESEL, PRODZ_DOK, PDOWOD_OSOB, PSKROT, PNAZWISKO, ;
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

/*----------------------------------------------------------------------*/

PROCEDURE DIPL2( PNIP, PREGON, PPESEL, PRODZ_DOK, PDOWOD_OSOB, PSKROT, PNAZWISKO, ;
   PIMIE, PDATA_UR )

   ? '<II>'
   IF ! Empty( PNIP )
      ? '  <p1>' + AllTrim( StrTran( PNIP, '-', '' ) ) + '</p1>'
   ENDIF
   IF ! Empty( PREGON )
      ? '  <p2>' + AllTrim( SubStr( StrTran( PREGON, '-', '' ), 1, 9 ) ) + '</p2>'
   ENDIF
   IF ! Empty( PPESEL )
      ? '  <p3>' + AllTrim( PPESEL ) + '</p3>'
   ENDIF
   IF ! Empty( PDOWOD_OSOB ) .AND. PDOWOD_OSOB $ 'DP'
      ? '  <p4>' + iif( PRODZ_DOK = 'D', '1', '2' ) + '</p4>'
   ENDIF
   IF ! Empty( PDOWOD_OSOB )
      ? '  <p5>' + AllTrim( PDOWOD_OSOB ) + '</p5>'
   ENDIF
   IF ! Empty( PSKROT  )
      ? '  <p6>' + str2sxml( SubStr( PSKROT, 1, 31 ) ) + '</p6>'
   ENDIF
   IF ! Empty( PNAZWISKO )
      ? '  <p7>' + str2sxml( PNAZWISKO ) + '</p7>'
   ENDIF
   IF ! Empty( PIMIE )
      ? '  <p8>' + str2sxml( PIMIE ) + '</p8>'
   ENDIF
   IF ! Empty( PDATA_UR )
      ? '  <p9>' + date2strxml( PDATA_UR ) + '</p9>'
   ENDIF
   ? '</II>'

   RETURN

*±±±±±± DOBR     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOBR( PNIP, PREGON, PSKROT )

   IF paraz_wer == 2
      DOBR2( PNIP, PREGON, PSKROT )
   ELSE
      DOBR1( PNIP, PREGON, PSKROT )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOBR1( PNIP, PREGON, PSKROT )

   ? '<DOBR>'
   ? PadR( StrTran( PNIP, '-', '' ), 10 )
   ? PadR( SubStr( StrTran( PREGON, '-', '' ), 1, 9 ), 14 )
   ? lat_iso( PadR( qq( PSKROT ), 31 ) )
   ? Space( 16 )
   ? Space( 16 )
   ? '  '
   ? '</DOBR>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOBR2( PNIP, PREGON, PSKROT )

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

   IF paraz_wer == 2
      DOBU2()
   ELSE
      DOBU1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOBU1()

   ? '<DOBU>'
   ? ' '
   ? Space( 8 )
   ? ' '
   ? Space( 8 )
   ? ' '
   ? Space( 8 )
   ? '</DOBU>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOBU2()

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

   IF paraz_wer == 2
      DOCRA2()
   ELSE
      DOCRA1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOCRA1()

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

/*----------------------------------------------------------------------*/

PROCEDURE DOCRA2()

   RETURN

*±±±±±± DOCRBA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOCRBA()

   IF paraz_wer == 2
      DOCRBA2()
   ELSE
      DOCRBA1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOCRBA1()

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

/*----------------------------------------------------------------------*/

PROCEDURE DOCRBA2()

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

   IF paraz_wer == 2
      DODU2()
   ELSE
      DODU1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DODU1()

   ? '<DODU>'
   ? Space( 8 )
   ? Space( 9 )
   ? '</DODU>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DODU2()

   ? '<DODU>'
   ? Space( 8 )
   ? Space( 9 )
   ? '</DODU>'

   RETURN

*±±±±±± DOKC     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOKC( PKOD_KASY )

   IF paraz_wer == 2
      DOKC2( PKOD_KASY )
   ELSE
      DOKC1( PKOD_KASY )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOKC1( PKOD_KASY )

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

/*----------------------------------------------------------------------*/

PROCEDURE DOKC2( PKOD_KASY )

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

   IF paraz_wer == 2
      DOOU2()
   ELSE
      DOOU1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOOU1()

   ? '<DOOU>'
   ? '        '
   ? '</DOOU>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOOU2()

   ? '<DOOU>'
   ? '        '
   ? '</DOOU>'

   RETURN

*±±±±±± DORB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DORB( PKONTO )

   IF paraz_wer == 2
      DORB2( PKONTO )
   ELSE
      DORB1( PKONTO )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DORB1( PKONTO )

   ? '<DORB>'
   *PKONTO=iif(substr(PKONTO,9,1)='-',substr(PKONTO,1,8)+substr(PKONTO,10),PKONTO)
   ? lat_iso( PadR( PKONTO, 36 ) )
   ? ' '
   ? '</DORB>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DORB2( PKONTO )

   ? '<DORB>'
   *PKONTO=iif(substr(PKONTO,9,1)='-',substr(PKONTO,1,8)+substr(PKONTO,10),PKONTO)
   ? lat_iso( PadR( PKONTO, 36 ) )
   ? ' '
   ? '</DORB>'

   RETURN

*±±±±±± DORCA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DORCA( PMM, PRRRR, PSUMA )

   IF paraz_wer == 2
      DORCA2( PMM, PRRRR, PSUMA )
   ELSE
      DORCA1( PMM, PRRRR, PSUMA )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DORCA1( PMM, PRRRR, PSUMA )

   ? '<DORCA>'
   ? '01' + StrTran( pmm, ' ', '0' ) + prrrr
   ? '00001'
   ? repl( '0', 9 )
   ? StrTran( Str( psuma * 100, 9 ), ' ', '0' )
   ? '</DORCA>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DORCA2( PMM, PRRRR, PSUMA )

   ? '<I>'
   ? '  <p1>'
   ? '    <p1>01</p1>'
   ? '    <p2>' + prrrr + '-' + StrTran( pmm, ' ', '0' ) + '</p2>'
   ? '  </p1>'
   ? '</I>'

   RETURN

*±±±±±± DORNA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DORNA( PMM, PRRRR, PSUMA )

   IF paraz_wer == 2
      DORNA2( PMM, PRRRR, PSUMA )
   ELSE
      DORNA1( PMM, PRRRR, PSUMA )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DORNA1( PMM, PRRRR, PSUMA )

   ? '<DORNA>'
   ? '01' + StrTran( pmm, ' ', '0' ) + prrrr
   ? '00001'
   ? repl( '0', 10 )
   ? StrTran( Str( psuma * 100, 10 ), ' ', '0' )
   ? '</DORNA>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DORNA2( PMM, PRRRR, PSUMA )

   ? '<DORNA>'
   ? '01' + StrTran( pmm, ' ', '0' ) + prrrr
   ? '00001'
   ? repl( '0', 10 )
   ? StrTran( Str( psuma * 100, 10 ), ' ', '0' )
   ? '</DORNA>'

   RETURN

*±±±±±± DORZA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DORZA( PMM, PRRRR, PSUMA )

   IF paraz_wer == 2
      DORZA2( PMM, PRRRR, PSUMA )
   ELSE
      DORZA1( PMM, PRRRR, PSUMA )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DORZA1( PMM, PRRRR, PSUMA )

   ? '<DORZA>'
   ? '01' + StrTran( pmm, ' ', '0' ) + prrrr
   ? '0001'
   ? repl( '0', 8 )
   ? StrTran( Str( psuma * 100, 8 ), ' ', '0' )
   ? '</DORZA>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DORZA2( PMM, PRRRR, PSUMA )

   ? '<DORZA>'
   ? '01' + StrTran( pmm, ' ', '0' ) + prrrr
   ? '0001'
   ? repl( '0', 8 )
   ? StrTran( Str( psuma * 100, 8 ), ' ', '0' )
   ? '</DORZA>'

   RETURN

*±±±±±± DOWP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOWP( PWYMIAR, PUE, PUR, PUC, PUW )

   IF paraz_wer == 2
      DOWP2( PWYMIAR, PUE, PUR, PUC, PUW )
   ELSE
      DOWP1( PWYMIAR, PUE, PUR, PUC, PUW )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOWP1( PWYMIAR, PUE, PUR, PUC, PUW )

   ? '<DOWP>'
   ? PWYMIAR
   ? '        '
   ? PadR( PUE, 1 )
   ? PadR( PUR, 1 )
   ? PadR( PUC, 1 )
   ? PadR( PUW, 1 )
   ? '</DOWP>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOWP2( PWYMIAR, PUE, PUR, PUC, PUW )

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

   IF paraz_wer == 2
      DOZCBA2()
   ELSE
      DOZCBA1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOZCBA1()

   ? '<DOZCBA>'
   ? Space( 8 )
   ? Space( 6 )
   ? '</DOZCBA>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOZCBA2()

   ? '<DOZCBA>'
   ? Space( 8 )
   ? Space( 6 )
   ? '</DOZCBA>'

   RETURN

*±±±±±± DOZPF    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOZPF()

   IF paraz_wer == 2
      DOZPF2()
   ELSE
      DOZPF1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOZPF1()

   ? '<DOZPF>'
   ? 'X'
   ? ' '
   ? Space( 8 )
   ? Space( 6 )
   ? '</DOZPF>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOZPF2()

   ? '<DOZPF>'
   ? 'X'
   ? ' '
   ? Space( 8 )
   ? Space( 6 )
   ? '</DOZPF>'

   RETURN

*±±±±±± DOZUA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOZUA()

   IF paraz_wer == 2
      DOZUA2()
   ELSE
      DOZUA1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOZUA1()

   ? '<DOZUA>'
   ? 'X'
   ? ' '
   ? ' '
   ? Space( 8 )
   ? Space( 6 )
   ? '</DOZUA>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DOZUA2()

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

   IF paraz_wer == 2
      IDO12()
   ELSE
      IDO11()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE IDO11()

   ? '<IDO1>'
   ? ' '
   ? Space( 8 )
   ? Space( 8 )
   ? ' '
   ? '</IDO1>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE IDO12()

   ? '<IDO1>'
   ? ' '
   ? Space( 8 )
   ? Space( 8 )
   ? ' '
   ? '</IDO1>'

   RETURN

*±±±±±± IDOP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE IDOP()

   IF paraz_wer == 2
      IDOP2()
   ELSE
      IDOP1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE IDOP1()

   ? '<IDOP>'
   ? ' '
   ? Space( 8 )
   ? Space( 8 )
   ? Space( 8 )
   ? ' '
   ? '</IDOP>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE IDOP2()

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

   IF paraz_wer == 2
      INN72( PILUB, PILET, PSTAW_WYP )
   ELSE
      INN71( PILUB, PILET, PSTAW_WYP )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE INN71( PILUB, PILET, PSTAW_WYP )

   ? '<INN7>'
   ? StrTran( Str( pilub, 6 ), ' ', '0' )
   ? StrTran( Str( pilet * 100, 8 ), ' ', '0' )
   ? '0'
   ? StrTran( Str( pstaw_wyp * 100, 4 ), ' ', '0' )
   ? '</INN7>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE INN72( PILUB, PILET, PSTAW_WYP )

   ? '<III>'
   ? '  <p1>' + TNaturalny( pilub ) + '</p1>'
   ? '  <p3>' + TKwota2( pstaw_wyp ) + '</p3>'
   ? '</III>'

   RETURN

*±±±±±± IODZ     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE IODZ()

   IF paraz_wer == 2
      IODZ2()
   ELSE
      IODZ1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE IODZ1()

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

/*----------------------------------------------------------------------*/

PROCEDURE IODZ2()

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

   IF paraz_wer == 2
      KNDK2()
   ELSE
      KNDK1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE KNDK1()

   ? '<KNDK>'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '00000000000'
   ? '</KNDK>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE KNDK2()

   RETURN

*±±±±±± LSKD     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE LSKD( PWAR_PUZ )

   IF paraz_wer == 2
      LSKD2( PWAR_PUZ )
   ELSE
      LSKD1( PWAR_PUZ )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE LSKD1( PWAR_PUZ )

   ? '<LSKD>'
   ? '000000000000'
   ? '</LSKD>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE LSKD2( PWAR_PUZ )

   RETURN

*±±±±±± OPL1     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE OPL1()

   IF paraz_wer == 2
      OPL12()
   ELSE
      OPL11()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE OPL11()

   ? '<OPL1>'
   ? '        '
   ? '</OPL1>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE OPL12()

   ? '<OPL1>'
   ? '        '
   ? '</OPL1>'

   RETURN

*±±±±±± OPL2     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE OPL2()

   IF paraz_wer == 2
      OPL22()
   ELSE
      OPL21()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE OPL21()

   ? '<OPL2>'
   ? '   '
   ? '   '
   ? '        '
   ? '</OPL2>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE OPL22()

   ? '<OPL2>'
   ? '   '
   ? '   '
   ? '        '
   ? '</OPL2>'

   RETURN

*±±±±±± OPLR     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE OPLR( PDATA )

   IF paraz_wer == 2
      OPLR2( PDATA )
   ELSE
      OPLR1( PDATA )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE OPLR1( PDATA )

   ? '<OPLR>'
   ? '        '
   ? '</OPLR>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE OPLR2( PDATA )

   RETURN

*±±±±±± OPLS     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE OPLS()

   IF paraz_wer == 2
      OPLS2()
   ELSE
      OPLS1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE OPLS1()

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

/*----------------------------------------------------------------------*/

PROCEDURE OPLS2()

   RETURN

*±±±±±± PPDB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE PPDB( PKOD, PNUMER_REJ, PORGAN, PDATA_REJ, PDATA_ZAL )

   IF paraz_wer == 2
      PPDB2( PKOD, PNUMER_REJ, PORGAN, PDATA_REJ, PDATA_ZAL )
   ELSE
      PPDB1( PKOD, PNUMER_REJ, PORGAN, PDATA_REJ, PDATA_ZAL )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE PPDB1( PKOD, PNUMER_REJ, PORGAN, PDATA_REJ, PDATA_ZAL )

   ? '<PPDB>'
   ? PKOD
   ? PadR( PNUMER_REJ, 15 )
   ? lat_iso( PadR( PORGAN, 72 ) )
   ? SubStr( DToS( PDATA_REJ ), 7, 2 ) + SubStr( DToS( PDATA_REJ ), 5, 2 ) + SubStr( DToS( PDATA_REJ ), 1, 4 )
   pdata_zal := iif( DToS( Pdata_zal ) < '19990101', CToD( '1998/12/31' ), pdata_zal )
   ? SubStr( DToS( PDATA_ZAL ), 7, 2 ) + SubStr( DToS( PDATA_ZAL ), 5, 2 ) + SubStr( DToS( PDATA_ZAL ), 1, 4 )
   ? '</PPDB>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE PPDB2( PKOD, PNUMER_REJ, PORGAN, PDATA_REJ, PDATA_ZAL )

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

   IF paraz_wer == 2
      RIVDRA2()
   ELSE
      RIVDRA1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE RIVDRA1()

   ? '<RIVDRA>'
   ? '00000000000'
   ? '00000000000'
   ? '</RIVDRA>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE RIVDRA2()

   RETURN

*±±±±±± TYUB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE TYUB( PTYTUB )

   IF paraz_wer == 2
      TYUB2( PTYTUB )
   ELSE
      TYUB1( PTYTUB )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE TYUB1( PTYTUB )

   ? '<TYUB>'
   ? PTYTUB
   ? Space( 16 )
   ? '</TYUB>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE TYUB2( PTYTUB )

   ? '<TYUB>'
   ? PTYTUB
   ? Space( 16 )
   ? '</TYUB>'

   RETURN

*±±±±±± ZDRAV    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ZDRAV( PWAR_Pfp, pwar_pfg, psum )

   IF paraz_wer == 2
      ZDRAV2( PWAR_Pfp, pwar_pfg, psum )
   ELSE
      ZDRAV1( PWAR_Pfp, pwar_pfg, psum )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ZDRAV1( PWAR_Pfp, pwar_pfg, psum )

   ? '<ZDRAV>'
   ? StrTran( Str( pwar_pfp * 100, 10 ), ' ', '0' )
   ? StrTran( Str( pwar_pfg * 100, 10 ), ' ', '0' )
   ? StrTran( Str( psum * 100, 11 ), ' ', '0' )
   ? '</ZDRAV>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ZDRAV2( PWAR_Pfp, pwar_pfg, psum )

   ? '<VII>'
   ? '  <p1>' + TKwota2( pwar_pfp ) + '</p1>'
   ? '  <p2>' + TKwota2( pwar_pfg ) + '</p2>'
   ? '  <p3>' + TKwota2( psum ) + '</p3>'
   ? '</VII>'

   RETURN

*±±±±±± ZSDRA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ZSDRA( PWAR_PUZ )

   IF paraz_wer == 2
      ZSDRA2( PWAR_PUZ )
   ELSE
      ZSDRA1( PWAR_PUZ )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ZSDRA1( PWAR_PUZ )

   ? '<ZSDRA>'
   ? StrTran( Str( pwar_puz * 100, 10 ), ' ', '0' )
   ? '0000000000'
   ? '0000000000'
   ? StrTran( Str( pwar_puz * 100, 11 ), ' ', '0' )
   ? '</ZSDRA>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ZSDRA2( PWAR_PUZ )

   ? '<VI>'
   ? '  <p2>' + TKwota2( pwar_puz ) + '</p2>'
   ? '  <p5>' + TKwota2( pwar_puz ) + '</p5>'
   ? '  <p7>' + TKwota2( pwar_puz ) + '</p7>'
   ? '</VI>'

   RETURN

*±±±±±± ZSDRAI   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ZSDRAI( PSUM_EME, PSUM_REN, PSUMEMEREN, PWAR_PUE, PWAR_PUR, PWARSUMP, ;
   PWAR_FUE, PWAR_FUR, PWARSUMF, PSUM_CHO, PSUM_WYP, PSUMCHOWYP, PWAR_PUC, ;
   PWAR_PUW, PWARSUMPC, PWAR_FUC, PWARSUMFC, PRAZEM, PWAR_FUW )

   IF paraz_wer == 2
      ZSDRAI2( PSUM_EME, PSUM_REN, PSUMEMEREN, PWAR_PUE, PWAR_PUR, PWARSUMP, ;
         PWAR_FUE, PWAR_FUR, PWARSUMF, PSUM_CHO, PSUM_WYP, PSUMCHOWYP, PWAR_PUC, ;
         PWAR_PUW, PWARSUMPC, PWAR_FUC, PWARSUMFC, PRAZEM, PWAR_FUW )
   ELSE
      ZSDRAI1( PSUM_EME, PSUM_REN, PSUMEMEREN, PWAR_PUE, PWAR_PUR, PWARSUMP, ;
         PWAR_FUE, PWAR_FUR, PWARSUMF, PSUM_CHO, PSUM_WYP, PSUMCHOWYP, PWAR_PUC, ;
         PWAR_PUW, PWARSUMPC, PWAR_FUC, PWARSUMFC, PRAZEM )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ZSDRAI1( PSUM_EME, PSUM_REN, PSUMEMEREN, PWAR_PUE, PWAR_PUR, PWARSUMP, ;
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

/*----------------------------------------------------------------------*/

PROCEDURE ZSDRAI2( PSUM_EME, PSUM_REN, PSUMEMEREN, PWAR_PUE, PWAR_PUR, PWARSUMP, ;
   PWAR_FUE, PWAR_FUR, PWARSUMF, PSUM_CHO, PSUM_WYP, PSUMCHOWYP, PWAR_PUC, ;
   PWAR_PUW, PWARSUMPC, PWAR_FUC, PWARSUMFC, PRAZEM, PWAR_FUW )

   ? '<IV>'
   ? '  <p1>' + TKwota2( psum_eme ) + '</p1>'
   ? '  <p2>' + TKwota2( psum_ren ) + '</p2>'
   ? '  <p3>' + TKwota2( psumemeren ) + '</p3>'
   ? '  <p4>' + TKwota2( pwar_pue ) + '</p4>'
   ? '  <p5>' + TKwota2( pwar_pur ) + '</p5>'
   ? '  <p6>' + TKwota2( pwarsump ) + '</p6>'
   ? '  <p7>' + TKwota2( pwar_fue ) + '</p7>'
   ? '  <p8>' + TKwota2( pwar_fur ) + '</p8>'
   ? '  <p9>' + TKwota2( pwarsumf ) + '</p9>'
   ? '  <p19>' + TKwota2( psum_cho ) + '</p19>'
   ? '  <p20>' + TKwota2( psum_wyp ) + '</p20>'
   ? '  <p21>' + TKwota2( psumchowyp ) + '</p21>'
   ? '  <p22>' + TKwota2( pwar_puc ) + '</p22>'
   ? '  <p23>' + TKwota2( pwar_puw ) + '</p23>'
   ? '  <p24>' + TKwota2( psumchowyp ) + '</p24>'
   ? '  <p25>' + TKwota2( pwar_fuw ) + '</p25>'
   ? '  <p26>' + TKwota2( pwar_fuc ) + '</p26>'
   ? '  <p27>' + TKwota2( pwarsumfc ) + '</p27>'
   ? '  <p37>' + TKwota2( prazem ) + '</p37>'
   ? '</IV>'

   RETURN

*±±±±±± ZWDRA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ZWDRA()

   IF paraz_wer == 2
      ZWDRA2()
   ELSE
      ZWDRA1()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ZWDRA1()

   ? '<ZWDRA>'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '0000000000'
   ? '00000000000'
   ? '</ZWDRA>'

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ZWDRA2()

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

/*----------------------------------------------------------------------*/

FUNCTION ZUS_KodTytulu( cKod )

   LOCAL cRes := ""

   IF Len( AllTrim( cKod ) ) == 6
      cRes := '<p1>' + SubStr( cKod, 1, 4 ) + '</p1><p2>' + SubStr( cKod, 5, 1 ) ;
         + '</p2><p3>' + SubStr( cKod, 6, 1 ) + '</p3>'
   ENDIF

   RETURN cRes

/*----------------------------------------------------------------------*/

PROCEDURE ZUS_FormaOpodat( nRodzaj, ppodszdr, pwar_puz, nDochodPop, nDochodPopRok, cTag )

   IF paraz_wer == 2 .AND. ! Empty( nRodzaj )
      ? '<' + cTag + '>'
      DO CASE
      CASE nRodzaj == 1  // Zasady ogolne
         ? '    <p1>true</p1>'
         ? '    <p2>' + TKwota2( nDochodPop ) + '</p2>'
         ? '    <p3>' + TKwota2( ppodszdr ) + '</p3>'
         ? '    <p4>' + TKwota2( pwar_puz ) + '</p4>'
      CASE nRodzaj == 2  // Liniowo
         ? '    <p5>true</p5>'
         ? '    <p6>' + TKwota2( nDochodPop ) + '</p6>'
         ? '    <p7>' + TKwota2( ppodszdr ) + '</p7>'
         ? '    <p8>' + TKwota2( pwar_puz ) + '</p8>'
      CASE nRodzaj == 3  // Ryczalt
         ? '    <p12>true</p12>'
         ? '    <p13>' + TKwota2( nDochodPop ) + '</p13>'
      CASE nRodzaj == 4  // Ryczalt na podstawie dochodu za poprzedni rok
         ? '    <p14>true</p14>'
         ? '    <p15>' + TKwota2( nDochodPopRok ) + '</p15>'
         ? '    <p16>' + TKwota2( ppodszdr ) + '</p16>'
         ? '    <p17>' + TKwota2( pwar_puz ) + '</p17>'
      ENDCASE
      ? '</' + cTag + '>'
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ZUS_DataUtworzenia( cSekcja, cPole, dData )

   IF paraz_wer == 2

      hb_default( @dData, Date() )

      ? '  <' + cSekcja + '>'
      ? '    <' + cPole + '>' + date2strxml( dData ) + '</' + cPole + '>'
      ? '  </' + cSekcja + '>'

   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE DDORSA( cNazwisko, cImie, cTypID, cNrID, cKodTytuluUb, cKodNieob, dDataOd, dDataDo, nNumer )

   LOCAL cTmp

   IF paraz_wer == 2

      ? '<III id_bloku="' + AllTrim( Str( nNumer ) ) + '">'
      ? '  <A>'
      ? '    <p1>' + str2sxml( cNazwisko ) + '</p1>'
      ? '    <p2>' + str2sxml( cImie ) + '</p2>'
      ? '    <p3>' + cTypID + '</p3>'
      ? '    <p4>' + AllTrim( cNrID ) + '</p4>'
      ? '  </A>'
      ? '  <B>'
      IF ( cTmp := ZUS_KodTytulu( cKodTytuluUb ) ) <> ""
         ? '    <p1>' + cTmp + '</p1>'
      ENDIF
      ? '    <p1>' + ZUS_KodTytulu( cKodTytuluUb ) + '</p1>'
      ? '    <p2>' + cKodNieob + '</p2>'
      ? '    <p3>' + date2strxml( dDataOd ) + '</p3>'
      ? '    <p4>' + date2strxml( dDataDo ) + '</p4>'
      ? '  </B>'
      ? '</III>'

   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± K O N I E C ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
