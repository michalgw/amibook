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

PROCEDURE ZusRSA()

   LOCAL lSpolka, aDane := {}, cEkran, nNumer := 0

   @ 1, 47 SAY '          '

   *############################### OTWARCIE BAZ ###############################

   DO WHILE ! DostepPro( 'FIRMA' )
   ENDDO
   firma->( dbGoto( Val( ident_fir ) ) )
   lSpolka := firma->spolka

   DO WHILE ! DostepPro( 'ETATY', , , , 'ETATY' )
   ENDDO
   etaty->( ordSetFocus( 2 ) )

   IF DostepPro( 'PRAC', , , , 'PRAC' )
      prac->( ordSetFocus( 4 ) )
   ELSE
      dbCloseAll()
      RETURN
   ENDIF

   IF DostepPro( 'NIEOBEC', , , , 'NIEOBEC' )
      nieobec->( ordSetFocus( 2 ) )
      nieobec->( dbSeek( '+' + ident_fir + miesiac ) )
   ELSE
      dbCloseAll()
      RETURN
   ENDIF

   IF DostepPro( 'SPOLKA', , , , 'SPOLKA' )
      spolka->( dbSeek( '+' + ident_fir ) )
   ELSE
      dbCloseAll()
      RETURN
   ENDIF

   IF spolka->del # '+' .OR. spolka->firma # ident_fir
      Kom( 5, '*u', ' Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ' )
      dbCloseAll()
      RETURN
   ENDIF

   DO WHILE ! nieobec->( Eof() ) .AND. nieobec->del == '+' .AND. nieobec->firma == ident_fir .AND. nieobec->mc == miesiac
      IF ! Empty( nieobec->kodzus )
         AAdd( aDane, { nieobec->ident, hb_Date( Val( param_rok ), Val( miesiac ), nieobec->ddod ), hb_Date( Val( param_rok ), Val( miesiac ), nieobec->dddo ), nieobec->kodzus } )
      ENDIF
      nieobec->( dbSkip() )
   ENDDO

   IF Len( aDane ) == 0
      dbCloseAll()
      Kom( 5, '*u', '  Brak urlop¢w z kodem ZUS  ' )
      RETURN
   ENDIF

   @ 3, 42 CLEAR TO 22, 79
   SAVE SCREEN TO cEkran
   *--------------------------------------
   param_zu()
   IF zus_zglo() # 1
      dbCloseAll()
      RETURN
   ENDIF

   SET CONSOLE OFF
   SET DEVICE TO PRINTER
   SET PRINTER ON
   NUFIR := Val( AllTrim( ident_fir ) )
   Nufir1 := HI36( nufir )
   nufir2 := LO36( nufir )
   PLIK_KDU := SubStr( param_rok, 4, 1 ) + ;
      iif( Val( miesiac ) > 9, Chr( 55 + Val( miesiac ) ), AllTrim( miesiac ) ) + ;
      iif( nufir1 > 9, Chr( 55 + nufir1 ), Str( nufir1, 1 ) ) + ;
      iif( nufir2 > 9, Chr( 55 + nufir2 ), Str( nufir2, 1 ) ) + ;
      'B' + ;
      'P' + ;
      '0' + ;
      '0.' + iif( paraz_wer == 2, 'xml', 'kdu' )
   aaaa := AllTrim( paraz_cel ) + PLIK_KDU
   SET PRINTER TO &aaaa

   DO CASE
   CASE miesiac = ' 1' .OR. miesiac = ' 3' .OR. miesiac = ' 5' .OR. miesiac = ' 7' .OR. miesiac = ' 8' .OR. miesiac = '10' .OR. miesiac = '12'
      DAYM := '31'
   CASE miesiac =' 4' .OR. miesiac = ' 6' .OR. miesiac = ' 9' .OR. miesiac = '11'
      DAYM := '30'
   CASE miesiac = ' 2'
      DAYM := '29'
      IF Day( CToD( param_rok + '.' + miesiac + '.' + DAYM ) ) = 0
           DAYM := '28'
      ENDIF
   ENDCASE
   DDAY := CToD( param_rok + '.' + miesiac + '.' + DAYM )

   kedu_pocz()
   dp_pocz( 'RSA' )
   zus_pocz( 'RSA', 1 )
   dorca( miesiac, param_rok, 0 )
   IF lSpolka
      dipl( NormalizujNipPL( firma->nip ), SubStr( firma->nr_regon, 3 ), '', '', '', iif( ! Empty( firma->przedm ), firma->przedm, firma->nazwa_skr ), '', '', CToD( '    /  /  ' ) )
   ELSE
      subim := SubStr( spolka->naz_imie, At( ' ', spolka->naz_imie ) + 1 )
      dipl( NormalizujNipPL( spolka->NIP ), SubStr( firma->NR_REGON, 3 ), spolka->PESEL, spolka->RODZ_DOK, spolka->DOWOD_OSOB, iif( ! Empty( firma->przedm ), firma->przedm, firma->nazwa_skr ), SubStr( spolka->NAZ_IMIE, 1, At( ' ', spolka->NAZ_IMIE ) ), SubStr( subim, 1, At( ' ', subim ) ), spolka->DATA_UR )
   ENDIF
   *dipl() with F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  ')

   AEval( aDane, { | aPoz |

      IF prac->( dbSeek( ident_fir + aPoz[ 1 ] ) ) .AND. etaty->( dbSeek( '+' + ident_fir + miesiac + aPoz[ 1 ] ) )

         nNumer++

         DDORSA( ;
            prac->nazwisko, ;
            prac->imie1, ;
            iif( .NOT. Empty( prac->pesel ), 'P', iif( .NOT. Empty( prac->nip ), 'N', prac->rodz_dok ) ), ;
            iif( .NOT. Empty( prac->pesel ), prac->pesel, iif( .NOT. Empty( prac->nip ), NormalizujNipPL( prac->nip ), prac->dowod_osob ) ), ;
            etaty->kod_tytu, ;
            aPoz[ 4 ], ;
            aPoz[ 2 ], ;
            aPoz[ 3 ], ;
            nNumer )

      ENDiF

   } )

   oplr()
   ZUS_DataUtworzenia( 'XI', 'p1' )
   zus_kon( 'RSA' )
   dp_kon( 'RSA' )
   kedu_kon()
   SET PRINTER TO
   SET CONSOLE ON
   SET PRINTER OFF
   SET DEVICE TO SCREEN

   kedu_rapo( plik_kdu )

   Close_()
   RESTORE SCREEN FROM cEkran

   RETURN

/*----------------------------------------------------------------------*/

