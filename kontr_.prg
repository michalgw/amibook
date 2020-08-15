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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Kontr_()

   LOCAL GetList:={}
   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, ;
      nr_rec, wiersz, rec, fou

   SZUK := "del='+'.and.firma=ident_fir"
   CurrCur := SetCursor( 0 )
   @ 1, 47 SAY '          '
   IF del # '+'
      kom( 3, '*u', ' Brak kontrahent&_o.w w katalogu ' )
      KEYBOARD Chr( 27 )
      Inkey()
      RETURN
   ENDIF

   *################################# GRAFIKA ##################################
   CURR := ColStd()
   @  8, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
   @  9, 0 SAY '°                                                                              °'
   @ 10, 0 SAY '°                                                                              °'
   @ 11, 0 SAY '°                                                                              °'
   @ 12, 0 SAY '°                                                                              °'
   @ 13, 0 SAY '°                                                                              °'
   @ 14, 0 SAY '°                                                                              °'
   @ 15, 0 SAY '°                                                                              °'
   @ 16, 0 SAY '°                                                                              °'
   @ 17, 0 SAY '°                                                                              °'
   @ 18, 0 SAY '°                                                                              °'
   @ 19, 0 SAY '°                                                                              °'
   @ 20, 0 SAY '°                                                                              °'
   @ 21, 0 SAY '°                                                                              °'
   @ 22, 0 SAY '°Export/Import:°°°°°°°°°°°°°°Kod kraju:°°°°°°°°°°°°°°Obroty z UE:°°°°°°°°°°°°°°°'
   ColInf()
   IF param_aut = 'T'
      center( 23, "[Enter]-akceptacja  [F10]-szukanie" + iif( SZUK # "del='+'.and.firma=ident_fir", "  [F4]-szukaj dalej", "" ) + "  [Spacja]-nowy" )
   ELSE
      center( 23, "[Enter]-akceptacja  [F10]-szukanie" + iif( SZUK # "del='+'.and.firma=ident_fir", "  [F4]-szukaj dalej", "" ) )
   ENDIF
   ColStd()

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 9
   _col_l := 1
   _row_d := 21
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-3,-9,247,28,13,32,7,46'
   _top := 'firma#ident_fir'
   _bot := "del#'+'.or.firma#ident_fir"
   _stop := '+' + ident_fir
   _sbot := '+' + ident_fir + 'þ'
   _proc := 'linia15()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'linia15ko'
   _disp := .T.
   _cls := ''

   *----------------------
   kl := 0
   DO WHILE kl # 27 .AND. kl # 13 .AND. kl # 32
      ColSta()
      @ 1, 47 say '[F1]-pomoc'
      SET COLOR TO
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      *############################### KASOWANIE #################################
      CASE kl == 7 .OR. kl == 46
         @  1, 47 SAY '          '
         @ 23,  0
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
         IF _disp
            BlokadaR()
            del()
            COMMIT
            UNLOCK
            SKIP
            commit_()
            IF &_bot
               SKIP -1
            ENDIF
            IF &_bot
               KEYBOARD Chr( 27 )
               Inkey()
               EXIT
            ENDIF
         ENDIF
         @ 23, 0
         ColInf()
         IF param_aut = 'T'
            center( 23, "[Enter]-akceptacja  [F10]-szukanie" + iif( SZUK # "del='+'.and.firma=ident_fir", "  [F4]-szukaj dalej", "" ) + "  [Spacja]-nowy" )
         ELSE
            center( 23, "[Enter]-akceptacja  [F10]-szukanie" + iif( SZUK # "del='+'.and.firma=ident_fir", "  [F4]-szukaj dalej", "" ) )
         ENDIF
         ColStd()
      *################################# SZUKANIE #################################
      CASE kl == -9 .OR. kl == 247
         @  1, 47 SAY '          '
         @ 23,  0
         ColStb()
         center( 23, 'þ                 þ' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         ColStd()
         zzNAZWA := Space( 70 )
         zzADRES := Space( 40 )
         zzNR_IDENT := Space( 30 )
         DECLARE pp[3]
         *---------------------------------------
         pp[ 1 ] := ' Nazwa:                                                                      '
         pp[ 2 ] := ' Adres:                                                                      '
         pp[ 3 ] := '   NIP:                                                                      '
         *---------------------------------------
         SET COLOR TO N/W,W+/W,,,N/W
         i := 3
         j := 22
         DO WHILE i>0
            IF Type( 'pp[i]' ) # 'U'
               center( j, pp[ i ] )
               j := j - 1
            ENDIF
            i := i-1
         ENDDO
         SetCursor( 1 )
         ColStd()
         @ 20, 8 GET zzNAZWA    PICTURE Replicate( '!', 70 )
         @ 21, 8 GET zzADRES    PICTURE Replicate( '!', 40 )
         @ 22, 8 GET zzNR_IDENT PICTURE Replicate( '!', 30 )
         READ
         SetCursor( 0 )
         REC := RecNo()
         IF LastKey() # 27 .AND. LastKey() # 28
            GO TOP
            SZUK := "del='+'.and.firma=ident_fir"
            SEEK '+' + ident_fir
            IF Len( AllTrim( zzNAZWA ) ) > 0
               aNAZWA := AllTrim( zzNAZWA )
               SZUK := SZUK + '.and.aNAZWA$upper(NAZWA)'
            ENDIF
            IF Len( AllTrim( zzADRES ) ) > 0
               aADRES := AllTrim( zzADRES )
               SZUK := SZUK + '.and.aADRES$upper(ADRES)'
            ENDIF
            IF Len( AllTrim( zzNR_IDENT ) ) > 0
               aNR_IDENT := AllTrim( zzNR_IDENT )
               SZUK := SZUK + '.and.aNR_IDENT$upper(NR_IDENT)'
            ENDIF
            LOCATE ALL FOR &SZUK
            IF .NOT. Found()
               GO REC
            ENDIF
         ELSE
            GO REC
         ENDIF
         @ 23, 0
         ColInf()
         IF param_aut = 'T'
            center( 23, "[Enter]-akceptacja  [F10]-szukanie" + iif( SZUK # "del='+'.and.firma=ident_fir", "  [F4]-szukaj dalej", "" ) + "  [Spacja]-nowy" )
         ELSE
            center( 23, "[Enter]-akceptacja  [F10]-szukanie" + iif( SZUK # "del='+'.and.firma=ident_fir", "  [F4]-szukaj dalej", "" ) )
         ENDIF
         ColStd()
      *################################# DALSZE SZUKANIE #################################
      CASE kl == -3
         REC := RecNo()
         IF SZUK # "del='+'.and.firma=ident_fir"
            SKIP 1
            LOCATE ALL FOR &SZUK REST
            IF .NOT. Found()
               GO REC
            ENDIF
         ELSE
            komun( 'Nie okreslono kryteriow poszukiwania. Wprowadz kryteria (klawisz F10)' )
         ENDIF
         @ 23, 0
         ColInf()
         IF param_aut = 'T'
            center( 23, "[Enter]-akceptacja  [F10]-szukanie" + iif( SZUK # "del='+'.and.firma=ident_fir", "  [F4]-szukaj dalej", "" ) + "  [Spacja]-nowy" )
         ELSE
            center( 23, "[Enter]-akceptacja  [F10]-szukanie" + iif( SZUK # "del='+'.and.firma=ident_fir", "  [F4]-szukaj dalej", "" ) )
         ENDIF
         ColStd()
      *################################### POMOC ##################################
      case kl=28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[  1 ] := '                                                        '
         p[  2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
         p[  3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[  4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[  5 ] := '   [Del]...................kasowanie pozycji            '
         p[  6 ] := '   [Enter].................akceptacja                   '
         p[  7 ] := '   [F10]...................szukanie                     '
         p[  8 ] := '   [F4]....................szukanie - kontynuacja       '
         p[  9 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 10 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO i
         i := 20
         j := 24
         DO WHILE i>0
            IF Type( 'p[i]' ) # 'U'
               center( j, p[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         Pause( 0 )
         IF LastKey() # 27 .AND. LastKey() # 28
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      ******************** ENDCASE
      ENDCASE
   ENDDO

   SetCursor( CurrCur )
   SetColor( CURR )

   RETURN NIL

*################################## FUNKCJE #################################
FUNCTION linia15()

   RETURN SubStr( NAZWA, 1, 32 ) + ' ' + SubStr( ADRES, 1, 29 ) + ' ' + SubStr( NR_IDENT, 1, 13 ) + ' ' + EXPORT

*****************************************************************************
PROCEDURE linia15ko()

   @ 22, 15 SAY iif( EXPORT = 'T', 'Tak', 'Nie' )
   @ 22, 39 SAY KRAJ
   @ 22, 65 SAY iif( UE = 'T', 'Tak', 'Nie' )

   RETURN

*############################################################################
