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

PROCEDURE ZusZpa()

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, ;
      nr_rec, wiersz, f10, rec, fou

   @ 1, 47 SAY '          '
   *############################### OTWARCIE BAZ ###############################
   SELECT 6
   IF Dostep( 'FIRMA' )
      GO Val( ident_fir )
   ELSE
      RETURN
   ENDIF
   zORGAN := ORGAN
   zNAZWA_ORG := ''

   SELECT 5
   IF Dostep( 'ORGANY' )
      SetInd( 'ORGANY' )
      SEEK '+'
      IF Eof() .OR. del # '+'
         Kom( 3, '*u', ' Najpierw wprowad&_x. informacje o Organach Rejestrowych ' )
         RETURN
      ENDIF
   ELSE
      Close_()
      RETURN
   ENDIF
   IF zORGAN <> 0
      SELECT organy
      GO zORGAN
      zNAZWA_ORG := NAZWA_ORG
   ENDIF

   *--------------------------------------
   SELECT firma
   *--------------------------------------
   @ 3, 42 CLEAR TO 22, 79
   *################################# OPERACJE #################################
   SAVE SCREEN TO scr2
   IF f->spolka
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
         '4' + ;
         'F' + ;
         iif( nufir1 > 9, Chr( 55 + nufir1 ), Str( nufir1, 1 ) ) + ;
         iif( nufir2 > 9, Chr( 55 + nufir2 ), Str( nufir2, 1 ) ) + ;
         '.kdu'
      aaaa := AllTrim( paraz_cel ) + PLIK_KDU
      SET PRINTER TO &aaaa
      kedu_pocz()
      dp_pocz( 'ZPA' )
      ? '<ZUSZPA>'
      dozpf()
      daip( F->NIP, SubStr( F->NR_REGON, 3 ), F->nazwa_skr )
      dapl( F->NAZWA, F->DATA_REJ, F->NUMER_REJ, zNAZWA_ORG, F->DATA_ZAL )
      dorb( AllTrim( F->NR_KONTA ) )
      ido1()
      aszp( F->KOD_P, F->MIEJSC, F->GMINA, F->ULICA, F->NR_DOMU, F->NR_MIESZK, F->TEL, F->FAX )
      adkp()
      dobr( '', '', '' )
      opl2()
      ? '</ZUSZPA>'
      dp_kon( 'ZPA' )
      kedu_kon()
      SET PRINTER TO
      SET PRINTER OFF
      SET CONSOLE ON
      SET DEVICE TO SCREEN
      kedu_rapo( plik_kdu )
      GO nr_rec
   ELSE
      Komun( 'Firma nie jest sp&_o.&_l.k&_a.' )
   ENDIF
   RESTORE SCREEN FROM scr2
   _disp := .F.
   Close_()

   RETURN
