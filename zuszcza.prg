/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Micha� Gawrycki (gmsystems.pl)

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

PROCEDURE ZusZcza( ubezp )

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ;
      ins, nr_rec, wiersz, f10, rec, fou

   @ 1, 47 SAY '          '
   *############################### OTWARCIE BAZ ###############################
   SELECT 6
   IF Dostep( 'FIRMA' )
      GO Val( ident_fir )
   ELSE
      RETURN
   ENDIF
   zspolka := iif( spolka, 'T', 'N' )

   SELECT 3
   DO WHILE .NOT. Dostep( 'ETATY' )
   ENDDO
   SetInd( 'ETATY' )
   SEEK '+' + ident_fir

   SELECT 2
   IF Dostep( 'PRAC' )
      SetInd( 'PRAC' )
      SEEK '+' + ident_fir
   ELSE
      Close_()
      RETURN
   ENDIF

   SELECT 1
   IF Dostep( 'SPOLKA' )
      SetInd( 'SPOLKA' )
      SEEK '+' + ident_fir
   ELSE
      Close_()
      RETURN
   ENDIF
   IF del # '+' .OR. firma # ident_fir
      Kom( 5, '*u', ' Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ' )
      Close_()
      RETURN
   ENDIF

   IF ubezp == 2
      *--------------------------------------
      SELECT firma
      *--------------------------------------
      @ 3, 42 CLEAR TO 22, 79
      IF .NOT. f->spolka
         SELECT spolka
         param_zu()
         jeden := zus_zglo()
         IF jeden # 1
            Close_()
            RETURN
         ENDIF
         SET DEVICE TO PRINTER
         SET CONSOLE OFF
         SET PRINTER ON
         NUFIR := Val( AllTrim( ident_fir ) )
         Nufir1 := HI36( nufir )
         nufir2 := LO36( nufir )
         NUPLA := recno()
         Nupla1 := HI36( nupla )
         nupla2 := LO36( nupla )
         PLIK_KDU := SubStr( param_rok, 4, 1 ) + ;
            '0' + ;
            iif( nufir1 > 9, Chr( 55 + nufir1 ), Str( nufir1, 1 ) ) + ;
            iif( nufir2 > 9, Chr( 55 + nufir2 ), Str( nufir2, 1 ) ) + ;
            '2' + ;
            'W' + ;
            iif( nupla1 > 9, Chr( 55 + nupla1 ), Str( nupla1, 1 ) ) + ;
            iif( nupla2 > 9, Chr( 55 + nupla2 ), Str( nupla2, 1 ) ) + '.kdu'
         aaaa := AllTrim( paraz_cel ) + PLIK_KDU
         SET PRINTER TO &aaaa
         kedu_pocz()
         dp_pocz( 'ZCZA' )
         zus_pocz( 'ZCZA', 1 )
         dozcba()
         *dipl rozne dla spolki i osoby fizycznej
         IF zSPOLKA = 'T'
            dipl( F->NIP, SubStr( F->NR_REGON, 3 ), '', '', '', F->nazwa_skr, '', '', CToD( '    /  /  ' ) )
         ELSE
            subim := SubStr( A->NAZ_IMIE, At( ' ', A->NAZ_IMIE ) + 1 )
            dipl( A->NIP, SubStr( F->NR_REGON, 3 ), A->PESEL, A->RODZ_DOK, A->DOWOD_OSOB, F->nazwa_skr, SubStr( A->NAZ_IMIE, 1, At( ' ', A->NAZ_IMIE ) ), SubStr( subim, 1, At( ' ', subim ) ), A->DATA_UR )
         ENDIF
         subim := substr(NAZ_IMIE,at(' ',NAZ_IMIE)+1)
         *dipl() with A->NIP,'',A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,'',substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR
         dau(A->PESEL,A->NIP,A->RODZ_DOK,A->DOWOD_OSOB,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
         docrba()
         opl1()
         zus_kon( 'ZCZA' )
         dp_kon( 'ZCZA' )
         kedu_kon()
         SET PRINTER TO
         SET CONSOLE ON
         SET PRINTER OFF
         SET DEVICE TO SCREEN
         kedu_rapo( plik_kdu )
         close_()
         RETURN
      ENDIF
      *################################# GRAFIKA ##################################
      ColStd()
      @  3, 44 SAY '            Podatnik:             '
      @  4, 44 SAY '��������������������������������ͻ'
      @  5, 44 SAY '�                                �'
      @  6, 44 SAY '�                                �'
      @  7, 44 SAY '�                                �'
      @  8, 44 SAY '�                                �'
      @  9, 44 SAY '�                                �'
      @ 10, 44 SAY '��������������������������������ͼ'
      *################################# OPERACJE #################################
      *----- parametry ------
      _row_g := 5
      _col_l := 45
      _row_d := 9
      _col_p := 76
      _invers := 'i'
      _curs_l := 0
      _curs_p := 0
      _esc := '27,28,13,1006'
      _top := 'firma#ident_fir'
      _bot := "del#'+'.or.firma#ident_fir"
      _stop := '+' + ident_fir
      _sbot := '+' + ident_fir + '�'
      _proc := 'linia12c()'
      _row := Int( ( _row_g + _row_d ) / 2 )
      _proc_spe := ''
      _disp := .T.
      _cls := ''
      *----------------------
      kl := 0
      DO WHILE kl # 27
         ColSta()
         @ 1, 47 SAY '[F1]-pomoc'
         SET COLOR TO
         SELECT spolka
         _row := wybor( _row )
         kl := LastKey()
         DO CASE
         *################################## ZESTAW_ #################################
         CASE kl == 13 .OR. kl == 1006
            SAVE SCREEN TO scr2
            nr_rec := RecNo()
            param_zu()
            jeden := zus_zglo()
            IF jeden # 1
               Close_()
               RETURN
            ENDIF
            SET DEVICE TO PRINTER
            SET CONSOLE OFF
            SET PRINTER ON
            NUFIR := Val( AllTrim( ident_fir ) )
            Nufir1 := HI36( nufir )
            nufir2 := LO36( nufir )
            NUPLA := RecNo()
            Nupla1 := HI36( nupla )
            nupla2 := LO36( nupla )
            PLIK_KDU := SubStr( param_rok, 4, 1 ) + ;
               '0' + ;
               iif( nufir1 > 9, Chr( 55 + nufir1 ), Str( nufir1, 1 ) ) + ;
               iif( nufir2 > 9, Chr( 55 + nufir2 ), Str( nufir2, 1 ) ) + ;
               '2' + ;
               'W' + ;
               iif( nupla1 > 9, Chr( 55 + nupla1 ), Str( nupla1, 1 ) ) + ;
               iif( nupla2 > 9, Chr( 55 + nupla2 ), Str( nupla2, 1 ) ) + ;
               '.kdu'
            aaaa := alltrim( paraz_cel ) + PLIK_KDU
            SET PRINTER TO &aaaa
            kedu_pocz()
            dp_pocz( 'ZCZA' )
            zus_pocz( 'ZCZA', 1 )
            dozcba()
            *dipl rozne dla spolki i osoby fizycznej
            IF zSPOLKA = 'T'
               dipl( F->NIP, SubStr( F->NR_REGON, 3 ), '', '', '', F->nazwa_skr, '', '', CToD( '    /  /  ' ) )
            ELSE
               subim := SubStr( A->NAZ_IMIE, At( ' ', A->NAZ_IMIE ) + 1 )
               dipl( A->NIP, '', A->PESEL, A->RODZ_DOK, A->DOWOD_OSOB, A->NAZ_IMIE, SubStr( A->NAZ_IMIE, 1, At( ' ', A->NAZ_IMIE ) ), SubStr( subim, 1, At( ' ', subim ) ), A->DATA_UR )
            ENDIF
            subim := SubStr( NAZ_IMIE, At( ' ', NAZ_IMIE ) + 1 )
            *dipl() with A->NIP,'',A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,'',substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR
            dau( A->PESEL, A->NIP, A->RODZ_DOK, A->DOWOD_OSOB, SubStr( A->NAZ_IMIE, 1, At( ' ', A->NAZ_IMIE ) ), SubStr( subim, 1, At( ' ', subim ) ), A->DATA_UR )
            docrba()
            opl1()
            zus_kon( 'ZCZA' )
            dp_kon( 'ZCZA' )
            kedu_kon()
            SET PRINTER TO
            SET PRINTER OFF
            SET CONSOLE ON
            SET DEVICE TO SCREEN
            kedu_rapo( plik_kdu )
            GO nr_rec
            RESTORE SCREEN FROM scr2
            _disp := .F.
         *################################### POMOC ##################################
         case kl == 28
            SAVE SCREEN TO scr_
            @ 1, 47 SAY '          '
            DECLARE p[ 20 ]
            *---------------------------------------
            p[ 1 ] := '                                                        '
            p[ 2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
            p[ 3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
            p[ 4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
            p[ 5 ] := '   [Enter].................akceptacja                   '
            p[ 6 ] := '   [Esc]...................wyj&_s.cie                      '
            p[ 7 ] := '                                                        '
            *---------------------------------------
            SET COLOR TO i
            i := 20
            j := 24
            DO WHILE i > 0
               IF Type( 'p[i]' ) # 'U'
                  center( j, p[ i ] )
                  j := j - 1
               ENDIF
               i := i - 1
            ENDDO
            SET COLOR TO
            pause( 0 )
            IF LastKey() # 27 .AND. LastKey() # 28
               KEYBOARD Chr( LastKey() )
            ENDIF
            RESTORE SCREEN FROM scr_
            _disp := .F.
         ******************** ENDCASE
         ENDCASE
      ENDDO
      Close_()
   ELSE
      *--------------------------------------
      SELECT prac
      *--------------------------------------
      @ 3, 42 CLEAR TO 22, 79
      *################################# GRAFIKA ##################################
      ColStd()
      @  3, 42 SAY '              Podatnik:              '
      @  4, 42 SAY '�����������������������������������ͻ'
      @  5, 42 SAY '�                                   �'
      @  6, 42 SAY '�                                   �'
      @  7, 42 SAY '�                                   �'
      @  8, 42 SAY '�                                   �'
      @  9, 42 SAY '�                                   �'
      @ 10, 42 SAY '�����������������������������������ͼ'
      *################################# OPERACJE #################################
      *----- parametry ------
      _row_g := 5
      _col_l := 43
      _row_d := 9
      _col_p := 77
      _invers := 'i'
      _curs_l := 0
      _curs_p := 0
      _esc := '27,28,13,1006'
      _top := 'firma#ident_fir'
      _bot := "del#'+'.or.firma#ident_fir"
      _stop := '+' + ident_fir
      _sbot := '+' + ident_fir + '�'
      _proc := 'linia12cp()'
      _row := Int( ( _row_g + _row_d ) / 2 )
      _proc_spe := ''
      _disp := .T.
      _cls := ''
      *----------------------
      kl := 0
      DO WHILE kl # 27
         ColSta()
         @ 1, 47 SAY '[F1]-pomoc'
         SET COLOR TO
         SELECT prac
         _row := wybor( _row )
         kl := LastKey()
         DO CASE
         *################################## ZESTAW_ #################################
         CASE kl == 13 .OR. kl == 1006
            zidp := Str( rec_no, 5 )
            SELECT etaty
            SEEK '+' + ident_fir + zidp
            SELECT prac
            SAVE SCREEN TO scr2
            nr_rec := RecNo()
            param_zu()
            jeden := zus_zglo()
            IF jeden # 1
               Close_()
               RETURN
            ENDIF
            SET CONSOLE OFF
            SET DEVICE TO PRINTER
            SET PRINTER ON
            NUFIR := Val( AllTrim( ident_fir ) )
            Nufir1 := HI36( nufir )
            nufir2 := LO36( nufir )
            NUPRA := RecNo()
            Nupra1 := HI36( nupra )
            nupra2 := LO36( nupra )
            PLIK_KDU := SubStr( param_rok, 4, 1 ) + ;
               '0' + ;
               iif( nufir1 > 9, Chr( 55 + nufir1 ), Str( nufir1, 1 ) ) + ;
               iif( nufir2 > 9, Chr( 55 + nufir2 ), Str( nufir2, 1 ) ) + ;
               '2' + ;
               'P' + ;
               iif( nupra1 > 9, Chr( 55 + nupra1 ), Str( nupra1, 1 ) ) + ;
               iif( nupra2 > 9, Chr( 55 + nupra2 ), Str( nupra2, 1 ) ) + '.kdu'
            aaaa := AllTrim( paraz_cel ) + PLIK_KDU
            SET PRINTER TO &aaaa
            kedu_pocz()
            dp_pocz( 'ZCZA' )
            zus_pocz( 'ZCZA', 1 )
            dozcba()
            *dipl rozne dla spolki i osoby fizycznej
            IF zSPOLKA = 'T'
               dipl( F->NIP, SubStr( F->NR_REGON, 3 ), '', '', '', F->nazwa_skr, '', '', CToD( '    /  /  ' ) )
            ELSE
               subim := SubStr( A->NAZ_IMIE, At( ' ', A->NAZ_IMIE ) + 1 )
               dipl( A->NIP, SubStr( F->NR_REGON, 3 ), A->PESEL, A->RODZ_DOK, A->DOWOD_OSOB, F->nazwa_skr, SubStr( A->NAZ_IMIE, 1, At( ' ', A->NAZ_IMIE ) ), SubStr( subim, 1, At( ' ', subim ) ), A->DATA_UR )
            ENDIF
            *dipl() with F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  ')
            dau( B->PESEL, B->NIP, B->RODZ_DOK, B->DOWOD_OSOB, B->NAZWISKO, B->IMIE1, B->DATA_UR )
            docrba()
            opl1()
            zus_kon( 'ZCZA' )
            dp_kon( 'ZCZA' )
            kedu_kon()
            SET PRINTER TO
            SET CONSOLE ON
            SET PRINTER OFF
            SET DEVICE TO SCREEN
            kedu_rapo( plik_kdu )
            GO nr_rec
            RESTORE SCREEN FROM scr2
            _disp := .F.
         *################################### POMOC ##################################
         CASE kl == 28
            SAVE SCREEN TO scr_
            @ 1, 47 SAY '          '
            DECLARE p[ 20 ]
            *---------------------------------------
            p[ 1 ] := '                                                        '
            p[ 2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
            p[ 3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
            p[ 4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
            p[ 5 ] := '   [Enter].................akceptacja                   '
            p[ 6 ] := '   [Esc]...................wyj&_s.cie                      '
            p[ 7 ] := '                                                        '
            *---------------------------------------
            SET COLOR TO i
            i := 20
            j := 24
            DO WHILE i > 0
               IF Type( 'p[i]' ) # 'U'
                  center( j, p[ i ] )
                  j := j - 1
               ENDIF
               i := i - 1
            ENDDO
            SET COLOR TO
            pause( 0 )
            IF LastKey() # 27 .AND. LastKey() # 28
               KEYBOARD Chr( LastKey() )
            ENDIF
            RESTORE SCREEN FROM scr_
            _disp := .F.
         ******************** ENDCASE
         ENDCASE
      ENDDO
      Close_()
   ENDIF

   RETURN

*################################## FUNKCJE #################################
FUNCTION linia12c()

   RETURN ' ' + dos_c( naz_imie ) + ' '

*################################## FUNKCJE #################################
FUNCTION linia12cp()

   RETURN ' ' + PadC( AllTrim( nazwisko ) + ' ' + AllTrim( imie1 ) + ' ' + AllTrim( imie2 ), 33 ) + ' '

*############################################################################
