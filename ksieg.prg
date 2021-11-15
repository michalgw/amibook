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

#include "Inkey.ch"

FUNCTION Ksieg()

   SET MESSAGE TO 10 CENTER
   QQS := 1
   SAVE SCREEN TO scrksieg
   DO WHILE QQS <> 0

      @ 2, 0 CLEAR TO 24, 79
      @ 2, 0 SAY Replicate( 'Ä', 80 )
      @ 9, 0 TO 11, 77 DOUBLE

      CURR := ColStd()

      IF zRYCZALT == 'T'
         @ 2,  3 PROMPT ' EWIDENCJA '          MESSAGE 'Zapis dokumentu tylko do ewidencji przychod&_o.w i zakup&_o.w'
      ELSE
         @ 2,  4 PROMPT ' KSI&__E.GA '         MESSAGE 'Zapis dokumentu tylko do ksi&_e.gi'
      ENDIF
      IF zVAT == 'T'
         @ 2, 18 PROMPT ' SPRZEDA&__Z. (VAT) ' MESSAGE 'Zapis dokumentu do rejestru sprzeda&_z.y i ewentualnie do ewidencji podstawowej'
      ENDIF
      IF zVAT == 'T' .OR. zVATFORDR == '8 '
         @ 2, 40 PROMPT ' ZAKUPY (VAT) '       MESSAGE 'Zapis dokumentu do rejestru zakupu i ewentualnie do ewidencji podstawowej'
      ENDIF
      @ 2, 58 PROMPT ' DOWODY WEWN&__E.TRZNE ' MESSAGE 'Sporz&_a.dzanie dowod&_o.w wewn&_e.trznych (bez ksi&_e.gowania)'

      MENU TO QQS

      IF LastKey() == K_ESC
         QQS := 0
      ENDIF

      SetColor( CURR )
      QQSQ := QQS
      IF zVAT # 'T' .AND. zVATFORDR <> '8 ' .AND. QQS == 2
         QQS := 4
      ELSEIF zVAT # 'T' .AND. zVATFORDR == '8 ' .AND. QQS > 1
         QQS := QQS + 1
      ENDIF

      DO CASE
         CASE QQS == 1
            @ 2, 0 SAY Replicate( 'Ä', 80 )
            ColInv()
            IF zRYCZALT == 'T'
               @ 2, 3 SAY ' EWIDENCJA '
               SetColor( CURR )
               Rycz()
            ELSE
               @ 2, 4 SAY ' KSI&__E.GA '
               SetColor( CURR )
               Oper()
            ENDIF

         CASE QQS == 2
            @ 2, 0 SAY Replicate( 'Ä', 80 )
            ColInv()
            @ 2, 18 SAY ' SPRZEDA&__Z. (VAT) '
            SetColor( CURR )
            KRejS()

         CASE QQS == 3
            @ 2, 0 SAY Replicate( 'Ä', 80 )
            ColInv()
            @ 2, 40 SAY ' ZAKUPY (VAT) '
            SetColor( CURR )
            KRejZ()

         CASE QQS == 4
            @ 2,  0 SAY Replicate( 'Ä', 80 )
            ColInv()
            @ 2, 58 SAY ' DOWODY WEWN&__E.TRZNE '
            SetColor( CURR )
            DoWew()
      ENDCASE
      QQS := QQSQ
   ENDDO
   RESTORE SCREEN FROM scrksieg

   RETURN NIL

*############################################################################
