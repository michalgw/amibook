/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

FUNCTION Zrodla()

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   PRIVATE _top,_bot,_top_bot,_stop,_sbot,_proc,kl,ins,nr_rec,f10,rec,fou

   @ 1, 47 SAY '          '
*################################# GRAFIKA ##################################
   @  3, 0 SAY '                                                                                '
   @  4, 0 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @  5, 0 SAY '     Pozarolnicza dzia&_l.alno&_s.&_c. gospodarcza      przych&_o.d     koszty uzysk. udzia&_l.'
   @  6, 0 SAY '1. úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúú'
   @  7, 0 SAY '2. úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúú'
   @  8, 0 SAY '3. úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúú'
   IF spolka->sposob == 'L'
      @  9, 0 SAY '4. úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúú'
   ELSE
      @  9, 0 SAY '                                                                                '
   ENDIF
   IF spolka->sposob == 'L'
      @ 10, 0 SAY '                                                                                '
      @ 11, 0 SAY '                                                                                '
      @ 12, 0 SAY '                                                                                '
      @ 13, 0 SAY '                                                                                '
      @ 14, 0 SAY '                                                                                '
   ELSE
      @ 10, 0 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
      @ 11, 0 SAY '               Najem lub dzier&_z.awa             przych&_o.d     koszty uzysk. udzia&_l.'
      @ 12, 0 SAY '1. úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúú'
      @ 13, 0 SAY '2. úúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúúúúúúúúúú úúúúúú'
      @ 14, 0 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   ENDIF
   @ 15, 0 SAY '                                                                                '
   @ 16, 0 SAY '                                                                                '
   @ 17, 0 SAY '                                                                                '
   @ 18, 0 SAY '                                                                                '
   @ 19, 0 SAY '                                                                                '
   @ 20, 0 SAY '                                                                                '
   @ 21, 0 SAY '                                                                                '
   @ 22, 0 SAY '                                                                                '
   ColInf()
   center( 3, 'I N N E    Z R &__O. D &__L. A    P R Z Y C H O D &__O. W' )
   ColStd()

*################################# OPERACJE #################################
*----- parametry ------
   _proc := 'say19'
*----------------------
   DO &_proc
   kl := 0
   DO WHILE kl # K_ESC
      @ 1,47 SAY '[F1]-pomoc'
      kl := Inkey( 0 )

      DO CASE
*########################### INSERT/MODYFIKACJA #############################
         CASE kl == Asc( 'm' ) .OR. kl == Asc( 'M' )
            @ 1, 47 SAY '          '
            ColStb()
            center( 23, 'þ                       þ' )
            ColSta()
            center( 23, 'M O D Y F I K A C J A' )
            ColStd()
            BEGIN SEQUENCE
               *-------zamek-------
               IF suma_mc->zamek
                  kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
                  BREAK
               ENDIF
               *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
               zG_PRZYCH1 := G_PRZYCH1
               zG_KOSZTY1 := G_KOSZTY1
               zG_UDZIAL1 := G_UDZIAL1
               zG_PRZYCH2 := G_PRZYCH2
               zG_KOSZTY2 := G_KOSZTY2
               zG_UDZIAL2 := G_UDZIAL2
               zG_PRZYCH3 := G_PRZYCH3
               zG_KOSZTY3 := G_KOSZTY3
               zG_UDZIAL3 := G_UDZIAL3
               zG_PRZYCH4 := G_PRZYCH4
               zG_KOSZTY4 := G_KOSZTY4
               zG_UDZIAL4 := G_UDZIAL4
               zN_PRZYCH1 := N_PRZYCH1
               zN_KOSZTY1 := N_KOSZTY1
               zN_UDZIAL1 := N_UDZIAL1
               zN_PRZYCH2 := N_PRZYCH2
               zN_KOSZTY2 := N_KOSZTY2
               zN_UDZIAL2 := N_UDZIAL2
               *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
               IF ! Empty( spolka->g_rodzaj1 )
                  @ 6, 44 GET zG_PRZYCH1 PICTURE "   99999999.99"
                  @ 6, 59 GET zG_KOSZTY1 PICTURE "   99999999.99"
                  @ 6, 74 GET zG_UDZIAL1 PICTURE "99/999" VALID v19_1()
               ENDIF
               IF ! Empty( spolka->g_rodzaj2 )
                  @ 7, 44 GET zG_PRZYCH2 PICTURE "   99999999.99"
                  @ 7, 59 GET zG_KOSZTY2 PICTURE "   99999999.99"
                  @ 7, 74 GET zG_UDZIAL2 PICTURE "99/999" VALID v19_2()
               ENDIF
               IF ! Empty( spolka->g_rodzaj3 )
                  @ 8, 44 GET zG_PRZYCH3 PICTURE "   99999999.99"
                  @ 8, 59 GET zG_KOSZTY3 PICTURE "   99999999.99"
                  @ 8, 74 GET zG_UDZIAL3 PICTURE "99/999" VALID v19_1a()
               ENDIF
               IF spolka->sposob == 'L' .AND. ! Empty( spolka->g_rodzaj4 )
                  @ 9, 44 get zG_PRZYCH4 picture "   99999999.99"
                  @ 9, 59 get zG_KOSZTY4 picture "   99999999.99"
                  @ 9, 74 get zG_UDZIAL4 picture "99/999" valid v19_2a()
               ENDIF
               IF spolka->sposob <> 'L'
                  IF ! Empty( spolka->n_przedm1 )
                     @ 12, 44 GET zN_PRZYCH1 PICTURE "   99999999.99"
                     @ 12, 59 GET zN_KOSZTY1 PICTURE "   99999999.99"
                     @ 12, 74 GET zN_UDZIAL1 PICTURE "99/999" VALID v19_3()
                  ENDIF
                  IF ! Empty( spolka->n_przedm2 )
                     @ 13, 44 GET zN_PRZYCH2 PICTURE "   99999999.99"
                     @ 13, 59 GET zN_KOSZTY2 PICTURE "   99999999.99"
                     @ 13, 74 GET zN_UDZIAL2 PICTURE "99/999" VALID v19_4()
                  ENDIF
               ENDIF

               CLEAR TYPE
               read_()
               IF LastKey() == K_ESC
                  BREAK
               ENDIF

               zg_udzial1 := Str( Val( Left( zg_udzial1, 2 ) ), 2 ) + '/' + dos_l( Str( Val( Right( zg_udzial1, 3 ) ), 3 ) )
               zg_udzial2 := Str( Val( Left( zg_udzial2, 2 ) ), 2 ) + '/' + dos_l( Str( Val( Right( zg_udzial2, 3 ) ), 3 ) )
               zg_udzial3 := Str( Val( Left( zg_udzial3, 2 ) ), 2 ) + '/' + dos_l( Str( Val( Right( zg_udzial3, 3 ) ), 3 ) )
               zg_udzial4 := Str( Val( Left( zg_udzial4, 2 ) ), 2 ) + '/' + dos_l( Str( Val( Right( zg_udzial4, 3 ) ), 3 ) )
               zn_udzial1 := Str( Val( Left( zn_udzial1, 2 ) ), 2 ) + '/' + dos_l( Str( Val( Right( zn_udzial1, 3 ) ), 3 ) )
               zn_udzial2 := Str( Val( Left( zn_udzial2, 2 ) ), 2 ) + '/' + dos_l( Str( Val( Right( zn_udzial2, 3 ) ), 3 ) )

               *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
               BLOKADAR()
               repl_( 'G_PRZYCH1', _round( zG_PRZYCH1, 2 ) )
               repl_( 'G_KOSZTY1', _round( zG_KOSZTY1, 2 ) )
               repl_( 'G_UDZIAL1', zG_UDZIAL1 )
               repl_( 'G_PRZYCH2', _round( zG_PRZYCH2, 2 ) )
               repl_( 'G_KOSZTY2', _round( zG_KOSZTY2, 2 ) )
               repl_( 'G_UDZIAL2', zG_UDZIAL2 )
               repl_( 'G_PRZYCH3', _round( zG_PRZYCH3, 2 ) )
               repl_( 'G_KOSZTY3', _round( zG_KOSZTY3, 2 ) )
               repl_( 'G_UDZIAL3', zG_UDZIAL3 )
               repl_( 'G_PRZYCH4', _round( zG_PRZYCH4, 2 ) )
               repl_( 'G_KOSZTY4', _round( zG_KOSZTY4, 2 ) )
               repl_( 'G_UDZIAL4', zG_UDZIAL4 )
               repl_( 'N_PRZYCH1', _round( zN_PRZYCH1, 2 ) )
               repl_( 'N_KOSZTY1', _round( zN_KOSZTY1, 2 ) )
               repl_( 'N_UDZIAL1', zN_UDZIAL1 )
               repl_( 'N_PRZYCH2', _round( zN_PRZYCH2, 2 ) )
               repl_( 'N_KOSZTY2', _round( zN_KOSZTY2, 2 ) )
               repl_( 'N_UDZIAL2', zN_UDZIAL2 )
               commit_()
               UNLOCK
               *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            END
            DO &_proc
            @ 23,0
*################################### POMOC ##################################
         CASE kl == K_F1
            SAVE SCREEN TO scr_
            @ 1, 47 SAY '          '
            DECLARE p[20]
            *---------------------------------------
            p[ 1]='                                                        '
            p[ 2]='   [M].....................modyfikacja                  '
            p[ 3]='   [Esc]...................wyj&_s.cie                      '
            p[ 4]='                                                        '
            *---------------------------------------
            SET COLOR TO i
            i := 20
            j := 24
            DO WHILE i > 0
               IF Type( 'p[i]' ) # 'U'
                  center( j, p[ i ] )
                  j := j-1
               ENDIF
               i := i - 1
            ENDDO
            SET COLOR TO
            pause( 0 )
            IF LastKey() # K_ESC .AND. LastKey() # K_F1
               KEYBOARD Chr( LastKey() )
            ENDIF
            RESTORE SCREEN FROM scr_
******************** ENDCASE
      ENDCASE
   ENDDO
   RETURN NIL

*################################## FUNKCJE #################################

PROCEDURE say19()

   CLEAR TYPE
   SET COLOR TO +w
   IF ! Empty( spolka->g_rodzaj1 )
      @ 6,  3 SAY spolka->G_RODZAJ1
      @ 6, 44 SAY G_PRZYCH1 PICTURE "999 999 999.99"
      @ 6, 59 SAY G_KOSZTY1 PICTURE "999 999 999.99"
      @ 6, 74 SAY G_UDZIAL1
   ENDIF
   IF ! Empty( spolka->g_rodzaj2 )
      @ 7,  3 SAY spolka->G_RODZAJ2
      @ 7, 44 SAY G_PRZYCH2 PICTURE "999 999 999.99"
      @ 7, 59 SAY G_KOSZTY2 PICTURE "999 999 999.99"
      @ 7, 74 SAY G_UDZIAL2
   ENDIF
   IF ! Empty( spolka->g_rodzaj3 )
      @ 8,  3 SAY spolka->G_RODZAJ3
      @ 8, 44 SAY G_PRZYCH3 PICTURE "999 999 999.99"
      @ 8, 59 SAY G_KOSZTY3 PICTURE "999 999 999.99"
      @ 8, 74 SAY G_UDZIAL3
   ENDIF
   IF spolka->sposob == 'L' .AND. ! Empty( spolka->g_rodzaj4 )
      @ 9,  3 SAY spolka->G_RODZAJ4
      @ 9, 44 SAY G_PRZYCH4 PICTURE "999 999 999.99"
      @ 9, 59 SAY G_KOSZTY4 PICTURE "999 999 999.99"
      @ 9, 74 SAY G_UDZIAL4
   ENDIF
   IF spolka->sposob <> 'L'
      IF ! Empty( spolka->n_przedm1 )
         @ 12,  3 SAY spolka->N_PRZEDM1
         @ 12, 44 SAY N_PRZYCH1 PICTURE "999 999 999.99"
         @ 12, 59 SAY N_KOSZTY1 PICTURE "999 999 999.99"
         @ 12, 74 SAY N_UDZIAL1
      ENDIF
      IF ! Empty( spolka->n_przedm2 )
         @ 13,  3 SAY spolka->N_PRZEDM2
         @ 13, 44 SAY N_PRZYCH2 PICTURE "999 999 999.99"
         @ 13, 59 SAY N_KOSZTY2 PICTURE "999 999 999.99"
         @ 13, 74 SAY N_UDZIAL2
      ENDIF
   ENDIF
   SET COLOR TO
   RETURN

***************************************************

FUNCTION v19_1()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   zm1 := Val( Left( zg_udzial1, 2 ) )
   zm2 := Val( Right( zg_udzial1, 3 ) )
   IF zm1 == 0 .OR. zm2 == 0 .OR. ' ' $ AllTrim( Right( zg_udzial1, 3 ) ) .OR. ( zm1 == zm2 .AND. zm1 # 1 )
      RETURN .F.
   ENDIF
   IF zm1 > zm2
      kom( 3, '*u', ' Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ' )
      RETURN .F.
   ENDIF
   RETURN .T.

***************************************************

FUNCTION v19_2()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   zm1 := Val( Left( zg_udzial2, 2 ) )
   zm2 := Val( Right( zg_udzial2, 3 ) )
   IF zm1 == 0 .OR. zm2 == 0 .OR. ' ' $ AllTrim( Right( zg_udzial2, 3 ) ) .OR. ( zm1 == zm2 .AND. zm1 # 1 )
      RETURN .F.
   ENDIF
   IF zm1 > zm2
      kom( 3, '*u', ' Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ' )
      RETURN .F.
   ENDIF
   RETURN .T.

***************************************************

FUNCTION v19_1a()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   zm1 := Val( Left( zg_udzial3, 2 ) )
   zm2 := Val( Right( zg_udzial3, 3 ) )
   IF zm1 == 0 .OR. zm2 == 0 .OR. ' ' $ AllTrim( Right( zg_udzial3, 3 ) ) .OR. ( zm1 == zm2 .AND. zm1 # 1 )
      RETURN .F.
   ENDIF
   IF zm1 > zm2
      kom( 3, '*u', ' Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ' )
      RETURN .F.
   ENDIF
   RETURN .T.

***************************************************

FUNCTION v19_2a()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   zm1 := Val( Left( zg_udzial4, 2 ) )
   zm2 := Val( Right( zg_udzial4, 3 ) )
   IF zm1 == 0 .OR. zm2 == 0 .OR. ' ' $ AllTrim( Right( zg_udzial4, 3 ) ) .OR. ( zm1 == zm2 .AND. zm1 # 1 )
      RETURN .F.
   ENDIF
   IF zm1 > zm2
      kom( 3, '*u', ' Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ' )
      RETURN .F.
   ENDIF
   RETURN .T.

***************************************************

FUNCTION v19_3()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   zm1 := Val( Left( zn_udzial1, 2 ) )
   zm2 := Val( Right( zn_udzial1, 3 ) )
   IF zm1 == 0 .OR. zm2 == 0.OR. ' ' $ AllTrim( Right( zn_udzial1, 3 ) ) .OR. ( zm1 == zm2 .AND. zm1 # 1 )
      RETURN .F.
   ENDIF
   IF zm1 > zm2
      kom( 3, '*u', ' Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ' )
      RETURN .F.
   ENDIF
   RETURN .T.

***************************************************

FUNCTION v19_4()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   zm1 := Val( Left( zn_udzial2, 2 ) )
   zm2 := Val( Right( zn_udzial2, 3 ) )
   IF zm1 == 0 .OR. zm2 == 0 .OR. ' ' $ AllTrim( Right( zn_udzial2, 3 ) ) .OR. ( zm1 == zm2 .AND. zm1 # 1 )
      RETURN .F.
   ENDIF
   IF zm1 > zm2
      kom( 3, '*u', ' Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ' )
      RETURN .F.
   ENDIF
   RETURN .T.

*############################################################################
