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

FUNCTION dbfInicjujDane()

// Create: AMORT.DBF
public  aAMORTdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3   Numer rekordu tablicy 'firma'
   { "IDENT", "C", 5, 0 },;                       //  4   Identyfiktaor w tabeli 'katst' w poli 'rec_no'
   { "ROK", "C", 4, 0 },;                         //  5   Rok kalendarzowy
   { "WART_POCZ", "N", 12, 2 },;                  //  6   Wartosc poczatkowa w roku
   { "PRZEL", "N", 6, 2 },;                       //  7   Przelicznik w roku
   { "WART_MOD", "N", 12, 2 },;                   //  8   Suma modyfikacji kwot z tablicy 'kartstmo'
   { "WART_AKT", "N", 12, 2 },;                   //  9
   { "UMORZ_AKT", "N", 12, 2 },;                  //  10
   { "STAWKA", "N", 6, 2 },;                      //  11
   { "WSPDEG", "N", 4, 2 },;                      //  12
   { "LINIOWO", "N", 12, 2 },;                    //  13
   { "DEGRES", "N", 12, 2 },;                     //  14
   { "MC01", "N", 9, 2 },;                        //  15
   { "MC02", "N", 9, 2 },;                        //  16
   { "MC03", "N", 9, 2 },;                        //  17
   { "MC04", "N", 9, 2 },;                        //  18
   { "MC05", "N", 9, 2 },;                        //  19
   { "MC06", "N", 9, 2 },;                        //  20
   { "MC07", "N", 9, 2 },;                        //  21
   { "MC08", "N", 9, 2 },;                        //  22
   { "MC09", "N", 9, 2 },;                        //  23
   { "MC10", "N", 9, 2 },;                        //  24
   { "MC11", "N", 9, 2 },;                        //  25
   { "MC12", "N", 9, 2 },;                        //  26
   { "ODPIS_ROK", "N", 12, 2 },;                  //  27
   { "ODPIS_SUM", "N", 12, 2 } }                  //  28

// Create: DANE_MC.DBF
public aDANE_MCdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "IDENT", "C", 5, 0 },;                       //  3   Nr rekordu w tablicy 'spolka'
   { "MC", "C", 2, 0 },;                          //  4   Miesiac
   { "G_PRZYCH1", "N", 11, 2 },;                  //  5   Przychod z dodatkowej dzialalnosci gosp. #1
   { "G_PRZYCH2", "N", 11, 2 },;                  //  6   Przychod z dodatkowej dzialalnosci gosp. #2
   { "G_PRZYCH3", "N", 11, 2 },;                  //  7   Przychod z dodatkowej dzialalnosci gosp. #3
   { "G_PRZYCH4", "N", 11, 2 },;                  //  8   Przychod z dodatkowej dzialalnosci gosp. #4
   { "G_PRZYCH5", "N", 11, 2 },;                  //  9   Przychod z dodatkowej dzialalnosci gosp. #5
   { "G_KOSZTY1", "N", 11, 2 },;                  //  10  Koszty z dodatkowej dzialalnosci gosp. #1
   { "G_KOSZTY2", "N", 11, 2 },;                  //  11  Koszty z dodatkowej dzialalnosci gosp. #2
   { "G_KOSZTY3", "N", 11, 2 },;                  //  12  Koszty z dodatkowej dzialalnosci gosp. #3
   { "G_KOSZTY4", "N", 11, 2 },;                  //  13  Koszty z dodatkowej dzialalnosci gosp. #4
   { "G_KOSZTY5", "N", 11, 2 },;                  //  14  Koszty z dodatkowej dzialalnosci gosp. #5
   { "G_UDZIAL1", "C", 6, 0 },;                   //  15  Udzial w dodatkowej dzialalnosci gosp. #1
   { "G_UDZIAL2", "C", 6, 0 },;                   //  16  Udzial w dodatkowej dzialalnosci gosp. #2
   { "G_UDZIAL3", "C", 6, 0 },;                   //  17  Udzial w dodatkowej dzialalnosci gosp. #3
   { "G_UDZIAL4", "C", 6, 0 },;                   //  18  Udzial w dodatkowej dzialalnosci gosp. #4
   { "G_UDZIAL5", "C", 6, 0 },;                   //  19  Udzial w dodatkowej dzialalnosci gosp. #5
   { "N_PRZYCH1", "N", 11, 2 },;                  //  20  Przychod z najmu #1
   { "N_PRZYCH2", "N", 11, 2 },;                  //  21  Przychod z najmu #2
   { "N_KOSZTY1", "N", 11, 2 },;                  //  22  Koszty z najmu #1
   { "N_KOSZTY2", "N", 11, 2 },;                  //  23  Koszty z najmu #2
   { "N_UDZIAL1", "C", 6, 0 },;                   //  24  Udzial z najmu #1
   { "N_UDZIAL2", "C", 6, 0 },;                   //  25  Udzial z najmu #2
   { "STRATY", "N", 11, 2 },;                     //  26  Straty z lat ubieglych z pozarolniczej dzialalnosci gospodarczej
   { "STRATY_N", "N", 11, 2 },;                   //  27  Straty z lat ubieglych z najmu,podnajmu,dzierzawy i innych umow
   { "POWODZ", "N", 11, 2 },;                     //  28  Straty poniesione w wyniku powodzi z lipca 1997roku
   { "RENTALIM", "N", 11, 2 },;                   //  29  Dochod zwolniony od podatku-na podstawie art.21 ust.1 pkt.63a ustawy
   { "SKLADKI", "N", 11, 2 },;                    //  30  ZUS Suma skladek
   { "SKLADKIW", "N", 11, 2 },;                   //  31  ZUS Suma skladek - modyfikator
   { "PODSTAWA", "N", 11, 2 },;                   //  32  ZUS Podstawa do ZUS
   { "STAW_WUE", "N", 5, 2 },;                    //  33  ZUS Stawka emerytalna
   { "STAW_WUR", "N", 5, 2 },;                    //  34  ZUS Stawka rentowa
   { "STAW_WUC", "N", 5, 2 },;                    //  35  ZUS Stawka chorobowa
   { "STAW_WUZ", "N", 5, 2 },;                    //  36  ZUS Stawka zdrowotna do ZUS
   { "STAW_WUW", "N", 5, 2 },;                    //  37  ZUS Stawka wypadkowa
   { "STAW_WFP", "N", 5, 2 },;                    //  38  ZUS Stawka fundusz pracy
   { "STAW_WFG", "N", 5, 2 },;                    //  39  ZUS Stawka GSP
   { "STAW_WSUM", "N", 5, 2 },;                   //  40  NIEUZYWANE
   { "WAR_WUE", "N", 8, 2 },;                     //  41  ZUS Wartosc emerytalna
   { "WAR_WUR", "N", 8, 2 },;                     //  42  ZUS Wartosc rentowa
   { "WAR_WUC", "N", 8, 2 },;                     //  43  ZUS Wartosc chorobowa
   { "WAR_WUZ", "N", 8, 2 },;                     //  44  ZUS Wartosc zdrowotna do ZUS
   { "WAR_WUW", "N", 8, 2 },;                     //  45  ZUS Wartosc wypadkowa
   { "WAR_WFP", "N", 8, 2 },;                     //  46  ZUS Wartosc fundusz pracy
   { "WAR_WFG", "N", 8, 2 },;                     //  47  ZUS Wartosc GSP
   { "WAR_WSUM", "N", 8, 2 },;                    //  48  NIEUZYWANE
   { "WAR5_WUE", "N", 8, 2 },;                    //  49  ZUS Wartosc emerytalna do PIT-5
   { "WAR5_WUR", "N", 8, 2 },;                    //  50  ZUS Wartosc rentowa do PIT-5
   { "WAR5_WUC", "N", 8, 2 },;                    //  51  ZUS Wartosc chorobowa do PIT-5
   { "WAR5_WUZ", "N", 8, 2 },;                    //  52  ZUS Wartosc zdrowotna do ZUS do PIT-5
   { "WAR5_WUW", "N", 8, 2 },;                    //  53  ZUS Wartosc wypadkowa do PIT-5
   { "WAR5_WFP", "N", 8, 2 },;                    //  54  ZUS Wartosc fundusz pracy do PIT-5
   { "WAR5_WFG", "N", 8, 2 },;                    //  55  ZUS Wartosc GSP do PIT-5
   { "MC_WUE", "N", 2, 0 },;                      //  56  ZUS Miesiac emerytalna do PIT-5
   { "MC_WUR", "N", 2, 0 },;                      //  57  ZUS Miesiac rentowa do PIT-5
   { "MC_WUC", "N", 2, 0 },;                      //  58  ZUS Miesiac chorobowa
   { "MC_WUZ", "N", 2, 0 },;                      //  59  ZUS Miesiac zdrowotna do ZUS do PIT-5
   { "MC_WUW", "N", 2, 0 },;                      //  60  ZUS Miesiac wypadkowa do PIT-5
   { "ORGANY", "N", 11, 2 },;                     //  61  Skladki na rzecz organizacji z obowiazkowa przynaleznoscia
   { "ZWROT_REN", "N", 11, 2 },;                  //  62  Zwrot nienaleznie pobranych emerytur i rent oraz zasilkow z US
   { "ZWROT_SWI", "N", 11, 2 },;                  //  63  Zwrot nienaleznie pobranych swiadczen,ktore uprzednio zw.doch
   { "REHAB", "N", 11, 2 },;                      //  64  Wydatki na cele rehabilitacyjne, ponoszone przez podatnika
   { "KOPALINY", "N", 11, 2 },;                   //  65  Kwota wydatkow,o ktora zostala obnizona oplata za wydob.kopalin
   { "DAROWIZ", "N", 11, 2 },;                    //  66  Darowizny
   { "INNE", "N", 11, 2 },;                       //  67  Inne odliczenia
   { "BUDOWA", "N", 11, 2 },;                     //  68  Wydatki mieszkaniowe
   { "INWEST11", "N", 11, 2 },;                   //  69  NIEUZYWANE
   { "DOCHZWOL", "N", 11, 2 },;                   //  70  Dochod zwolniony od podatku na podstawie przepisow o SSE
   { "AAA", "N", 11, 2 },;                        //  71  Ulgi inwestycyjne przyznane przed 1.01.1992r
   { "BBB", "N", 11, 2 },;                        //  72  Ulgi za wyszkolenie ucznia
   { "ZALICZKAP", "N", 11, 2 },;                  //  73  Zaliczka poprzednia?
   { "ZALICZKA", "N", 11, 2 },;                   //  74  Zaliczka wplacona podatku
   { "PIT597", "N", 11, 2 },;                     //  75  NIEUZYWANE
   { "PIT569", "N", 11, 2 },;                     //  76  NIEUZYWANE
   { "PIT5104", "N", 11, 2 },;                    //  77  NIEUZYWANE
   { "PIT5105", "N", 11, 2 },;                    //  78  Nalezny zryczaltowany podatek dochodowy od dochodu z reman.likwid
   { "PIT5AGOSK", "N", 11, 2 },;                  //  79  Dane z zalacznika PIT-5/A Dzial.gosp.(zal.PIT-5/A) - koszty
   { "PIT5ANAJK", "N", 11, 2 },;                  //  80  Dane z zalacznika PIT-5/A Najem (zal.PIT-5/A) - koszty
   { "PIT5AGOSP", "N", 11, 2 },;                  //  81  Dane z zalacznika PIT-5/A Dzial.gosp.(zal.PIT-5/A) - przychod
   { "PIT5ANAJP", "N", 11, 2 },;                  //  82  Dane z zalacznika PIT-5/A Najem (zal.PIT-5/A) - przychod
   { "G21", "N", 11, 2 },;                        //  83  Na podstawie przepisow wykonawczych do ustawy z dnia 20.10.1994
   { "H385", "N", 11, 2 },;                       //  84  Ograniczenie wysokosci zaliczek albo zaniechanie poboru podatku - kwota
   { "ZDROWIE", "N", 11, 2 },;                    //  85  Suma skladek na zdrowotne
   { "ZDROWIEW", "N", 11, 2 },;                   //  86  Skladka na ubezpieczenie zdrowotne (zaplacona)
   { "WYNAGRO", "N", 11, 2 },;                    //  87  Fundusz wynagrodzen przyslugujacy osobom pozbawionym wolnosci
   { "UBIEGBUD", "N", 11, 2 },;                   //  88  NIEUZYWANE
   { "UBIEGINW", "N", 11, 2 },;                   //  89  Odliczenia z tytulu wydatkow inwestycyjnych - Dodatkowa obnizka
   { "ODSEODMAJ", "N", 11, 2 },;                  //  90  Kwota odsetek naliczonych od dnia zaliczenia do kosztow uzyskania przychodow - wydatkow na nabycie lub wytworzenie we wlasnym zakresie sklad.maj
   { "STAW5_WUZ", "N", 5, 2 },;                   //  91  ZUS Stawka zdrowotna do ZUS do PIT-5
   { "INNEODPOD", "N", 11, 2 },;                  //  92  Inne odliczenia
   { "PODSTZDR", "N", 11, 2 },;                   //  93  ZUS Podstawa tylko do zdrow.
   { "ULGAKLSRA", "C", 1, 0 },;                   //  94  Odlicz ulge dla klasy sredniej
   { "ULGAKLSRK", "N", 8, 2 },;                   //  95  Kwota ulgi dla klasy sredniej
   { "DOCHODZDR", "N", 11, 2 } }                  //  96  Dochod do zdrowotnego do obliczenia podstawy (PODSTZDR)

// Create: DATYUM.DBF
public aDATYUMdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DATA", "D", 8, 0 },;                        //   2
   { "TYP", "C", 1, 0 } }                         //   3

// Create: DOWEW.DBF
public aDOWEWdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "DATA", "D", 8, 0 },;                        //   4
   { "NRDOK", "C", 10, 0 },;                      //   5
   { "ZESTAW", "C", 2, 0 },;                      //   6
   { "NRKOL", "C", 2, 0 },;                       //   7
   { "OPIS", "C", 100, 0 },;                      //   8
   { "WARTOSC", "N", 11, 2 },;                    //   9
   { "DRUKOWAC", "L", 1, 0 } }                    //   10

// Create: DRUKARKA.DBF
public aDRUKARKAdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "PUNKT", "C", 32, 0 },;                      //  2
   { "NAZWA", "C", 24, 0 },;                      //  3
   { "DOMYSLNY", "L", 1, 0 },;                    //  4
   { "DRUKARKA", "C", 100, 0 },;                  //  5
   { "STEROWNIK", "C", 3, 0 },;                   //  6
   { "CZCIONKA", "C", 50, 0 },;                   //  7
   { "CZCIONROZM", "N", 3, 0 },;                  //  8
   { "LININASTR", "N", 3, 0 },;                   //  9
   { "LININACAL", "N", 3, 0 },;                   //  10
   { "MARGINL", "N", 5, 1 },;                     //  11
   { "MARGINP", "N", 5, 1 },;                     //  12
   { "MARGING", "N", 5, 1 },;                     //  13
   { "MARGIND", "N", 5, 1 },;                     //  14
   { "SZERCAL", "N", 3, 0 },;                     //  15
   { "PODZIALSTR", "L", 1, 0 },;                  //  16
   { "CPI10Z", "N", 4, 0 },;                      //  17
   { "CPI10C", "N", 4, 0 },;                      //  18
   { "CPI12Z", "N", 4, 0 },;                      //  19
   { "CPI12C", "N", 4, 0 },;                      //  20
   { "CPI17Z", "N", 4, 0 },;                      //  21
   { "CPI17C", "N", 4, 0 },;                      //  22
   { "LPI6L", "N", 6, 2 },;                       //  23
   { "LPI6Z", "N", 4, 0 },;                       //  24
   { "LPI8L", "N", 6, 2 },;                       //  25
   { "LPI8Z", "N", 4, 0 } }                       //  26

// Create: DZIENNE.DBF
public aDZIENNEdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "MC", "C", 2, 0 },;                          //   4
   { "DZIEN", "C", 2, 0 },;                       //   5
   { "NUMER", "C", 10, 0 },;                      //   6
   { "NUMER_RACH", "C", 10, 0 },;                 //   7
   { "NETTO", "N", 11, 2 },;                      //   8
   { "STAWKA", "C", 2, 0 },;                      //   9
   { "WARTVAT", "N", 11, 2 } }                    //   10

// Create: EDEKLAR.DBF
public aEDEKLARdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "FIRMA", "C", 3, 0 },;                       //   2
   { "MIESIAC", "C", 2, 0 },;                     //   3
   { "OSOBA", "C", 3, 0 },;                       //   4
   { "RODZAJ", "C", 16, 0 },;                     //   5
   { "KOREKTA", "L", 1, 0 },;                     //   6
   { "PODPISANY", "L", 1, 0 },;                   //   7
   { "PODPISCER", "L", 1, 0 },;                   //   8
   { "JEST_UPO", "L", 1, 0 },;                    //   9
   { "TEST", "L", 1, 0 },;                        //   10
   { "SKROT", "C", 120, 0 },;                     //   11
   { "STATUS", "C", 16, 0 },;                     //   12
   { "STATOPIS", "C", 255, 0 },;                  //   13
   { "UTWORZONO", "@", 8, 0 },;                   //   14
   { "WYSLANO", "@", 8, 0 } }                     //   15

// Create: ETATY.DBF
public aETATYdbf := {;
   { "ID", "+", 4, 0 },;                          // 1
   { "DEL", "C", 1, 0 },;                         // 2
   { "FIRMA", "C", 3, 0 },;                       // 3
   { "IDENT", "C", 5, 0 },;                       // 4
   { "MC", "C", 2, 0 },;                          // 5
   { "BRUT_ZASAD", "N", 8, 2 },;                  // 6
   { "BRUT_PREMI", "N", 8, 2 },;                  // 7
   { "DOPL_OPOD", "N", 8, 2 },;                   // 8
   { "DOPL_BZUS", "N", 8, 2 },;                   // 9
   { "DNI_CHOROB", "N", 2, 0 },;                  // 10
   { "STA_CHOROB", "N", 7, 2 },;                  // 11
   { "ODL_CHOROB", "N", 8, 2 },;                  // 12
   { "IL_DNI_ROB", "N", 2, 0 },;                  // 13
   { "DNI_BEZPL", "N", 2, 0 },;                   // 14
   { "STA_BEZPL", "N", 7, 2 },;                   // 15
   { "ODL_BEZPL", "N", 8, 2 },;                   // 16
   { "BRUTTO6", "N", 8, 2 },;                     // 17
   { "IL_MIE6", "N", 2, 0 },;                     // 18
   { "DNI_ZASCHO", "N", 2, 0 },;                  // 19
   { "STA_ZASCHO", "N", 7, 2 },;                  // 20
   { "DOP_ZASCHO", "N", 8, 2 },;                  // 21
   { "DNI_ZAS100", "N", 2, 0 },;                  // 22
   { "STA_ZAS100", "N", 7, 2 },;                  // 23
   { "DOP_ZAS100", "N", 8, 2 },;                  // 24
   { "PENSJA", "N", 8, 2 },;                      // 25
   { "BRUT_RAZEM", "N", 8, 2 },;                  // 26
   { "KOSZT", "N", 8, 2 },;                       // 27
   { "DOCHOD", "N", 8, 2 },;                      // 28
   { "STAW_PODAT", "N", 2, 0 },;                  // 29
   { "ODLICZ", "N", 8, 2 },;                      // 30
   { "PODATEK", "N", 8, 2 },;                     // 31
   { "NETTO", "N", 8, 2 },;                       // 32
   { "DOPL_NIEOP", "N", 8, 2 },;                  // 33
   { "ODL_NIEOP", "N", 8, 2 },;                   // 34
   { "DO_WYPLATY", "N", 8, 2 },;                  // 35
   { "STANOWISKO", "C", 40, 0 },;                 // 36
   { "UWAGI", "C", 70, 0 },;                      // 37
   { "WYMIARL", "N", 3, 0 },;                     // 38
   { "WYMIARM", "N", 3, 0 },;                     // 39
   { "ZUS_ZASCHO", "N", 8, 2 },;                  // 40
   { "ZUS_PODAT", "N", 8, 2 },;                   // 41
   { "ZUS_RKCH", "N", 8, 2 },;                    // 42
   { "ZASIL_RODZ", "N", 8, 2 },;                  // 43
   { "ZASIL_PIEL", "N", 8, 2 },;                  // 44
   { "ILOSO_RODZ", "N", 1, 0 },;                  // 45
   { "ILOSO_PIEL", "N", 1, 0 },;                  // 46
   { "STAW_PUZ", "N", 5, 2 },;                    // 47
   { "STAW_PUE", "N", 5, 2 },;                    // 48
   { "STAW_PUR", "N", 5, 2 },;                    // 49
   { "STAW_PUC", "N", 5, 2 },;                    // 50
   { "STAW_PUW", "N", 5, 2 },;                    // 51
   { "STAW_PSUM", "N", 5, 2 },;                   // 52
   { "STAW_PFP", "N", 5, 2 },;                    // 53
   { "STAW_PFG", "N", 5, 2 },;                    // 54
   { "STAW_PF3", "N", 5, 2 },;                    // 55
   { "STAW_PF2", "N", 5, 2 },;                    // 56
   { "STAW_FUZ", "N", 5, 2 },;                    // 57
   { "STAW_FUE", "N", 5, 2 },;                    // 58
   { "STAW_FUR", "N", 5, 2 },;                    // 59
   { "STAW_FUC", "N", 5, 2 },;                    // 60
   { "STAW_FUW", "N", 5, 2 },;                    // 61
   { "STAW_FSUM", "N", 5, 2 },;                   // 62
   { "STAW_FFP", "N", 5, 2 },;                    // 63
   { "STAW_FFG", "N", 5, 2 },;                    // 64
   { "STAW_FF3", "N", 5, 2 },;                    // 65
   { "STAW_FF2", "N", 5, 2 },;                    // 66
   { "WAR_PUZ", "N", 8, 2 },;                     // 67
   { "WAR_PUZO", "N", 8, 2 },;                    // 68
   { "WAR_PUE", "N", 8, 2 },;                     // 69
   { "WAR_PUR", "N", 8, 2 },;                     // 70
   { "WAR_PUC", "N", 8, 2 },;                     // 71
   { "WAR_PUW", "N", 8, 2 },;                     // 72
   { "WAR_PSUM", "N", 8, 2 },;                    // 73
   { "WAR_PFP", "N", 8, 2 },;                     // 74
   { "WAR_PFG", "N", 8, 2 },;                     // 75
   { "WAR_PF3", "N", 8, 2 },;                     // 76
   { "WAR_PF2", "N", 8, 2 },;                     // 77
   { "WAR_FUZ", "N", 8, 2 },;                     // 78
   { "WAR_FUE", "N", 8, 2 },;                     // 79
   { "WAR_FUR", "N", 8, 2 },;                     // 80
   { "WAR_FUC", "N", 8, 2 },;                     // 81
   { "WAR_FUW", "N", 8, 2 },;                     // 82
   { "WAR_FSUM", "N", 8, 2 },;                    // 83
   { "WAR_FFP", "N", 8, 2 },;                     // 84
   { "WAR_FFG", "N", 8, 2 },;                     // 85
   { "WAR_FF3", "N", 8, 2 },;                     // 86
   { "WAR_FF2", "N", 8, 2 },;                     // 87
   { "TERM_WYP", "C", 1, 0 },;                    // 88
   { "DATA_WYP", "D", 8, 0 },;                    // 89
   { "DATA_ZAL", "D", 8, 0 },;                    // 90
   { "KW_PRZELEW", "N", 8, 2 },;                  // 91
   { "JAKI_PRZEL", "C", 1, 0 },;                  // 92
   { "PRZEL_NAKO", "N", 8, 2 },;                  // 93
   { "KOD_KASY", "C", 3, 0 },;                    // 94
   { "KOD_TYTU", "C", 6, 0 },;                    // 95
   { "PRO_ZASCHO", "N", 2, 0 },;                  // 96
   { "PRO_ZASC20", "N", 2, 0 },;                  // 97
   { "DNI_ZASC20", "N", 2, 0 },;                  // 98
   { "STA_ZASC20", "N", 7, 2 },;                  // 99
   { "DOP_ZASC20", "N", 8, 2 },;                  // 100
   { "STAW_PZK", "N", 5, 2 },;                    // 101
   { "NADPL_SPO", "C", 1, 0 },;                   // 102
   { "NADPL_KWO", "N", 8, 2 },;                   // 103
   { "DO_PIT4", "C", 6, 0 },;                     // 104
   { "DOCHODPOD", "N", 8, 2 },;                   // 105
   { "ZAOPOD", "N", 1, 0 },;                      // 106
   { "PIT4RC4", "N", 8, 2 },;                     // 107
   { "PIT4RC5", "N", 8, 2 },;                     // 108
   { "PIT4RC6", "N", 8, 2 },;                     // 109
   { "PIT4RC7", "N", 8, 2 },;                     // 110
   { "PIT4RC8", "N", 8, 2 },;                     // 111
   { "OSWIAD26R", "C", 1, 0 },;                   // 112
   { "STAW_PODA2", "N", 5, 2 },;                  // 113
   { "PPK", "C", 1, 0 },;                         // 114 PPK aktywne
   { "PPKZS1", "N", 5, 2 },;                      // 115 PPK Wpˆata podstawowa pracownik¢w - stawka
   { "PPKZK1", "N", 8, 2 },;                      // 116 PPK Wpˆata podstawowa pracownik¢w - kwota
   { "PPKZS2", "N", 5, 2 },;                      // 117 PPK Wpˆata dodatkowa pracownik¢w - stawka
   { "PPKZK2", "N", 8, 2 },;                      // 118 PPK Wpˆata dodatkowa pracownik¢w - kwota
   { "PPKPS1", "N", 5, 2 },;                      // 119 PPK Wpˆata podstawowa pracodawcy - stawka
   { "PPKPK1", "N", 8, 2 },;                      // 120 PPK Wpˆata podstawowa pracodawcy - kwota
   { "PPKPS2", "N", 5, 2 },;                      // 121 PPK Wpˆata dodatkowa pracodawcy - stawka
   { "PPKPK2", "N", 8, 2 },;                      // 122 PPK Wpˆata dodatkowa pracodawcy - kwota
   { "PPKPPM", "N", 8, 2 },;                      // 123 PPK Wpˆaty pracodawcy z pop. miesi¥ca
   { "PPKIDEPPK", "C", 50, 0 },;                  // 124 PPK Identyfikator ewidencji PPK uczestnika PPK
   { "ZASI_BZUS", "N", 8, 2 },;                   // 125 Zasiˆki od pracodawcy bez ZUS
   { "ULGAKLSRA", "C", 1, 0 },;                   // 126 Odlicz ulge dla klasy sredniej
   { "ULGAKLSRK", "N", 8, 2 },;                   // 127 Kwota ulgi dla klasy sredniej
   { "ODLICZENIE", "C", 1, 0 },;                  // 128 Odliczenie kwoty wolnej
   { "WNIOSTERM", "C", 1, 0 },;                   // 129 Wniosek o nieprzedluzanie terminu
   { "PODNIEP", "N", 8, 2 },;                     // 130 Niepoprana zaliczka podatku w danym miesacu
   { "WAR_PUZW", "N", 8, 2 } }                    // 131 Wyliczona skladka zdrowotna

// Create: EWID.DBF
public aEWIDdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3   Nr rekordu tablicy 'firma'
   { "MC", "C", 2, 0 },;                          //  4   Miesiac (kol 2)
   { "DZIEN", "C", 2, 0 },;                       //  5   Dzien (kol 2)
   { "DATAPRZY", "D", 8, 0 },;                    //  6   Data uzyskania przychodu (kol 3)
   { "NUMER", "C", 100, 0 },;                     //  7   Nr rachunku, faktury lub dziennego zestawienia sprzedazy (kol 4)
   { "TRESC", "C", 30, 0 },;                      //  8   Opis zdarzenia
   { "HANDEL", "N", 11, 2 },;                     //  9   Wartosc sprzedazy op. st. 8,5% (kol 11)
   { "PRODUKCJA", "N", 11, 2 },;                  //  10  Wartosc sprzedazy op. st. 10% (kol 10)
   { "USLUGI", "N", 11, 2 },;                     //  11  Wartosc sprzedazy op. st. 12,5% (kol 8)
   { "UWAGI", "C", 200, 0 },;                     //  12  Uwagi (kol 13)
   { "ZAPLATA", "C", 1, 0 },;                     //  13  Zaplata - '1' - Zaplacone, '2' - Czesciowo zaplacone, '3' - Niezaplacone
   { "KWOTA", "N", 11, 2 },;                      //  14  Zaplacono kwota
   { "LP", "N", 5, 0 },;                          //  15  L.p. ewidencji
   { "ZAPIS", "N", 10, 0 },;                      //  16  NIEUZYWANE
   { "REJZID", "N", 5, 0 },;                      //  17  Numer rekordu w tablicy 'rejs'
   { "RY20", "N", 11, 2 },;                       //  18  Wartosc sprzedazy op. st. 17% (kol 5)
   { "RY17", "N", 11, 2 },;                       //  19  Wartosc sprzedazy op. st. 15% (kol 6)
   { "RY10", "N", 11, 2 },;                       //  20  Wartosc sprzedazy op. st. 3% (kol 13)
   { "RYK07", "N", 11, 2 },;                      //  21  Wartosc sprzedazy op. st. 5,5% (kol 12)
   { "RYK08", "N", 11, 2 },;                      //  22  Wartosc sprzedazy op. st. 2% (kol dodatkowa)
   { "RYK09", "N", 11, 2 },;                      //  23  Wartosc sprzedazy op. st. 14% (kol 7)
   { "RYK10", "N", 11, 2 } }                      //  24  Wartosc sprzedazy op. st. 12% (kol 9)

// Create: EWIDPOJ.DBF
public aEWIDPOJdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "MC", "C", 2, 0 },;                          //   4
   { "DZIEN", "C", 2, 0 },;                       //   5
   { "NRREJ", "C", 8, 0 },;                       //   6
   { "NRKOL", "C", 2, 0 },;                       //   7
   { "TRASA", "C", 35, 0 },;                      //   8
   { "CEL", "C", 35, 0 },;                        //   9
   { "KM", "N", 4, 0 } }                          //  10

// Create: EWIDZWR.DBF
public aEWIDZWRdbf := { ;
   { "ID", "+", 4, 0 }, ;
   { "FIRMA", "C", 3, 0 }, ;                      //   1
   { "KASAFID", "I", 4, 0 }, ;                    //   2 ID Kasy fiskalnej
   { "MC", "C", 2, 0 }, ;                         //   3 Miesiac zwrotu
   { "DZIEN", "C", 2, 0 }, ;                      //   4 Dzien zwrotu
   { "NRDOK", "C", 64, 0 }, ;                     //   6 Nr paragonu fiskalnego
   { "DATASP", "D", 8, 0 }, ;                     //   6 Data sprzedazy
   { "TOWAR", "C", 200, 0 }, ;                    //   7 Nazwa towaru/uslugi
   { "CALOSC", "C", 1, 0 }, ;                     //   8 Zwrot calosci kwoty/czesci kwoty
   { "BRUTA", "N", 11, 2 }, ;                     //   9 Wartosc brutto A
   { "VATA", "N", 11, 2 }, ;                      //  10 Wartosc VAT A
   { "BRUTB", "N", 11, 2 }, ;                     //  11 Wartosc brutto B
   { "VATB", "N", 11, 2 }, ;                      //  12 Wartosc VAT B
   { "BRUTC", "N", 11, 2 }, ;                     //  13 Wartosc brutto C
   { "VATC", "N", 11, 2 }, ;                      //  14 Wartosc VAT C
   { "BRUTD", "N", 11, 2 }, ;                     //  15 Wartosc brutto D
   { "VATD", "N", 11, 2 }, ;                      //  16 Wartosc VAT D
   { "BRUTE", "N", 11, 2 }, ;                     //  17 Wartosc brutto E
   { "UWAGI", "C", 255, 0 } }                     //  18 Uwagi

// Create: FAKTURY.DBF
public aFAKTURYdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "REC_NO", "N", 5, 0 },;                      //  4
   { "MC", "C", 2, 0 },;                          //  5
   { "DZIEN", "C", 2, 0 },;                       //  6
   { "NUMER", "N", 5, 0 },;                       //  7
   { "NAZWA", "C", 200, 0 },;                     //  8
   { "ADRES", "C", 200, 0 },;                     //  9
   { "SPOSOB_P", "N", 1, 0 },;                    //  10
   { "TERMIN_Z", "N", 2, 0 },;                    //  11
   { "KWOTA", "N", 12, 2 },;                      //  12
   { "DATAS", "D", 8, 0 },;                       //  13
   { "DATAZ", "D", 8, 0 },;                       //  14
   { "ZAMOWIENIE", "C", 30, 0 },;                 //  15
   { "NR_IDENT", "C", 30, 0 },;                   //  16
   { "RACH", "C", 1, 0 },;                        //  17
   { "ODBNAZWA", "C", 200, 0 },;                  //  18
   { "ODBADRES", "C", 200, 0 },;                  //  19
   { "ODBOSOBA", "C", 30, 0 },;                   //  20
   { "KOMENTARZ", "C", 60, 0 },;                  //  21
   { "OPLSKARB", "N", 12, 2 },;                   //  22
   { "PODDAROW", "N", 12, 2 },;                   //  23
   { "PODCYWIL", "N", 12, 2 },;                   //  24
   { "NRREPERTA", "C", 10, 0 },;                  //  25
   { "EXPORT", "C", 1, 0 },;                      //  26
   { "KRAJ", "C", 2, 0 },;                        //  27
   { "UE", "C", 1, 0 },;                          //  28
   { "WARDOST", "C", 3, 0 },;                     //  29
   { "WARTRANSA", "C", 2, 0 },;                   //  30
   { "WARTRANSP", "C", 1, 0 },;                   //  31 T - nowa wersja faktury VAT (z bruttem) (do wer. 22.5.0 nieu¾ywane)
   { "PRZEZNACZ", "C", 40, 0 },;                  //  32
   { "DATA2TYP", "C", 1, 0 },;                    //  33
   { "FAKTTYP", "C", 60, 0 },;                    //  34
   { "ROZRZAPF", "C", 1, 0 },;                    //  35
   { "ZAP_TER", "N", 3, 0 },;                     //  36
   { "ZAP_DAT", "D", 8, 0 },;                     //  37
   { "ZAP_WART", "N", 11, 2 },;                   //  38
   { "SPLITPAY", "C", 1, 0 },;                    //  39
   { "OPCJE", "C", 32, 0 },;                      //  40
   { "PROCEDUR", "C", 32, 0 },;                   //  41
   { "KSGDATA", "N", 1, 0 },;                     //  42 Ksi©guj: 0 - w akt. miesi¥cu, 1 - nie ksieguj, 2 - w poprzednim miesi¥cu
   { "KOREKTA", "C", 1, 0 },;                     //  43 Czy faktura koryguj¥ca - 'T' - tak, 'N' - nie
   { "DOKKORID", "N", 5, 0 },;                    //  44 Nr ID powi¥zanej faktury / faktury koryguj¥cej
   { "PRZYCZKOR", "C", 200, 0 },;                 //  45 Przyczyna korekty
   { "RODZDOW", "C", 6, 0 } }                     //  46 Rodzaj dowodu - RO, WEW, FP

// Create: FAKTURYW.DBF
public aFAKTURYWdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "REC_NO", "N", 5, 0 },;                      //  4
   { "MC", "C", 2, 0 },;                          //  5
   { "DZIEN", "C", 2, 0 },;                       //  6
   { "NUMER", "N", 5, 0 },;                       //  7
   { "NAZWA", "C", 200, 0 },;                     //  8
   { "ADRES", "C", 200, 0 },;                     //  9
   { "SPOSOB_P", "N", 1, 0 },;                    //  10
   { "TERMIN_Z", "N", 2, 0 },;                    //  11
   { "KWOTA", "N", 12, 2 },;                      //  12
   { "DATAS", "D", 8, 0 },;                       //  13
   { "DATAZ", "D", 8, 0 },;                       //  14
   { "ZAMOWIENIE", "C", 40, 0 },;                 //  15
   { "NR_IDENT", "C", 30, 0 },;                   //  16
   { "RACH", "C", 1, 0 },;                        //  17
   { "ODBNAZWA", "C", 60, 0 },;                   //  18
   { "ODBADRES", "C", 40, 0 },;                   //  19
   { "ODBOSOBA", "C", 30, 0 },;                   //  20
   { "KOMENTARZ", "C", 80, 0 },;                  //  21
   { "OPLSKARB", "N", 12, 2 },;                   //  22
   { "PODDAROW", "N", 12, 2 },;                   //  23
   { "PODCYWIL", "N", 12, 2 },;                   //  24
   { "NRREPERTA", "C", 10, 0 },;                  //  25
   { "EXPORT", "C", 1, 0 },;                      //  26
   { "KRAJ", "C", 2, 0 },;                        //  27
   { "UE", "C", 1, 0 },;                          //  28
   { "WARDOST", "C", 3, 0 },;                     //  29
   { "WARTRANSA", "C", 2, 0 },;                   //  30
   { "WARTRANSP", "C", 1, 0 },;                   //  31
   { "PRZEZNACZ", "C", 40, 0 },;                  //  32
   { "WALUTA", "C", 3, 0 },;                      //  33
   { "KURS", "N", 10, 4 },;                       //  34
   { "TABELA", "C", 20, 0 },;                     //  35
   { "KURSDATA", "D", 8, 0 },;                    //  36
   { "PODATKI", "N", 12, 2 },;                    //  37
   { "CLO", "N", 12, 2 },;                        //  38
   { "TRANSPORT", "N", 12, 2 },;                  //  39
   { "PROWIZJA", "N", 12, 2 },;                   //  40
   { "OPAKOWAN", "N", 12, 2 },;                   //  41
   { "UBEZPIECZ", "N", 12, 2 },;                  //  42
   { "INNEKOSZ", "N", 12, 2 },;                   //  43
   { "OPISFAKT", "C", 50, 0 } }                   //  44

// Create: FIRMA.DBF
public aFIRMAdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "SYMBOL", "C", 10, 0 },;                     //  3  Symbol
   { "NAZWA", "C", 60, 0 },;                      //  4  Nazwa pelna
   { "NAZWA_SKR", "C", 60, 0 },;                  //  5  Nazwa skrocona
   { "SPOLKA", "L", 1, 0 },;                      //  6  .T. - Spolka, .F. - Osoba fizyczna
   { "ORGAN", "N", 2, 0 },;                       //  7  Organ rejestrowy - Nr rekordu tablicy "organy"
   { "REJESTR", "N", 2, 0 },;                     //  8  NIEUZYWANE Nazwa rejestrowa - Nr rekordu tablicy "rejestry"
   { "MIEJSC", "C", 20, 0 },;                     //  9  Miejscowosc
   { "GMINA", "C", 20, 0 },;                      //  10 Gmina
   { "ULICA", "C", 20, 0 },;                      //  11 Ulica
   { "NR_DOMU", "C", 5, 0 },;                     //  12 Nr budynku
   { "NR_MIESZK", "C", 5, 0 },;                   //  13 Nr lokalu
   { "KOD_P", "C", 6, 0 },;                       //  14 Kod pocztowy
   { "POCZTA", "C", 20, 0 },;                     //  15 Poczta
   { "SKRYTKA", "C", 5, 0 },;                     //  16 NIEUZYWANE
   { "TEL", "C", 10, 0 },;                        //  17 Nr tel
   { "FAX", "C", 10, 0 },;                        //  18 Nr fax
   { "TLX", "C", 10, 0 },;                        //  19 NIEUZYWANE Nr telex
   { "PRZEDM", "C", 40, 0 },;                     //  20 Nazwa skrocona do deklaracji ZUS
   { "KGN1", "C", 8, 0 },;                        //  21 NIEUZYWANE KGN
   { "EKD1", "C", 8, 0 },;                        //  22 NIEUZYWANE KPD
   { "NR_REGON", "C", 35, 0 },;                   //  23 REGON
   { "NR_KONTA", "C", 32, 0 },;                   //  24 Nr konta bankowego
   { "BANK", "C", 30, 0 },;                       //  25 Nazwa banku
   { "NAZWISKO", "C", 60, 0 },;                   //  26 Nazwisko wˆa˜ciciela - Klucz do tablicy "spolka" pole "nazwiako"
   { "NIP", "C", 13, 0 },;                        //  27 NIP
   { "NKP", "C", 15, 0 },;                        //  28 NIEUZYWANE NKP
   { "ODZUS", "C", 20, 0 },;                      //  29 NIEUZYWANE
   { "NR_FAKT", "N", 5, 0 },;                     //  30 Kolejny numer faktury
   { "LICZBA", "N", 5, 0 },;                      //  31 Nr poczatkowy ksiegi
   { "VAT", "C", 1, 0 },;                         //  32 Platnik VAT - 'T' tak, 'N' nie
   { "NR_RACH", "N", 5, 0 },;                     //  33 Kolejny nr rachunku (faktura dla nie-vatowca)
   { "KOR_FAKT", "N", 5, 0 },;                    //  34 NIEUZYWANE
   { "KOR_RACH", "N", 5, 0 },;                    //  35 NIEUZYWANE
   { "NR_SKUP", "N", 5, 0 },;                     //  36 NIEUZYWANE
   { "DATAVAT", "D", 8, 0 },;                     //  37 NIEUZYWANE
   { "DETAL", "C", 1, 0 },;                       //  38 Rachunki wprowadzaj bruttem - 'T' - tak, 'N' - nie
   { "LICZBA_WYP", "N", 5, 0 },;                  //  39 Licba poczatkowa wyposazenia
   { "RYCZALT", "C", 1, 0 },;                     //  40 Ryczaˆtowiec - 'T' - tak, 'N' - nie (PKPIR)
   { "SKARB", "N", 3, 0 },;                       //  41 Urzad skarboy - Nr rekordu tablicy "urzedy"
   { "DATA_ZAL", "D", 8, 0 },;                    //  42 Data rozpoczecia dzialalnosci
   { "DATA_REJ", "D", 8, 0 },;                    //  43 Data rejestracji
   { "NUMER_REJ", "C", 11, 0 },;                  //  44 Numer rejestrowy
   { "PARAM_WOJ", "C", 20, 0 },;                  //  45 Wojewodztwo
   { "PARAM_POW", "C", 20, 0 },;                  //  46 Powiat
   { "HASLO", "C", 10, 0 },;                      //  47 Haslo do firmy
   { "FAKT_MIEJ", "C", 20, 0 },;                  //  48 NIEUZYWANE
   { "VATOKRES", "C", 1, 0 },;                    //  49 NIEUZYWANE
   { "PARAP_PUW", "N", 5, 2 },;                   //  50 ?? NIEUZYWANE Stawka na ubezpieczenie wypadkowe (ubezpieczony)
   { "PARAP_FUW", "N", 5, 2 },;                   //  51 ?? NIEUZYWANE Stawka na ubezpieczenie wypadkowe (platnik)
   { "PARAP_FWW", "N", 5, 2 },;                   //  52 ?? NIEUZYWANE Stawka na ubezpieczenie wypadkowe ?? (platnik)
   { "NIPUE", "C", 13, 0 },;                      //  53 NIP UE
   { "ROKOPOD", "N", 11, 2 },;                    //  54 NIEUZYWANE
   { "ROKOGOL", "N", 11, 2 },;                    //  55 NIEUZYWANE
   { "STRUSPRWY", "N", 6, 2 },;                   //  56 NIEUZYWANE
   { "STRUSPROB", "N", 6, 2 },;                   //  57 Struktura sprzedazy - Przyjety wskazn.odliczenia
   { "NR_FAKTW", "N", 5, 0 },;                    //  58 Kolejny nr faktury wewnetrznej
   { "DEKLNAZWI", "C", 20, 0 },;                  //  59 PRZESTARZALE Nazisko na podpisie wydruku deklaracji
   { "DEKLIMIE", "C", 15, 0 },;                   //  60 PRZESTARZALE Imie na podpisie wydruku deklaracji
   { "DEKLTEL", "C", 25, 0 },;                    //  61 PRZESTARZALE Telefon na podpisie wydruku deklaracji
   { "DATAKS", "C", 1, 0 },;                      //  62 Domyslna data ksiegowania do ksiegi - 'W' - wplywu, 'D' - dokumentu
   { "PITOKRES", "C", 1, 0 },;                    //  63 Podatek dochodowy obliczac Miesiecznie/Kwartalnie - 'M' - miesiecznie, 'K' - kwartalnie
   { "VATOKRESDR", "C", 1, 0 },;                  //  64 Sprawd« dat© dokumentu przy imporcie z JPK - NIEUZYWANE do wer 22.5b
   { "VATFORDR", "C", 2, 0 },;                    //  65 Rodzaj VAT (miesiecznie/kwartalnie) - ' 7' - miesiecznie, '7K' - kwartalnie
   { "UEOKRES", "C", 1, 0 },;                     //  66 PRZESTAZALE Deklaracja VAT-UE Miesiecznie/Kwartalnie - 'M' - miesiecznie, 'K' - kwartalnie
   { "DATA2TYP", "C", 1, 0 },;                    //  67 Domyslna druga data na fakturze - D-dokonanie dostawy,T-zakonczenie dostawy,U-wykonanie uslugi,Z-zaliczka
   { "ROZRZAPK", "C", 1, 0 },;                    //  68 Sledzenie zaplat w ksiedze
   { "ROZRZAPS", "C", 1, 0 },;                    //  69 Sledzenie zaplat w rej. sprzedazy
   { "ROZRZAPZ", "C", 1, 0 },;                    //  70 Sledzenie zaplat w rej. zakupow
   { "ROZRZAPF", "C", 1, 0 },;                    //  71 Sledzenie zaplat w fakturowaniu
   { "RODZNRKS", "C", 1, 0 },;                    //  72 Rodzaj numeru ksiegi 'M' - miesiecznie, 'R' - rocznie
   { "EMAIL", "C", 60, 0 },;                      //  73 Adres email do JPK
   { "PPKPS1", "N", 5, 2 },;                      //  74 PPK Wpˆata podstawowa pracodawcy - stawka
   { "PPKPS2", "N", 5, 2 },;                      //  75 PPK Wpˆata dodatkowa pracodawcy - stawka
   { "PPKKWGR", "N", 9, 2 },;                     //  76 PPK Kwota graniczna dla obni¾enia stawki podstawowej deklarowanej przez pracownika
   { "PPKWPLMC", "C", 1, 0 },;                    //  77 PPK T - Wpˆata do PPK w tym samym miesi¥cu, N - wpˆata do 15 dnia kolejnego mc.
   { "PPKEIDKADR", "C", 1, 0 },;                  //  78 PPK doˆ¥czaj pole "ID Kadrowy"
   { "PPKEIDEPPK", "C", 1, 0 },;                  //  79 PPK doˆ¥czaj pole "ID Kadrowy"
   { "PPKEIDPZIF", "C", 1, 0 },;                  //  80 PPK doˆ¥czaj pole "ID Kadrowy"
   { "RODZAJDRFV", "C", 1, 0 },;                  //  81 Rodzaj wydruku faktury: G - graficzny, T - tekstowy
   { "RODZAJFNV", "C", 1, 0 },;                   //  82 Rodzaj dok. sprzedazy dla nie watowca: F - faktura, R - rachunek
   { "ZUSPODMIE", "C", 1, 0 },;                   //  83 Podstawa do zdrowotnego - przych¢d z 'B' - biezacy miesiac, 'P' - poprzedni miesiac
   { "ZUSPODNAR", "C", 1, 0 },;                   //  84 Podstawa do zdrowotnego - przych¢d: 'M' - miesi©cznie, 'N' - narastaj¥co
   { "ZUSSKLMIE", "C", 1, 0 },;                   //  83 Skˆadki spoˆeczne odliczaj w - 'B' - biezacy miesiac, 'N' - nast©pny miesiac
   { "SALPRGID", "C", 64, 0 },;                   //  84 Saldeo company_program_id
   { "SALSALID", "C", 64, 0 },;                   //  85 Saldeo saldeo id
   { "SYGNALVAT", "C", 1, 0 } }                   //  86 Sygnaˆ o przekroczeniu VAT

// Create: KARTST.DBF
public aKARTSTdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "REC_NO", "N", 5, 0 },;                      //  4
   { "NREWID", "C", 10, 0 },;                     //  5
   { "NAZWA", "C", 40, 0 },;                      //  6
   { "OPIS", "C", 60, 0 },;                       //  7
   { "KRST", "C", 8, 0 },;                        //  8
   { "DATA_ZAK", "D", 8, 0 },;                    //  9
   { "DOWOD_ZAK", "C", 40, 0 },;                  //  10
   { "ZRODLO", "C", 60, 0 },;                     //  11
   { "WARTOSC", "N", 12, 2 },;                    //  12
   { "NR_OT", "C", 10, 0 },;                      //  13
   { "NR_LT", "C", 10, 0 },;                      //  14
   { "DATA_LIK", "D", 8, 0 },;                    //  15
   { "WLASNOSC", "C", 1, 0 },;                    //  16
   { "PRZEZNACZ", "C", 1, 0 },;                   //  17
   { "SPOSOB", "C", 1, 0 },;                      //  18
   { "STAWKA", "N", 6, 2 },;                      //  19
   { "WSPDEG", "N", 4, 2 },;                      //  20
   { "WART_ULG", "N", 12, 2 },;                   //  21
   { "VATZAKUP", "N", 12, 2 },;                   //  22
   { "VATODLI", "N", 12, 2 },;                    //  23
   { "VATKOROKR", "N", 2, 0 },;                   //  24
   { "DATA_SPRZ", "D", 8, 0 },;                   //  25
   { "VATSPRZ", "C", 1, 0 } }                     //  26

// Create: KARTSTMO.DBF
public aKARTSTMOdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "IDENT", "C", 5, 0 },;                       //   3
   { "DATA_MOD", "D", 8, 0 },;                    //   4
   { "WART_MOD", "N", 12, 2 },;                   //   5
   { "OPIS_MOD", "C", 60, 0 } }                   //   6

// Create: KASAFISK.DBF
public aKASAFISKdbf := { ;
   { "ID", "+", 4, 0 }, ;                         //   1
   { "FIRMA", "C", 3, 0 }, ;                      //   2
   { "AKTYWNY", "C", 1, 0 }, ;                    //   3 Aktywny
   { "NAZWA", "C", 32, 0 }, ;                     //   4 Nazwa wyswietlana
   { "NUMER", "C", 64, 0 }, ;                     //   5 Numer seryjny
   { "OPIS", "C", 255, 0 } }                      //   6 Opis

// Create: KAT_SPR.DBF
public aKAT_SPRdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "SYMB_REJ", "C", 2, 0 },;                    //   4
   { "OPIS", "C", 40, 0 },;                       //   5
   { "OPCJE", "C", 32, 0 },;                      //   6   Oznaczenia
   { "KOLUMNA", "C", 2, 0 },;                     //   7   Kolumna ksiegi / ewidencji
   { "PROCEDUR", "C", 32, 0 },;                   //   8   Procedure
   { "RODZDOW", "C", 6, 0 },;                     //   9   Rodzaj dowodu
   { "SEK_CV7", "C", 2, 0 },;                     //   10  Sekcja VAT 7
   { "SALPRGID", "C", 64, 0 },;                   //   11  Saldeo company_program_id
   { "SALSALID", "C", 64, 0 } }                   //   12  Saldeo saldeo id

// Create: KAT_ZAK.DBF
public aKAT_ZAKdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "SYMB_REJ", "C", 2, 0 },;                    //   4
   { "OPIS", "C", 40, 0 },;                       //   5
   { "OPCJE", "C", 32, 0 },;                      //   6   Oznaczenia
   { "KOLUMNA", "C", 2, 0 },;                     //   7   Kolumna ksiegi / ewidencji
   { "PROCEDUR", "C", 32, 0 },;                   //   8   Procedure
   { "RODZDOW", "C", 6, 0 },;                     //   9   Rodzaj dowodu
   { "SEK_CV7", "C", 2, 0 },;                     //   10  Sekcja VAT 7
   { "SALPRGID", "C", 64, 0 },;                   //   11  Saldeo company_program_id
   { "SALSALID", "C", 64, 0 } }                   //   12  Saldeo saldeo id

// Create: KONTR.DBF
public aKONTRdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "NAZWA", "C", 200, 0 },;                     //  4
   { "ADRES", "C", 200, 0 },;                     //  5
   { "NR_IDENT", "C", 30, 0 },;                   //  6
   { "EXPORT", "C", 1, 0 },;                      //  7
   { "BANK", "C", 28, 0 },;                       //  8
   { "KONTO", "C", 32, 0 },;                      //  9
   { "TEL", "C", 20, 0 },;                        //  10
   { "UE", "C", 1, 0 },;                          //  11
   { "KRAJ", "C", 2, 0 },;                        //  12
   { "ZRODLO", "C", 1, 0 },;                      //  13
   { "DATASPR", "D", 8, 0 },;                     //  14
   { "NAZWASKR", "C", 70, 0 },;                   //  15  Nazwa skr¢cona
   { "DATAROZP", "D", 8, 0 },;                    //  16  Data rozpocz©cia dziaˆalno˜ci
   { "RODZAJID", "C", 1, 0 },;                    //  17  Rodzaj identyfikacji: podatkowej (1) lub innej (2)
   { "NRIDPOD", "C", 50, 0 },;                    //  18  Nr identyfikacji podatkowej
   { "KRAJWYD", "C", 2, 0 },;                     //  19  Kraj wydania
   { "KODPOCZT", "C", 8, 0 },;                    //  20  Kod pocztowy
   { "MIASTO", "C", 56, 0 },;                     //  21  Miejscowosc
   { "ULICA", "C", 65, 0 },;                      //  22  Ulica
   { "NRBUD", "C", 9, 0 },;                       //  23  Nr budynku
   { "NRLOK", "C", 10, 0 },;                      //  24  Nr lokalu
   { "SALPRGID", "C", 64, 0 },;                   //  25 Saldeo company_program_id
   { "SALSALID", "C", 64, 0 } }                   //  26 Saldeo saldeo id

public aKONTRSPRdbf := {;
   { "ID", "+", 4, 0 }, ;                         //  1
   { "NIP", "C", 10, 0 }, ;                       //  2
   { "STANNA", "D", 8, 0 }, ;                     //  3
   { "NAME", "C", 200, 0 }, ;                     //  4
   { "STATUSVAT", "C", 20, 0 }, ;                 //  5
   { "REGON", "C", 14, 0 }, ;                     //  6
   { "PESEL", "C", 11, 0 }, ;                     //  7
   { "KRS", "C", 10, 0 }, ;                       //  8
   { "RESADRES", "C", 200, 0 }, ;                 //  9
   { "WORKADR", "C", 200, 0 }, ;                  //  10
   { "REGLEGDAT", "D", 8, 0 }, ;                  //  11
   { "REGDENDAT", "D", 8, 0 }, ;                  //  12
   { "REGDENBAS", "C", 200, 0 }, ;                //  13
   { "RESTDATE", "D", 8, 0 }, ;                   //  14
   { "RESTBASIS", "C", 200, 0 }, ;                //  15
   { "REMOVDATE", "D", 8, 0 }, ;                  //  16
   { "REMOVBASI", "C", 200, 0 }, ;                //  17
   { "REQDATETM", "@", 8, 0 }, ;                  //  18
   { "REQID", "C", 16, 0 } }                      //  19

// Create: KRST.DBF
public aKRSTdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "KRST", "C", 8, 0 },;                        //   2
   { "OPIS", "C", 60, 0 },;                       //   3
   { "STAWKA", "N", 6, 2 },;                      //   4
   { "WSPDEG", "N", 6, 2 } }                      //   5

// Create: NIEOBEC.DBF
public aNIEOBECdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "IDENT", "C", 5, 0 },;                       //   4
   { "MC", "C", 2, 0 },;                          //   5
   { "DDOD", "N", 2, 0 },;                        //   6
   { "DDDO", "N", 2, 0 },;                        //   7
   { "PRZYCZYNA", "C", 15, 0 },;                  //   8
   { "PLATNE", "L", 1, 0 },;                      //   9
   { "KODZUS", "C", 3, 0 } }                      //   10


// Create: NOTES.DBF
public aNOTESdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "NOTATKA", "M", 10, 0 } }                    //   4

// Create: OPER.DBF
public aOPERdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "MC", "C", 2, 0 },;                          //  4
   { "DZIEN", "C", 2, 0 },;                       //  5
   { "NUMER", "C", 100, 0 },;                      //  6
   { "NAZWA", "C", 200, 0 },;                     //  7
   { "ADRES", "C", 200, 0 },;                     //  8
   { "TRESC", "C", 30, 0 },;                      //  9
   { "WYR_TOW", "N", 11, 2 },;                    //  10
   { "USLUGI", "N", 11, 2 },;                     //  11
   { "ZAKUP", "N", 11, 2 },;                      //  12
   { "UBOCZNE", "N", 11, 2 },;                    //  13
   { "REKLAMA", "N", 11, 2 },;                    //  14
   { "WYNAGR_G", "N", 11, 2 },;                   //  15
   { "WYDATKI", "N", 11, 2 },;                    //  16
   { "PUSTA", "N", 11, 2 },;                      //  17
   { "UWAGI", "C", 14, 0 },;                      //  18
   { "ZAPLATA", "C", 1, 0 },;                     //  19
   { "KWOTA", "N", 11, 2 },;                      //  20
   { "LP", "N", 5, 0 },;                          //  21
   { "ZAPIS", "N", 10, 0 },;                      //  22
   { "NR_IDENT", "C", 30, 0 },;                   //  23
   { "REJZID", "N", 5, 0 },;                      //  24
   { "DATA_ZAP", "D", 8, 0 },;                    //  25
   { "ROZRZAPK", "C", 1, 0 },;                    //  26
   { "ZAP_TER", "N", 3, 0 },;                     //  27
   { "ZAP_DAT", "D", 8, 0 },;                     //  28
   { "ZAP_WART", "N", 11, 2 },;                   //  29
   { "REC_NO", "N", 10, 0 },;                     //  30
   { "K16WART", "N", 11, 2 },;                    //  31
   { "K16OPIS", "C", 30, 0 },;                    //  32
   { "IFT2", "C", 1, 0 },;                        //  33
   { "IFT2SEK", "C", 3, 0 },;                     //  34
   { "IFT2KWOT", "N", 11, 0 },;                   //  35
   { "WARTZUS", "N", 11, 2 },;                    //  36 Wartosc przychodu do ZUS
   { "SALPRGID", "C", 64, 0 },;                   //  37 Saldeo company_program_id
   { "SALSALID", "C", 64, 0 } }                   //  38 Saldeo saldeo id

// Create: ORGANY.DBF
public aORGANYdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "NAZWA_ORG", "C", 60, 0 } }                  //   3

// Create: OSSREJ.DBF
public aOSSREJdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3 Ident firmy
   { "MC", "C", 2, 0 },;                          //   4 Miesiac transakcji
   { "DZIEN", "C", 2, 0 },;                       //   5 Dzien transakcji
   { "NRDOK", "C", 64, 0 },;                      //   6 Nr dowodu sprzedazy
   { "KRAJ", "C", 2, 0 },;                        //   7 Kraj
   { "TOWAR", "C", 200, 0 },;                     //   8 Ilosc i nazwa towarow
   { "STAWKARD", "C", 1, 0 },;                    //   9 Rodzaj stawki P - podstawowa, O - obnizona
   { "STAWKA", "N", 5, 2 },;                      //  10 Stawka VAT
   { "NETTOEUR", "N", 11, 2 },;                   //  11 Netto w Euro
   { "VATEUR", "N", 11, 2 },;                     //  12 Kwota VAT Euro
   { "KURS", "N", 11, 4 },;                       //  13 Sredni kurs Euro
   { "NETTOPLN", "N", 11, 2 },;                   //  14 Wartosc netto w PLN
   { "KOSZTY", "N", 11, 2 },;                     //  15 Koszty obnizajace i podwyszszajace podstawe podatkowa
   { "DATAPLAT", "D", 8, 0 },;                    //  16 Data otrzymania platnosci
   { "ZAPLATA", "N", 11, 2 },;                    //  17 Kwota otrzymanej platnosci
   { "ZALICZKA", "N", 11, 2 },;                   //  18 Kwota zaliczki otrzymanej przed dostawa
   { "INFO", "C", 200, 0 },;                      //  19 Informacje na fakturze
   { "NRZAMOW", "C", 64, 0 },;                    //  20 Nr zamowienia
   { "NRZWROT", "C", 64, 0 },;                    //  21 Nr zwrotu/reklamacji
   { "NETTOZW", "N", 11, 2 },;                    //  22 Kwota netto zwrotu/reklamacji
   { "VATZW", "N", 11, 2 },;                      //  23 Kwota VAT zwrotu/reklamacji
   { "WALUTA", "C", 3, 0 },;                      //  24 Waluta zamowienia
   { "RODZDOST", "C", 1, 0 },;                    //  25 Rodzaj dostawy - Towar czy usluga (T - towar, U - usluga)
   { "KRAJDZ", "C", 2, 0 },;                      //  26 Panstwo miejsca prowadzenia dzialalnosci
   { "NR_IDVAT", "C", 30, 0 },;                   //  27 Nr identyfikacyjny VAT
   { "NR_IDPOD", "C", 30, 0 },;                   //  28 Nr identyfikacji podatkowej
   { "SEKCJAC", "C", 1, 0 } }                     //  28 Ktora sekcja C deklaracji VIU-DO (2 - sekc. C.2, 3 - sekc. C.3)

// Create: PIT_27.DBF
public aPIT_27dbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "IDENT", "C", 5, 0 },;                       //  3
   { "P275", "N", 2, 0 },;                        //  4
   { "P276", "N", 2, 0 },;                        //  5
   { "P2728A", "N", 11, 2 },;                     //  6
   { "P2728B", "N", 11, 2 },;                     //  7
   { "P2728C", "N", 11, 2 },;                     //  8
   { "P2728D", "N", 11, 2 },;                     //  9
   { "P2728DA", "N", 11, 2 },;                    //  10
   { "P2728DB", "N", 11, 2 },;                    //  11
   { "P2729A", "N", 11, 2 },;                     //  12
   { "P2729B", "N", 11, 2 },;                     //  13
   { "P2729C", "N", 11, 2 },;                     //  14
   { "P2729D", "N", 11, 2 },;                     //  15
   { "P2729DA", "N", 11, 2 },;                    //  16
   { "P2729DB", "N", 11, 2 },;                    //  17
   { "P2746", "N", 3, 0 },;                       //  18
   { "P2747", "N", 3, 0 },;                       //  19
   { "P2748", "N", 3, 0 },;                       //  20
   { "P2749", "N", 3, 0 },;                       //  21
   { "P2750", "N", 3, 0 },;                       //  22
   { "P2751", "N", 3, 0 },;                       //  23
   { "P2746A", "N", 3, 0 },;                      //  24
   { "P2747A", "N", 3, 0 },;                      //  25
   { "P2748A", "N", 3, 0 },;                      //  26
   { "P2749A", "N", 3, 0 },;                      //  27
   { "P2750A", "N", 3, 0 },;                      //  28
   { "P2751A", "N", 3, 0 },;                      //  29
   { "P2746B", "N", 3, 0 },;                      //  30
   { "P2747B", "N", 3, 0 },;                      //  31
   { "P2748B", "N", 3, 0 },;                      //  32
   { "P2749B", "N", 3, 0 },;                      //  33
   { "P2750B", "N", 3, 0 },;                      //  34
   { "P2751B", "N", 3, 0 } }                      //  35

// Create: POZYCJE.DBF
public aPOZYCJEdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "IDENT", "C", 8, 0 },;                       //  3
   { "INDEKS", "C", 13, 0 },;                     //  4
   { "TOWAR", "C", 512, 0 },;                     //  5
   { "ILOSC", "N", 11, 3 },;                      //  6
   { "JM", "C", 5, 0 },;                          //  7
   { "CENA", "N", 12, 2 },;                       //  8
   { "WARTOSC", "N", 12, 2 },;                    //  9
   { "SWW", "C", 14, 0 },;                        //  10
   { "VAT", "C", 2, 0 },;                         //  11
   { "VATWART", "N", 12, 2 },;                    //  12
   { "BRUTTO", "N", 12, 2 },;                     //  13
   { "TARYFACEL", "C", 9, 0 } }                   //  14

// Create: POZYCJEW.DBF
public aPOZYCJEWdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "IDENT", "C", 8, 0 },;                       //  3
   { "INDEKS", "C", 13, 0 },;                     //  4
   { "TOWAR", "C", 60, 0 },;                      //  5
   { "ILOSC", "N", 11, 3 },;                      //  6
   { "JM", "C", 5, 0 },;                          //  7
   { "CENA", "N", 12, 2 },;                       //  8
   { "WARTOSC", "N", 12, 2 },;                    //  9
   { "SWW", "C", 14, 0 },;                        //  10
   { "VAT", "C", 2, 0 },;                         //  11
   { "VATWART", "N", 12, 2 },;                    //  12
   { "BRUTTO", "N", 12, 2 },;                     //  13
   { "TARYFACEL", "C", 9, 0 } }                   //  14

// Create: PRAC.DBF
public aPRACdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "REC_NO", "N", 5, 0 },;                      //  4
   { "NREWID", "C", 11, 0 },;                     //  5
   { "NAZWISKO", "C", 30, 0 },;                   //  6
   { "NAZW_RODU", "C", 30, 0 },;                  //  7
   { "IMIE1", "C", 15, 0 },;                      //  8
   { "IMIE2", "C", 15, 0 },;                      //  9
   { "PLEC", "C", 1, 0 },;                        //  10
   { "PESEL", "C", 11, 0 },;                      //  11
   { "NIP", "C", 13, 0 },;                        //  12
   { "IMIE_O", "C", 15, 0 },;                     //  13
   { "IMIE_M", "C", 15, 0 },;                     //  14
   { "MIEJSC_UR", "C", 20, 0 },;                  //  15
   { "DATA_UR", "D", 8, 0 },;                     //  16
   { "MIEJSC_ZAM", "C", 20, 0 },;                 //  17
   { "GMINA", "C", 20, 0 },;                      //  18
   { "ULICA", "C", 20, 0 },;                      //  19
   { "NR_DOMU", "C", 5, 0 },;                     //  20
   { "NR_MIESZK", "C", 5, 0 },;                   //  21
   { "KOD_POCZT", "C", 6, 0 },;                   //  22
   { "POCZTA", "C", 20, 0 },;                     //  23
   { "TELEFON", "C", 15, 0 },;                    //  24
   { "SKARB", "N", 3, 0 },;                       //  25
   { "ZATRUD", "C", 70, 0 },;                     //  26
   { "RODZ_DOK", "C", 1, 0 },;                    //  27
   { "DOWOD_OSOB", "C", 9, 0 },;                  //  28
   { "DATA_PRZY", "D", 8, 0 },;                   //  29
   { "DATA_ZWOL", "D", 8, 0 },;                   //  30
   { "ODLICZENIE", "C", 1, 0 },;                  //  31
   { "WYKSZTALC", "C", 40, 0 },;                  //  32
   { "ZAWOD_WYU", "C", 40, 0 },;                  //  33
   { "UWAGI", "C", 70, 0 },;                      //  34
   { "STATUS", "C", 1, 0 },;                      //  35
   { "PARAM_WOJ", "C", 20, 0 },;                  //  36
   { "PARAM_POW", "C", 20, 0 },;                  //  37
   { "OBYWATEL", "C", 22, 0 },;                   //  38
   { "ZAS_PRZY", "N", 8, 2 },;                    //  39
   { "ZAS_POD", "N", 8, 2 },;                     //  40
   { "ART_PRZY", "N", 8, 2 },;                    //  41
   { "ART_KOSZ", "N", 8, 2 },;                    //  42
   { "ART_POD", "N", 8, 2 },;                     //  43
   { "ORG_PRZY", "N", 8, 2 },;                    //  44
   { "ORG_KOSZ", "N", 8, 2 },;                    //  45
   { "ORG_POD", "N", 8, 2 },;                     //  46
   { "ZLE_PRZY", "N", 8, 2 },;                    //  47
   { "ZLE_KOSZ", "N", 8, 2 },;                    //  48
   { "ZLE_POD", "N", 8, 2 },;                     //  49
   { "AUT_PRZY", "N", 8, 2 },;                    //  50
   { "AUT_KOSZ", "N", 8, 2 },;                    //  51
   { "AUT_POD", "N", 8, 2 },;                     //  52
   { "INN_PRZY", "N", 8, 2 },;                    //  53
   { "INN_KOSZ", "N", 8, 2 },;                    //  54
   { "INN_POD", "N", 8, 2 },;                     //  55
   { "RODZ_ZATR", "C", 15, 0 },;                  //  56
   { "GRUP_INWA", "C", 10, 0 },;                  //  57
   { "DATA_INWA", "D", 8, 0 },;                   //  58
   { "POKREW", "C", 15, 0 },;                     //  59
   { "DATA_ZMIA", "D", 8, 0 },;                   //  60
   { "BANK", "C", 30, 0 },;                       //  61
   { "KONTO", "C", 32, 0 },;                      //  62
   { "JAKI_PRZEL", "C", 1, 0 },;                  //  63
   { "KW_PRZELEW", "N", 8, 2 },;                  //  64
   { "KOR_PRZY", "N", 11, 2 },;                   //  65
   { "KOR_KOSZ", "N", 11, 2 },;                   //  66
   { "KOR_ZALI", "N", 11, 2 },;                   //  67
   { "KOR_SPOL", "N", 11, 2 },;                   //  68
   { "KOR_ZDRO", "N", 11, 2 },;                   //  69
   { "KOR_SPOLZ", "N", 11, 2 },;                  //  70
   { "KOR_ZDROZ", "N", 11, 2 },;                  //  71
   { "KOR_ZWET", "N", 11, 2 },;                   //  72
   { "KOR_ZWEM", "N", 11, 2 },;                   //  73
   { "KOR_ZWIN", "N", 11, 2 },;                   //  74
   { "AKTYWNY", "C", 1, 0 },;                     //  75
   { "RODZOBOW", "C", 1, 0 },;                    //  76
   { "ZAGRNRID", "C", 20, 0 },;                   //  77
   { "DOKIDROZ", "C", 1, 0 },;                    //  78
   { "DOKIDKRAJ", "C", 2, 0 },;                   //  79
   { "OSWIAD26R", "C", 1, 0 },;                   //  80
   { "PPK", "C", 1, 0 },;                         //  81 PPK wˆ¥czone
   { "PPKZS1", "N", 5, 2 },;                      //  82 PPK Wpˆata podstawowa pracownik¢w - stawka
   { "PPKZS2", "N", 5, 2 },;                      //  82 PPK Wpˆata dodatkowa pracownik¢w - stawka
   { "PPKPS2", "N", 5, 2 },;                      //  83 PPK Wpˆata dodatkowa pracodawcy - stawka
   { "PPKIDKADR", "C", 10, 0 },;                  //  84 PPK ID Kadrowy (wewn©trzny) Identyfikator zatrudnienia osobyaplikacji kadrowej pracodawcy.Musi by† unikalnyw ramach danej firmy.Identyfikator pomocniczy.
   { "PPKIDEPPK", "C", 20, 0 },;                  //  85 PPK Identyfikator ewidencji PPK uczestnika PPK.
   { "PPKIDPZIF", "C", 50, 0 },;                  //  86 PPK Unikalny numer nadany przez instytucj© finansow¥, np. Nr rachunku, kt¢ry uczestnik ma nadany przez instytucj© finansow¥.
   { "PRAKTYKA", "C", 1, 0 },;                    //  87 Praktykant ( 'T' = tak, 'N' - nie )
   { "ULGAKLSRA", "C", 1, 0 },;                   //  88 Ulga dla klasy sredniej ('T'- tak )
   { "WNIOSTERM", "C", 1, 0 } }                   //  89 Wniosek o nieprzedluzanie terminu

// Create: PRAC_HZ.DBF
public aPRAC_HZdbf := {;
   { "ID", "+", 4, 0 }, ;                         //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "PRACID", "N", 8, 0 },;                      //   4 ID PRAC - id pracownika
   { "DATA_PRZY", "D", 8, 0 },;                   //   5 Data przyjecia
   { "DATA_ZWOL", "D", 8, 0 } }                   //   6 Data zwolnienia

// Create: PROFIL.DBF
public aPROFILdbf := { ;
   { "ID", "+", 4, 0 }, ;                         //   1
   { "PUNKT", "C", 32, 0 }, ;                     //   2
   { "MYSZ", "L", 1, 0 }, ;                       //   3
   { "DRUKARKA", "C", 100, 0 }, ;                 //   4
   { "MARGINL", "N", 5, 0 }, ;                    //   5
   { "MARGINP", "N", 5, 0 }, ;                    //   6
   { "MARGING", "N", 5, 0 }, ;                    //   7
   { "MARGIND", "N", 5, 0 } }                     //   8

// Create: PRZELEWY.DBF
public aPRZELEWYdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "NAZWA_PLA", "C", 56, 0 },;                  //  4
   { "ULICA_PLA", "C", 28, 0 },;                  //  5
   { "MIEJSC_PLA", "C", 28, 0 },;                 //  6
   { "BANK_PLA", "C", 28, 0 },;                   //  7
   { "KONTO_PLA", "C", 32, 0 },;                  //  8
   { "KWOTA", "N", 9, 2 },;                       //  9
   { "DATA", "D", 8, 0 },;                        //  10
   { "TRESC", "C", 104, 0 },;                     //  11
   { "NAZWA_WIE", "C", 56, 0 },;                  //  12
   { "ULICA_WIE", "C", 28, 0 },;                  //  13
   { "MIEJSC_WIE", "C", 28, 0 },;                 //  14
   { "BANK_WIE", "C", 28, 0 },;                   //  15
   { "KONTO_WIE", "C", 32, 0 },;                  //  16
   { "DOKUMENT", "C", 8, 0 } }                    //  17

// Create: PRZELPOD.DBF
public aPRZELPODdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "NAZWA_PLA", "C", 56, 0 },;                  //  4
   { "ULICA_PLA", "C", 28, 0 },;                  //  5
   { "MIEJSC_PLA", "C", 28, 0 },;                 //  6
   { "BANK_PLA", "C", 28, 0 },;                   //  7
   { "KONTO_PLA", "C", 32, 0 },;                  //  8
   { "KWOTA", "N", 9, 2 },;                       //  9
   { "DATA", "D", 8, 0 },;                        //  10
   { "TRESC", "C", 54, 0 },;                      //  11
   { "URZAD", "C", 56, 0 },;                      //  12
   { "NAZWA_WIE", "C", 56, 0 },;                  //  13
   { "ULICA_WIE", "C", 28, 0 },;                  //  14
   { "MIEJSC_WIE", "C", 28, 0 },;                 //  15
   { "BANK_WIE", "C", 28, 0 },;                   //  16
   { "KONTO_WIE", "C", 32, 0 },;                  //  17
   { "DOKUMENT", "C", 8, 0 } }                    //  18

// Create: RACHPOJ.DBF
public aRACHPOJdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "MC", "C", 2, 0 },;                          //   4
   { "DZIEN", "C", 2, 0 },;                       //   5
   { "NRREJ", "C", 8, 0 },;                       //   6
   { "NUMER", "C", 10, 0 },;                      //   7
   { "NETTO", "N", 9, 2 },;                       //   8
   { "WARTVAT", "N", 9, 2 },;                     //   9
   { "RODZAJ", "C", 40, 0 } }                     //   10

// Create: RAPORT.DBF
public aRAPORTdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "LINIA_L", "C", 190, 0 },;                   //   2
   { "LINIA_P", "C", 190, 0 } }                   //   3

// Create: REJESTRY.DBF    NIEUZYWANE
public aREJESTRYdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "NAZWA_REJ", "C", 60, 0 } }                  //   3

// Create: REJS.DBF
public aREJSdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "MC", "C", 2, 0 },;                          //  4
   { "DZIEN", "C", 2, 0 },;                       //  5
   { "NUMER", "C", 100, 0 },;                     //  6
   { "NAZWA", "C", 200, 0 },;                     //  7
   { "ADRES", "C", 200, 0 },;                     //  8
   { "NR_IDENT", "C", 30, 0 },;                   //  9
   { "TRESC", "C", 30, 0 },;                      //  10
   { "ROKS", "C", 4, 0 },;                        //  11
   { "MCS", "C", 2, 0 },;                         //  12
   { "DZIENS", "C", 2, 0 },;                      //  13
   { "KOLUMNA", "C", 2, 0 },;                     //  14
   { "UWAGI", "C", 20, 0 },;                      //  15
   { "RACH", "C", 1, 0 },;                        //  16
   { "WARTZW", "N", 11, 2 },;                     //  17
   { "WART00", "N", 11, 2 },;                     //  18
   { "WART02", "N", 11, 2 },;                     //  19
   { "WART07", "N", 11, 2 },;                     //  20
   { "WART22", "N", 11, 2 },;                     //  21
   { "WART12", "N", 11, 2 },;                     //  22
   { "VAT02", "N", 11, 2 },;                      //  23
   { "VAT07", "N", 11, 2 },;                      //  24
   { "VAT22", "N", 11, 2 },;                      //  25
   { "VAT12", "N", 11, 2 },;                      //  26
   { "NETTO", "N", 11, 2 },;                      //  27
   { "EXPORT", "C", 1, 0 },;                      //  28
   { "ZAPLATA", "C", 1, 0 },;                     //  29
   { "KWOTA", "N", 11, 2 },;                      //  30
   { "DETAL", "C", 1, 0 },;                       //  31
   { "KOREKTA", "C", 1, 0 },;                     //  32
   { "WART08", "N", 11, 2 },;                     //  33
   { "VAT08", "N", 11, 2 },;                      //  34
   { "SYMB_REJ", "C", 2, 0 },;                    //  35
   { "DATA_ZAP", "D", 8, 0 },;                    //  36  // Ulga na zle dlugi - Data uplyniecia terminu platnosci lub data zaplaty
   { "KRAJ", "C", 2, 0 },;                        //  37
   { "UE", "C", 1, 0 },;                          //  38
   { "SEK_CV7", "C", 2, 0 },;                     //  39
   { "ROZRZAPS", "C", 1, 0 },;                    //  40
   { "ZAP_TER", "N", 3, 0 },;                     //  41
   { "ZAP_DAT", "D", 8, 0 },;                     //  42
   { "ZAP_WART", "N", 11, 2 },;                   //  43
   { "OPCJE", "C", 32, 0 },;                      //  44
   { "TROJSTR", "C", 1, 0 },;                     //  45
   { "KOL36", "N", 11, 2 },;                      //  46
   { "KOL37", "N", 11, 2 },;                      //  47
   { "KOL38", "N", 11, 2 },;                      //  48
   { "KOL39", "N", 11, 2 },;                      //  49
   { "KOLUMNA2", "C", 2, 0 },;                    //  50
   { "NETTO2", "N", 11, 2 },;                     //  51
   { "DATATRAN", "D", 8, 0 },;                    //  52
   { "PROCEDUR", "C", 32, 0 },;                   //  53
   { "RODZDOW", "C", 6, 0 },;                     //  54
   { "VATMARZA", "N", 11, 2 },;                   //  55
   { "SALPRGID", "C", 64, 0 },;                   //  56 Saldeo company_program_id
   { "SALSALID", "C", 64, 0 } }                   //  57 Saldeo saldeo id

// Create: REJZ.DBF
public aREJZdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "MC", "C", 2, 0 },;                          //  4
   { "DZIEN", "C", 2, 0 },;                       //  5
   { "NUMER", "C", 100, 0 },;                     //  6
   { "NAZWA", "C", 200, 0 },;                     //  7
   { "ADRES", "C", 200, 0 },;                     //  8
   { "NR_IDENT", "C", 30, 0 },;                   //  9
   { "TRESC", "C", 30, 0 },;                      //  10
   { "ROKS", "C", 4, 0 },;                        //  11
   { "MCS", "C", 2, 0 },;                         //  12
   { "DZIENS", "C", 2, 0 },;                      //  13
   { "KOLUMNA", "C", 2, 0 },;                     //  14
   { "UWAGI", "C", 14, 0 },;                      //  15
   { "RACH", "C", 1, 0 },;                        //  16
   { "WARTZW", "N", 11, 2 },;                     //  17
   { "WART00", "N", 11, 2 },;                     //  18
   { "WART07", "N", 11, 2 },;                     //  19
   { "WART22", "N", 11, 2 },;                     //  20
   { "WART02", "N", 11, 2 },;                     //  21
   { "WART12", "N", 11, 2 },;                     //  22
   { "VAT07", "N", 11, 2 },;                      //  23
   { "VAT22", "N", 11, 2 },;                      //  24
   { "VAT02", "N", 11, 2 },;                      //  25
   { "VAT12", "N", 11, 2 },;                      //  26
   { "NETTO", "N", 11, 2 },;                      //  27
   { "EXPORT", "C", 1, 0 },;                      //  28
   { "ZAPLATA", "C", 1, 0 },;                     //  29
   { "KWOTA", "N", 11, 2 },;                      //  30
   { "DETAL", "C", 1, 0 },;                       //  31
   { "KOREKTA", "C", 1, 0 },;                     //  32
   { "SP22", "C", 1, 0 },;                        //  33
   { "SP07", "C", 1, 0 },;                        //  34
   { "SP00", "C", 1, 0 },;                        //  35
   { "SPZW", "C", 1, 0 },;                        //  36
   { "SP02", "C", 1, 0 },;                        //  37
   { "SP12", "C", 1, 0 },;                        //  38
   { "ZOM22", "C", 1, 0 },;                       //  39
   { "ZOM07", "C", 1, 0 },;                       //  40
   { "ZOM02", "C", 1, 0 },;                       //  41
   { "ZOM12", "C", 1, 0 },;                       //  42
   { "ZOM00", "C", 1, 0 },;                       //  43
   { "SYMB_REJ", "C", 2, 0 },;                    //  44
   { "DATA_ZAP", "D", 8, 0 },;                    //  45
   { "UE", "C", 1, 0 },;                          //  46
   { "KRAJ", "C", 2, 0 },;                        //  47
   { "USLUGAUE", "C", 1, 0 },;                    //  48
   { "WEWDOS", "C", 1, 0 },;                      //  49
   { "PALIWA", "N", 11, 2 },;                     //  50
   { "POJAZDY", "N", 11, 2 },;                    //  51
   { "DATAKS", "D", 8, 0 },;                      //  52
   { "SEK_CV7", "C", 2, 0 },;                     //  53
   { "ROZRZAPZ", "C", 1, 0 },;                    //  54
   { "ZAP_TER", "N", 3, 0 },;                     //  55
   { "ZAP_DAT", "D", 8, 0 },;                     //  56
   { "ZAP_WART", "N", 11, 2 },;                   //  57
   { "OPCJE", "C", 1, 0 },;                       //  58
   { "TROJSTR", "C", 1, 0 },;                     //  59
   { "KOL47", "N", 11, 2 },;                      //  60
   { "KOL48", "N", 11, 2 },;                      //  61
   { "KOL49", "N", 11, 2 },;                      //  62
   { "KOL50", "N", 11, 2 },;                      //  63
   { "KOLUMNA2", "C", 2, 0 },;                    //  64
   { "NETTO2", "N", 11, 2 },;                     //  65
   { "DATATRAN", "D", 8, 0 },;                    //  66
   { "RODZDOW", "C", 6, 0 },;                     //  67
   { "VATMARZA", "N", 11, 2 },;                   //  68
   { "IFT2", "C", 1, 0 },;                        //  69
   { "IFT2SEK", "C", 3, 0 },;                     //  70
   { "IFT2KWOT", "N", 11, 0 },;                   //  71
   { "SALPRGID", "C", 64, 0 },;                   //  72 Saldeo company_program_id
   { "SALSALID", "C", 64, 0 } }                   //  73 Saldeo saldeo id

// Create: RELACJE.DBF
public aRELACJEdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "TRASA", "C", 35, 0 },;                      //   4
   { "KM", "N", 4, 0 },;                          //   5
   { "CEL", "C", 35, 0 } }                        //   6

// Create: ROB.DBF
public aROBdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "NAZWA", "C", 60, 0 },;                      //  2
   { "ADRES", "C", 40, 0 },;                      //  3
   { "MC_DZ", "C", 5, 0 },;                       //  4
   { "LP", "N", 5, 0 },;                          //  5
   { "NR_DOW", "C", 10, 0 },;                     //  6
   { "PRZYCH", "N", 11, 2 },;                     //  7
   { "ROZCH", "N", 11, 2 },;                      //  8
   { "KWOTA", "N", 11, 2 },;                      //  9
   { "TRESC", "C", 30, 0 },;                      //  10
   { "ZAPLATA", "C", 1, 0 },;                     //  11
   { "DATA_ZAP", "D", 8, 0 } }                    //  12

// Create: ROBWYP.DBF
public aROBWYPdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "NAZWISKO", "C", 50, 0 },;                   //  2
   { "PESEL", "C", 11, 0 },;                      //  3
   { "MCWYP", "C", 2, 0 },;                       //  4
   { "DOWYPLATY", "N", 9, 2 },;                   //  5
   { "WYPLACONO", "N", 9, 2 },;                   //  6
   { "DATAWYPLA", "D", 8, 0 },;                   //  7
   { "ZALICZKA", "N", 9, 2 },;                    //  8
   { "DATAZALI", "D", 8, 0 },;                    //  9
   { "DATA", "D", 8, 0 },;                        //  10
   { "PODATEK", "N", 9, 2 },;                     //  11
   { "DOPIT4", "C", 6, 0 } }                      //  12

// Create: ROZR.DBF
public aROZRdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "FIRMA", "C", 3, 0 },;                       //  2
   { "NIP", "C", 13, 0 },;                        //  3
   { "WYR", "C", 15, 0 },;                        //  4
   { "DATAKS", "D", 8, 0 },;                      //  5
   { "DATADOK", "D", 8, 0 },;                     //  6
   { "TERMIN", "D", 8, 0 },;                      //  7
   { "DNIPLAT", "N", 3, 0 },;                     //  8
   { "NRDOK", "C", 100, 0 },;                     //  9
   { "ZRODLO", "C", 1, 0 },;                      //  10
   { "RECNOZROD", "N", 10, 0 },;                  //  11
   { "RODZDOK", "C", 2, 0 },;                     //  12
   { "MNOZNIK", "N", 2, 0 },;                     //  13
   { "KWOTA", "N", 11, 2 },;                      //  14
   { "TERMINKOR", "D", 8, 0 },;                   //  15
   { "UWAGI", "C", 60, 0 },;                      //  16
   { "SPRZEDAZ", "N", 11, 2 },;                   //  17
   { "ZAKUP", "N", 11, 2 },;                      //  18
   { "STATUS", "C", 1, 0 },;                      //  19
   { "ROKKS", "C", 4, 0 },;                       //  20
   { "KWOTAVAT", "N", 11, 2 } }                   //  21

// Create: SAMOCHOD.DBF
public aSAMOCHODdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "NRREJ", "C", 8, 0 },;                       //   4
   { "MARKA", "C", 20, 0 },;                      //   5
   { "POJEMNOSC", "N", 4, 0 },;                   //   6
   { "WLASCIC", "C", 30, 0 } }                    //   7

// Create: SPOLKA.DBF
public aSPOLKAdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3    Nr rekordu tablicy 'firma'
   { "NAZ_IMIE", "C", 60, 0 },;                   //  4    Nazwisko i imie
   { "PESEL", "C", 11, 0 },;                      //  5    PESEL
   { "NIP", "C", 13, 0 },;                        //  6    NIP
   { "IMIE_O", "C", 15, 0 },;                     //  7    NIEAKTUALNE Imie ojca
   { "IMIE_M", "C", 15, 0 },;                     //  8    NIEAKTUALNE Imie matki
   { "MIEJSC_UR", "C", 20, 0 },;                  //  9    Miejsce urodzenia
   { "DATA_UR", "D", 8, 0 },;                     //  10   Data urodzenia
   { "MIEJSC_ZAM", "C", 20, 0 },;                 //  11   Miejscowosc
   { "GMINA", "C", 20, 0 },;                      //  12   Gmina
   { "ULICA", "C", 20, 0 },;                      //  13   Ulica
   { "NR_DOMU", "C", 10, 0 },;                    //  14   Nr budynku
   { "NR_MIESZK", "C", 10, 0 },;                  //  15   Nr lokalu
   { "KOD_POCZT", "C", 6, 0 },;                   //  16   Kod pocztowy
   { "POCZTA", "C", 20, 0 },;                     //  17   Poczta
   { "RODZ_DOK", "C", 1, 0 },;                    //  18   Rodzaj dokumentu tozsamosci 'D' - dowod, 'P' - paszport
   { "DOWOD_OSOB", "C", 9, 0 },;                  //  19   Nr dokumentu tozsamosci
   { "NAZW_RODU", "C", 30, 0 },;                  //  20   Nazwisko rodowe
   { "OBYWATEL", "C", 22, 0 },;                   //  21   Obywatelstwo
   { "PLEC", "C", 1, 0 },;                        //  22   Plec 'M'/'K'
   { "UDZIAL1", "C", 7, 0 },;                     //  23   Udzial w styczniu format '000/000'
   { "UDZIAL2", "C", 7, 0 },;                     //  24   ---- " ----
   { "UDZIAL3", "C", 7, 0 },;                     //  25   ---- " ----
   { "UDZIAL4", "C", 7, 0 },;                     //  26   ---- " ----
   { "UDZIAL5", "C", 7, 0 },;                     //  27   ---- " ----
   { "UDZIAL6", "C", 7, 0 },;                     //  28   ---- " ----
   { "UDZIAL7", "C", 7, 0 },;                     //  29   ---- " ----
   { "UDZIAL8", "C", 7, 0 },;                     //  30   ---- " ----
   { "UDZIAL9", "C", 7, 0 },;                     //  31   ---- " ----
   { "UDZIAL10", "C", 7, 0 },;                    //  32   ---- " ----
   { "UDZIAL11", "C", 7, 0 },;                    //  33   ---- " ----
   { "UDZIAL12", "C", 7, 0 },;                    //  34   ---- " ----
   { "G_RODZAJ1", "C", 40, 0 },;                  //  35   Dodt. zrodlo dochodu z dzial. gosp. #1 - Rodzaj
   { "G_RODZAJ2", "C", 40, 0 },;                  //  36   Dodt. zrodlo dochodu z dzial. gosp. #2 - Rodzaj
   { "G_RODZAJ3", "C", 40, 0 },;                  //  37   Dodt. zrodlo dochodu z dzial. gosp. #3 - Rodzaj
   { "G_RODZAJ4", "C", 40, 0 },;                  //  38   Dodt. zrodlo dochodu z dzial. gosp. #4 - Rodzaj
   { "G_RODZAJ5", "C", 40, 0 },;                  //  39   Dodt. zrodlo dochodu z dzial. gosp. #5 - Rodzaj
   { "G_REGON1", "C", 35, 0 },;                   //  40   Dodt. zrodlo dochodu z dzial. gosp. #1 - REGON
   { "G_REGON2", "C", 35, 0 },;                   //  41   Dodt. zrodlo dochodu z dzial. gosp. #2 - REGON
   { "G_REGON3", "C", 35, 0 },;                   //  42   Dodt. zrodlo dochodu z dzial. gosp. #3 - REGON
   { "G_REGON4", "C", 35, 0 },;                   //  43   Dodt. zrodlo dochodu z dzial. gosp. #4 - REGON
   { "G_REGON5", "C", 35, 0 },;                   //  44   Dodt. zrodlo dochodu z dzial. gosp. #5 - REGON
   { "G_MIEJSC1", "C", 40, 0 },;                  //  45   Dodt. zrodlo dochodu z dzial. gosp. #1 - Miejsce prowadzenia dzialalnosci
   { "G_MIEJSC2", "C", 40, 0 },;                  //  46   Dodt. zrodlo dochodu z dzial. gosp. #2 - Miejsce prowadzenia dzialalnosci
   { "G_MIEJSC3", "C", 40, 0 },;                  //  47   Dodt. zrodlo dochodu z dzial. gosp. #3 - Miejsce prowadzenia dzialalnosci
   { "G_MIEJSC4", "C", 40, 0 },;                  //  48   Dodt. zrodlo dochodu z dzial. gosp. #4 - Miejsce prowadzenia dzialalnosci
   { "G_MIEJSC5", "C", 40, 0 },;                  //  49   Dodt. zrodlo dochodu z dzial. gosp. #5 - Miejsce prowadzenia dzialalnosci
   { "N_PRZEDM1", "C", 40, 0 },;                  //  50   Dodt. zrodlo dochodu z najmu #1 - Przedmiot najmu
   { "N_PRZEDM2", "C", 40, 0 },;                  //  51   Dodt. zrodlo dochodu z najmu #2 - Przedmiot najmu
   { "N_MIEJSC1", "C", 40, 0 },;                  //  52   Dodt. zrodlo dochodu z najmu #1 - Miejsce
   { "N_MIEJSC2", "C", 40, 0 },;                  //  53   Dodt. zrodlo dochodu z najmu #2 - Miejsce
   { "TELEFON", "C", 10, 0 },;                    //  54   Telefon
   { "SKARB", "N", 3, 0 },;                       //  55   Urzad skarbowy - Numer rekordu tablicy "urzedy"
   { "S_RODZAJ", "C", 30, 0 },;                   //  56   Tytul odliczenia od podatku
   { "ODLICZ1", "C", 30, 0 },;                    //  57   Tytul odliczenia od dochodu
   { "G_NIP1", "C", 13, 0 },;                     //  58   Dodt. zrodlo dochodu z dzial. gosp. #1 - NIP
   { "G_NIP2", "C", 13, 0 },;                     //  59   Dodt. zrodlo dochodu z dzial. gosp. #2 - NIP
   { "G_NIP3", "C", 13, 0 },;                     //  60   Dodt. zrodlo dochodu z dzial. gosp. #3 - NIP
   { "G_NIP4", "C", 13, 0 },;                     //  61   Dodt. zrodlo dochodu z dzial. gosp. #4 - NIP
   { "G_NIP5", "C", 13, 0 },;                     //  62   Dodt. zrodlo dochodu z dzial. gosp. #5 - NIP
   { "PARAM_WOJ", "C", 20, 0 },;                  //  63   Wowjewodztwo
   { "PARAM_POW", "C", 20, 0 },;                  //  64   Powiat
   { "PARAM_KW", "N", 9, 2 },;                    //  65   Kwota wolna
   { "H384", "C", 20, 0 },;                       //  66   Ograniczenie wysokosci zaliczek albo zaniechanie poboru podatku - nr decyzji
   { "H386", "D", 8, 0 },;                        //  67   Ograniczenie wysokosci zaliczek albo zaniechanie poboru podatku - data decyzji
   { "ODLICZ2", "C", 30, 0 },;                    //  68   Tytul wydatkow na mieszkanie
   { "SPOSOB", "C", 1, 0 },;                      //  69   Sposob rozliczenia podatku 'P' - progresywnie, 'L' - liniowo
   { "KOD_TYTU", "C", 6, 0 },;                    //  70   Kod tytulu ubezp.(ZUS)
   { "KRAJ", "C", 10, 0 },;                       //  71   NIEUZYWANE Kraj
   { "OBLKWWOL", "C", 1, 0 },;                    //  72   Odlicz kwote wolna 'S' - stala wartos, 'T' - tablica pod. doch.
   { "PARAM_KWD", "D", 8, 0 },;                   //  73   Kwota wolna do daty
   { "PARAM_KW2", "N", 9, 2 },;                   //  74   Wartosc kwoty wolnej od daty
   { "ULGAKLSRA", "C", 1, 0 },;                   //  75   Ulga dla klasy ˜redniej 'T' - tak
   { "RYCZSTZDR", "C", 1, 0 },;                   //  76   Stawka zdrowotnego dla ryczaltowcow '0' - auto, '1' - 60%, '2' - 100%, '3' - 180%
   { "RYCZPRZPR", "N", 12, 2 } }                  //  77   Przychody ryczaltowca za poprzedni rok do deklaracji ZUS

// Create: SUMA_MC.DBF
public aSUMA_MCdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "MC", "C", 2, 0 },;                          //  4   Miesiac
   { "HANDEL", "N", 12, 2 },;                     //  5   Ryczalt - Suma kol. 9 (8,5%)
   { "WYR_TOW", "N", 12, 2 },;                    //  6   Ryczalt - Suma kol. 8 (10%)   / Ksiega - Suma kol. 7 (sprzeda¾)
   { "USLUGI", "N", 12, 2 },;                     //  7   Ryczalt - Suma kol. 7 (12,5%) / Ksiega - Suma kol. 8 (pozost. przych.)
   { "ZAKUP", "N", 12, 2 },;                      //  8   Ksiega - Suma kol. 10 (zakupy tow. i mat.)
   { "UBOCZNE", "N", 12, 2 },;                    //  9   Ksiega - Suma kol. 11 (koszty uboczne)
   { "REKLAMA", "N", 12, 2 },;                    //  10  NIEUZYWANE
   { "WYNAGR_G", "N", 12, 2 },;                   //  11  Ksiega - Suma kol. 12 (wynagrodzenia)
   { "WYDATKI", "N", 12, 2 },;                    //  12  Ksiega - Suma kol. 13 (pozostale wydatki)
   { "PUSTA", "N", 12, 2 },;                      //  13  Ksiega - Suma kol. 15 (bez opisu)
   { "POZYCJE", "N", 5, 0 },;                     //  14  Liczba pozycji w ksiedze / ewidencji
   { "ZAMEK", "L", 1, 0 },;                       //  15  Miesiac zamkniety
   { "VAT760", "N", 12, 2 },;                     //  16  JPK_V7(VAT7) - Kwota nadwyzki VAT z poprzedniej deklaracji
   { "VAT723", "N", 12, 2 },;                     //  17  NIEUZYWANE
   { "VAT759", "N", 12, 2 },;                     //  18  JPK_V7(VAT7) - Do zwrotu na rachunek bank.
   { "VAT7F", "C", 1, 0 },;                       //  19  NIEUZYWANE
   { "VAT740", "N", 12, 2 },;                     //  20  JPK_V7(VAT7) - Podatek od spisu z natury
   { "VAT736", "N", 12, 2 },;                     //  21  NIEUZYWANE
   { "VAT762", "N", 12, 2 },;                     //  22  JPK_V7(VAT7) - Kwota objeta zaniechaniem
   { "MIES6OPOD", "N", 11, 2 },;                  //  23  NIEUZYWANE
   { "MIES6OGOL", "N", 11, 2 },;                  //  24  NIEUZYWANE
   { "NRSTOPODNE", "N", 11, 2 },;                 //  25  NIEUZYWANE
   { "NRSTOPODVA", "N", 11, 2 },;                 //  26  NIEUZYWANE
   { "NRSTMIESNE", "N", 11, 2 },;                 //  27  NIEUZYWANE
   { "NRSTMIESVA", "N", 11, 2 },;                 //  28  NIEUZYWANE
   { "NRPOOPODNE", "N", 11, 2 },;                 //  29  NIEUZYWANE
   { "NRPOOPODVA", "N", 11, 2 },;                 //  30  NIEUZYWANE
   { "NRPOMIESNE", "N", 11, 2 },;                 //  31  NIEUZYWANE
   { "NRPOMIESVA", "N", 11, 2 },;                 //  32  NIEUZYWANE
   { "KORZAK1MC", "C", 6, 0 },;                   //  33  NIEUZYWANE
   { "KORZAK2MC", "C", 6, 0 },;                   //  34  NIEUZYWANE
   { "KORZAK3MC", "C", 6, 0 },;                   //  35  NIEUZYWANE
   { "KORZAK4MC", "C", 6, 0 },;                   //  36  NIEUZYWANE
   { "KORZAK1VAT", "N", 11, 2 },;                 //  37  NIEUZYWANE
   { "KORZAK2VAT", "N", 11, 2 },;                 //  38  NIEUZYWANE
   { "KORZAK3VAT", "N", 11, 2 },;                 //  39  NIEUZYWANE
   { "KORZAK4VAT", "N", 11, 2 },;                 //  40  NIEUZYWANE
   { "KORSPR1MC", "C", 6, 0 },;                   //  41  NIEUZYWANE
   { "KORSPR2MC", "C", 6, 0 },;                   //  42  NIEUZYWANE
   { "KORSPR3MC", "C", 6, 0 },;                   //  43  NIEUZYWANE
   { "KORSPR4MC", "C", 6, 0 },;                   //  44  NIEUZYWANE
   { "KORSPR1VAT", "N", 11, 2 },;                 //  45  NIEUZYWANE
   { "KORSPR2VAT", "N", 11, 2 },;                 //  46  NIEUZYWANE
   { "KORSPR3VAT", "N", 11, 2 },;                 //  47  NIEUZYWANE
   { "KORSPR4VAT", "N", 11, 2 },;                 //  48  NIEUZYWANE
   { "LICZ_MIES", "N", 1, 0 },;                   //  49  NIEUZYWANE
   { "KASA_ODL", "N", 11, 0 },;                   //  50  JPK_V7(VAT7) - Do odliczenia na kasy
   { "KASA_ZWR", "N", 11, 0 },;                   //  51  JPK_V7(VAT7) - Do zwrotu za kasy w okresie
   { "RY20", "N", 12, 2 },;                       //  52  Ryczalt - Suma kol. 5 (17%)
   { "RY17", "N", 12, 2 },;                       //  53  Ryczalt - Suma kol. 6 (15%)
   { "RY10", "N", 12, 2 },;                       //  54  Ryczalt - Suma kol. 11 (3%)
   { "NOWYTRAN", "N", 11, 2 },;                   //  55  NIEUZYWANE
   { "KOREKST", "N", 11, 2 },;                    //  56  NIEUZYWANE
   { "KOREKPOZ", "N", 11, 2 },;                   //  57  NIEUZYWANE
   { "ZWR180DNI", "N", 11, 2 },;                  //  58  JPK_V7(VAT7) - Do zwrotu w okresie 180 dni
   { "F1", "C", 1, 0 },;                          //  59  NIEUZYWANE VAT7 - 1.art.86 ust.8 pkt 1 ustawy
   { "F2", "C", 1, 0 },;                          //  60  JPK_V7(VAT7) - 1.art.119 ustawy 'T'/'N'
   { "F3", "C", 1, 0 },;                          //  61  JPK_V7(VAT7) - 2.art.120 ust.4 ustawy 'T'/'N'
   { "F4", "C", 1, 0 },;                          //  62  JPK_V7(VAT7) - 3.art.122 ustawy 'T'/'N'
   { "F5", "C", 1, 0 },;                          //  63  JPK_V7(VAT7) - 4.art.136 ustawy 'T'/'N'
   { "P4IL_POD", "N", 2, 0 },;                    //  64  PIT-4R - ilosc pracownikow
   { "P4SUM_WYP", "N", 11, 2 },;                  //  65  NIEUZYWANE
   { "P4SUM_ZAL", "N", 11, 2 },;                  //  66  PIT-4R - pobrane zaliczni
   { "VATART129", "N", 11, 2 },;                  //  67  JPK_V7(VAT7) - Dostawa 0% z art.129
   { "ZWR60DNI", "N", 11, 2 },;                   //  68  JPK_V7(VAT7) - Do zwrotu w okresie 60 dni
   { "P4POTRAC", "N", 4, 2 },;                    //  69  PIT-4R - wynagrodzenia
   { "P4NALZAL33", "N", 11, 2 },;                 //  70  PIT-4R - nalezne zaliczki
   { "P4OGRZAL", "N", 11, 2 },;                   //  71  PIT-4R - ogrzalu
   { "P4OGRZAL33", "N", 11, 2 },;                 //  72  PIT-4R - ogrzal32u
   { "P4DODZAL", "N", 11, 2 },;                   //  73  PIT-4R - dodzalu
   { "P4NADZWR", "N", 11, 2 },;                   //  74  PIT-4R - nadzwru
   { "P4PFRON", "N", 11, 2 },;                    //  75  PIT-4R - pfronu
   { "P4AKTYW", "N", 11, 2 },;                    //  76  PIT-4R - aktywu
   { "P4ZAL13", "N", 11, 2 },;                    //  77  PIT-4R - zal13u
   { "P4WYNAGR", "N", 11, 2 },;                   //  78  NIEUZYWANE
   { "ZWR25DNI", "N", 11, 2 },;                   //  79  JPK_V7(VAT7) - Do zwrotu w okresie 25 dni
   { "VATZALMIE", "N", 11, 2 },;                  //  80  NIEUZYWANE JPK_V7(VAT7) - Wplacono VAT za ten miesi.
   { "VATNADKWA", "N", 11, 2 },;                  //  81  NIEUZYWANE JPK_V7(VAT7) - Nadplata z poprz.kwartalu
   { "P8ZLECRY", "N", 11, 2 },;                   //  82  PIT-8AR - zlecin
   { "P8WYNAGR", "N", 11, 2 },;                   //  83  PIT-8AR - P8wynagr
   { "P8POTRAC", "N", 4, 2 },;                    //  84  PIT-8AR - potrac
   { "P8ZLECIN", "N", 11, 2 },;                   //  85  PIT-8AR - zlecinu
   { "A89B1", "N", 11, 2 },;                      //  86  NIEUZYWANE
   { "A89B4", "N", 11, 2 },;                      //  87  NIEUZYWANE
   { "A111U6", "N", 11, 2 },;                     //  88  NIEUZYWANE
   { "WERJPKVAT", "N", 3, 0 },;                   //  89  NIEAKTUALNE Rodzaj JPK_VAT (1)
   { "ZWRRAVAT", "N", 11, 2 },;                   //  90  JPK_V7(VAT7) - Zwrot na rach. vat
   { "ZWRKONTO", "C", 1, 0 },;                    //  91  JPK_V7(VAT7) - Do zwrotu w terminie - ' ' brak, '1' zwrot na rach vat, '2' 25 dni, '3' 60 dni, '4' 180 dni
   { "ZWRPODAT", "C", 1, 0 },;                    //  92  JPK_V7(VAT7) - Zwrot VAT na poczet przyszlych zob.
   { "ZWRPODKW", "N", 11, 2 },;                   //  93  JPK_V7(VAT7) - Kwota zwrotu vat na poczt przyszlych zob.
   { "ZWRPODRD", "C", 120, 0 },;                  //  94  JPK_V7(VAT7) - Zwrot VAT na poczet. - nazwa podatku
   { "RYK07", "N", 12, 2 },;                      //  95  Ryczalt - Suma kol. 10 (5,5%)
   { "RYK08", "N", 12, 2 },;                      //  96  Ryczalt - Suma kol. 12 dodatkowa (2%)
   { "RYK09", "N", 12, 2 },;                      //  95  Ryczalt - Suma kol. 8 (14%)
   { "RYK10", "N", 12, 2 } }                      //  96  Ryczalt - Suma kol. 10 (12%)

// Create: TABPIT4R.DBF
public aTABPIT4Rdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "MC", "C", 2, 0 },;                          //  4
   { "ILPOD", "N", 3, 0 },;                       //  5
   { "ILPODU", "N", 3, 0 },;                      //  6
   { "NALZAL", "N", 10, 2 },;                     //  7
   { "NALZALU", "N", 10, 2 },;                    //  8
   { "NALZAL33", "N", 10, 2 },;                   //  9
   { "NALZAL33U", "N", 10, 2 },;                  //  10
   { "OGRZAL", "N", 10, 2 },;                     //  11
   { "OGRZALU", "N", 10, 2 },;                    //  12
   { "OGRZAL32", "N", 10, 2 },;                   //  13
   { "OGRZAL32U", "N", 10, 2 },;                  //  14
   { "DODZAL", "N", 10, 2 },;                     //  15
   { "DODZALU", "N", 10, 2 },;                    //  16
   { "NADZWR", "N", 10, 2 },;                     //  17
   { "NADZWRU", "N", 10, 2 },;                    //  18
   { "PFRON", "N", 10, 2 },;                      //  19
   { "PFRONU", "N", 10, 2 },;                     //  20
   { "AKTYW", "N", 10, 2 },;                      //  21
   { "AKTYWU", "N", 10, 2 },;                     //  22
   { "ZAL13", "N", 10, 2 },;                      //  23
   { "ZAL13U", "N", 10, 2 },;                     //  24
   { "WYNAGR", "N", 10, 2 },;                     //  25
   { "WYNAGRU", "N", 10, 2 } }                    //  26

// Create: TABPIT8R.DBF
public aTABPIT8Rdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "MC", "C", 2, 0 },;                          //  4
   { "ILPOD", "N", 3, 0 },;                       //  5
   { "ILPODU", "N", 3, 0 },;                      //  6
   { "NALZAL", "N", 10, 2 },;                     //  7
   { "NALZALU", "N", 10, 2 },;                    //  8
   { "NALZAL33", "N", 10, 2 },;                   //  9
   { "NALZAL33U", "N", 10, 2 },;                  //  10
   { "OGRZAL", "N", 10, 2 },;                     //  11
   { "OGRZALU", "N", 10, 2 },;                    //  12
   { "OGRZAL32", "N", 10, 2 },;                   //  13
   { "OGRZAL32U", "N", 10, 2 },;                  //  14
   { "DODZAL", "N", 10, 2 },;                     //  15
   { "DODZALU", "N", 10, 2 },;                    //  16
   { "NADZWR", "N", 10, 2 },;                     //  17
   { "NADZWRU", "N", 10, 2 },;                    //  18
   { "PFRON", "N", 10, 2 },;                      //  19
   { "PFRONU", "N", 10, 2 },;                     //  20
   { "AKTYW", "N", 10, 2 },;                      //  21
   { "AKTYWU", "N", 10, 2 },;                     //  22
   { "ZAL13", "N", 10, 2 },;                      //  23
   { "ZAL13U", "N", 10, 2 },;                     //  24
   { "WYNAGR", "N", 10, 2 },;                     //  25
   { "WYNAGRU", "N", 10, 2 },;                    //  26
   { "ZLECRYCZ", "N", 10, 2 },;                   //  27
   { "POTRAC", "N", 5, 2 },;                      //  28
   { "ZLECIN", "N", 10, 2 },;                     //  29
   { "ZLECINU", "N", 10, 2 } }                    //  30

// Create: TAB_DOCH.DBF
public aTAB_DOCHdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "PODSTAWA", "N", 11, 2 },;                   //   3
   { "PROCENT", "N", 5, 2 },;                     //   4
   { "DATAOD", "D", 8, 0 },;                      //   5
   { "DATADO", "D", 8, 0 } }                      //   6

// Create: TAB_DOCHUKS.DBF
public aTAB_DOCHUKSdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "PODSTOD", "N", 11, 2 },;                    //   3
   { "PODSTDO", "N", 11, 2 },;                    //   4
   { "PROCENT", "N", 5, 2 },;                     //   5
   { "MNOZNIK", "N", 5, 2 },;                     //   6
   { "KWOTA", "N", 11, 2 },;                      //   7
   { "DATAOD", "D", 8, 0 } }                      //   8

public aTAB_PLAdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DATAOD", "D", 8, 0 },;                      //   2   Data od kidy obowiazuje
   { "ODLICZ", "N", 11, 2 },;                     //   4   parap_odl
   { "PODATEK", "N", 5, 2 },;                     //   5   parap_pod
   { "OBNIZZUS", "L", 1, 0 },;                    //   6   Czy obnizac zdrowotne do poziomu z 2021
   { "AKTUKS", "L", 1, 0 },;                      //   7   Czy aktywna ulga dla klasy sredniej
   { "AKTPTERM", "L", 1, 0 } }                    //   8   Czy aktywna opcja przesuniecia terminu poboru zaliczki

// Create: TAB_POJ.DBF
public aTAB_POJdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "ODDNIA", "D", 8, 0 },;                      //   3
   { "POJ_900", "N", 6, 4 },;                     //   4
   { "POJ_901", "N", 6, 4 } }                     //   5

// Create: TAB_VAT.DBF
public aTAB_VATdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "ODDNIA", "D", 8, 0 },;                      //   3
   { "STAWKA_A", "N", 2, 0 },;                    //   4
   { "STAWKA_B", "N", 2, 0 },;                    //   5
   { "STAWKA_C", "N", 2, 0 },;                    //   6
   { "STAWKA_D", "N", 2, 0 } }                    //   7

// Create: TAB_VATEU.DBF
public aTAB_VATUEdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "KRAJ", "C", 2, 0 },;                        //   3
   { "ODDNIA", "D", 8, 0 },;                      //   4
   { "STAWKA_A", "N", 5, 2 },;                    //   5
   { "STAWKA_B", "N", 5, 2 },;                    //   6
   { "STAWKA_C", "N", 5, 2 },;                    //   7
   { "STAWKA_D", "N", 5, 2 } }                    //

// Create: TRESC.DBF
public aTRESCdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "TRESC", "C", 512, 0 },;                     //   4
   { "STAN", "N", 12, 2 },;                       //   5
   { "RODZAJ", "C", 1, 0 },;                      //   6
   { "OPCJE", "C", 32, 0 },;                      //   7   Oznaczenia
   { "PROCEDUR", "C", 32, 0 },;                   //   8   Procedure
   { "RODZDOW", "C", 6, 0 },;                     //   9   Rodzaj dowodu
   { "SEK_CV7", "C", 2, 0 },;                     //   10   Sekcja VAT 7
   { "KOLUMNA", "C", 2, 0 },;                     //   11   Domyslna kolumna
   { "SALPRGID", "C", 64, 0 },;                   //   12   Saldeo company_program_id
   { "SALSALID", "C", 64, 0 } }                   //   13   Saldeo saldeo id

// Create: TRESC.DBF
public aTRESCKORdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "SYMBOL", "C", 16, 0 },;                     //   2
   { "ID1", "N", 6, 0 },;                         //   3
   { "ID2", "N", 6, 0 },;                         //   4
   { "TRESC", "M", 10, 0 } }                      //   5

// Create: UMOWY.DBF
public aUMOWYdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "IDENT", "C", 5, 0 },;                       //  4
   { "NUMER", "C", 5, 0 },;                       //  5
   { "DATA_UMOWY", "D", 8, 0 },;                  //  6
   { "TEMAT1", "C", 70, 0 },;                     //  7
   { "TEMAT2", "C", 70, 0 },;                     //  8
   { "TERMIN", "D", 8, 0 },;                      //  9
   { "DATA_RACH", "D", 8, 0 },;                   //  10
   { "DATA_WYP", "D", 8, 0 },;                    //  11
   { "MC", "C", 2, 0 },;                          //  12
   { "BRUT_ZASAD", "N", 12, 2 },;                 //  13
   { "PENSJA", "N", 12, 2 },;                     //  14
   { "BRUT_RAZEM", "N", 12, 2 },;                 //  15
   { "KOSZTY", "N", 5, 2 },;                      //  16
   { "AKOSZT", "C", 1, 0 },;                      //  17
   { "KOSZT", "N", 12, 2 },;                      //  18
   { "DOCHOD", "N", 12, 2 },;                     //  19
   { "STAW_PODAT", "N", 2, 0 },;                  //  20
   { "PODATEK", "N", 12, 2 },;                    //  21 Podatek do US
   { "NETTO", "N", 12, 2 },;                      //  22
   { "DO_WYPLATY", "N", 12, 2 },;                 //  23
   { "STAW_PUZ", "N", 5, 2 },;                    //  24
   { "APUZ", "C", 1, 0 },;                        //  25
   { "STAW_PUE", "N", 5, 2 },;                    //  26
   { "APUE", "C", 1, 0 },;                        //  27
   { "STAW_PUR", "N", 5, 2 },;                    //  28
   { "APUR", "C", 1, 0 },;                        //  29
   { "STAW_PUC", "N", 5, 2 },;                    //  30
   { "APUC", "C", 1, 0 },;                        //  31
   { "STAW_PUW", "N", 5, 2 },;                    //  32
   { "APUW", "C", 1, 0 },;                        //  33
   { "STAW_PSUM", "N", 5, 2 },;                   //  34
   { "STAW_PFP", "N", 5, 2 },;                    //  35
   { "APFP", "C", 1, 0 },;                        //  36
   { "STAW_PFG", "N", 5, 2 },;                    //  37
   { "APFG", "C", 1, 0 },;                        //  38
   { "STAW_PF3", "N", 5, 2 },;                    //  39
   { "APF3", "C", 1, 0 },;                        //  40
   { "STAW_FUZ", "N", 5, 2 },;                    //  41
   { "AFUZ", "C", 1, 0 },;                        //  42
   { "STAW_FUE", "N", 5, 2 },;                    //  43
   { "AFUE", "C", 1, 0 },;                        //  44
   { "STAW_FUR", "N", 5, 2 },;                    //  45
   { "AFUR", "C", 1, 0 },;                        //  46
   { "STAW_FUC", "N", 5, 2 },;                    //  47
   { "AFUC", "C", 1, 0 },;                        //  48
   { "STAW_FUW", "N", 5, 2 },;                    //  49
   { "AFUW", "C", 1, 0 },;                        //  50
   { "STAW_FSUM", "N", 5, 2 },;                   //  51
   { "STAW_FFP", "N", 5, 2 },;                    //  52
   { "AFFP", "C", 1, 0 },;                        //  53
   { "STAW_FFG", "N", 5, 2 },;                    //  54
   { "AFFG", "C", 1, 0 },;                        //  55
   { "STAW_FF3", "N", 5, 2 },;                    //  56
   { "AFF3", "C", 1, 0 },;                        //  57
   { "WAR_PUZ", "N", 12, 2 },;                    //  58
   { "WAR_PUZO", "N", 12, 2 },;                   //  59
   { "WAR_PUE", "N", 12, 2 },;                    //  60
   { "WAR_PUR", "N", 12, 2 },;                    //  61
   { "WAR_PUC", "N", 12, 2 },;                    //  62
   { "WAR_PUW", "N", 12, 2 },;                    //  63
   { "WAR_PSUM", "N", 12, 2 },;                   //  64
   { "WAR_PFP", "N", 12, 2 },;                    //  65
   { "WAR_PFG", "N", 12, 2 },;                    //  66
   { "WAR_PF3", "N", 12, 2 },;                    //  67
   { "WAR_FUZ", "N", 12, 2 },;                    //  68
   { "WAR_FUE", "N", 12, 2 },;                    //  69
   { "WAR_FUR", "N", 12, 2 },;                    //  70
   { "WAR_FUC", "N", 12, 2 },;                    //  71
   { "WAR_FUW", "N", 12, 2 },;                    //  72
   { "WAR_FSUM", "N", 12, 2 },;                   //  73
   { "WAR_FFP", "N", 12, 2 },;                    //  74
   { "WAR_FFG", "N", 12, 2 },;                    //  75
   { "WAR_FF3", "N", 12, 2 },;                    //  76
   { "TYTUL", "C", 2, 0 },;                       //  77
   { "STAW_PZK", "N", 5, 2 },;                    //  78
   { "APZK", "C", 1, 0 },;                        //  79
   { "WAR_PZK", "N", 8, 2 },;                     //  80
   { "DOCHODPOD", "N", 12, 2 },;                  //  81
   { "ZAOPOD", "N", 1, 0 },;                      //  82
   { "OSWIAD26R", "C", 1, 0 },;                   //  83
   { "STAW_PODA2", "N", 5, 2 },;                  //  84
   { "POTRACENIA", "N", 12, 2 },;                 //  85
   { "PPK", "C", 1, 0 },;                         //  86 PPK aktywne
   { "PPKZS1", "N", 5, 2 },;                      //  87 PPK Wpˆata podstawowa pracownik¢w - stawka
   { "PPKZK1", "N", 8, 2 },;                      //  88 PPK Wpˆata podstawowa pracownik¢w - kwota
   { "PPKZS2", "N", 5, 2 },;                      //  89 PPK Wpˆata dodatkowa pracownik¢w - stawka
   { "PPKZK2", "N", 8, 2 },;                      //  90 PPK Wpˆata dodatkowa pracownik¢w - kwota
   { "PPKPS1", "N", 5, 2 },;                      //  91 PPK Wpˆata podstawowa pracodawcy - stawka
   { "PPKPK1", "N", 8, 2 },;                      //  92 PPK Wpˆata podstawowa pracodawcy - kwota
   { "PPKPS2", "N", 5, 2 },;                      //  93 PPK Wpˆata dodatkowa pracodawcy - stawka
   { "PPKPK2", "N", 8, 2 },;                      //  94 PPK Wpˆata dodatkowa pracodawcy - kwota
   { "PPKPPM", "N", 8, 2 },;                      //  95 PPK Wpˆaty pracodawcy z pop. miesi¥ca
   { "PPKIDEPPK", "C", 50, 0 },;                  //  96 PPK Identyfikator ewidencji PPK uczestnika PPK
   { "ZASI_BZUS", "N", 12, 2 },;                  //  97 Zasilki bez ZUS
   { "WNIOSTERM", "C", 1, 0 },;                   //  98 Przedˆu¾enie terminu poboru podatku (rozp. 07.01.2022)
   { "NALPODAT", "N", 12, 2 },;                   //  99 Naliczony podatek
   { "ODLICZ", "N", 8, 2 },;                      // 100 Kwota wolna do odliczenia
   { "ODLICZENIE", "C", 1, 0 },;                  // 101 Odlicz kwote wolna
   { "KOD_TYTU", "C", 6, 0 } }                    // 102 Kod tytuˆu ubezpieczenia

// Create: URZEDY.DBF
public aURZEDYdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "URZAD", "C", 25, 0 },;                      //  3
   { "ULICA", "C", 20, 0 },;                      //  4
   { "NR_DOMU", "C", 5, 0 },;                     //  5
   { "MIEJSC_US", "C", 20, 0 },;                  //  6
   { "KOD_POCZT", "C", 6, 0 },;                   //  7
   { "BANK", "C", 30, 0 },;                       //  8
   { "KONTODOCH", "C", 32, 0 },;                  //  9
   { "KONTOVAT", "C", 32, 0 },;                   //  10
   { "KODURZEDU", "C", 4, 0 } }                   //  11

// Create: VAT7ZD.DBF
public aVAT7ZDdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "MC", "C", 2, 0 },;                          //  4
   { "NAZWA", "C", 100, 0 },;                     //  5
   { "NIP", "C", 30, 0 },;                        //  6
   { "NR_DOK", "C", 40, 0 },;                     //  7
   { "DATA_WYST", "D", 8, 0 },;                   //  8
   { "DATA_TERM", "D", 8, 0 },;                   //  9
   { "PODSTAWA", "N", 11, 2 },;                   //  11
   { "PODATEK", "N", 11, 2 } }                    //  12

// Create: VIUDOKOR.DBF
public aVIUDOKORdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "FIRMA", "C", 3, 0 },;                       //  2 Ident. firmy
   { "KWARTAL", "C", 1, 0 },;                     //  3 Kwartal deklaracji
   { "KRAJ", "C", 2, 0 },;                        //  4 Kraj
   { "ROKKOR", "C", 4, 0 },;                      //  5 Rok korekty
   { "KWARTKOR", "C", 1, 0 },;                    //  6 Kwartal korekty
   { "KWOTA", "N", 11, 2 } }                      //  7 Kwota korekty EUR

// Create: WYPLATY.DBF
public aWYPLATYdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "IDENT", "C", 5, 0 },;                       //   4
   { "MC", "C", 2, 0 },;                          //   5
   { "KWOTA", "N", 8, 2 },;                       //   6
   { "DATA_WYP", "D", 8, 0 } }                    //   7

// Create: WYPOSAZ.DBF
public aWYPOSAZdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "ROK", "C", 4, 0 },;                         //  4
   { "MC", "C", 2, 0 },;                          //  5
   { "DZIEN", "C", 2, 0 },;                       //  6
   { "NUMER", "C", 10, 0 },;                      //  7
   { "NAZWA", "C", 40, 0 },;                      //  8
   { "CENA", "N", 12, 2 },;                       //  9
   { "POZYCJA", "N", 6, 0 },;                     //  10
   { "DATAKAS", "D", 8, 0 },;                     //  11
   { "PRZYCZYNA", "C", 30, 0 } }                  //  12

// Create: ZALICZKI.DBF
public aZALICZKIdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "IDENT", "C", 5, 0 },;                       //   4
   { "MC", "C", 2, 0 },;                          //   5
   { "KWOTA", "N", 8, 2 },;                       //   6
   { "DATA_WYP", "D", 8, 0 } }                    //   7

public aZUSKODNIEdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "KOD", "C", 3, 0 },;                         //   2
   { "NAZWA", "C", 74, 0 } }                      //   3

public TabliceDbf := {;
   { "amort",    "amort.dbf",    aAMORTdbf,    .T. },;
   { "dane_mc",  "dane_mc.dbf",  aDANE_MCdbf,  .T. },;
   { "datyum",   "datyum.dbf",   aDATYUMdbf,   .F. },;
   { "dowew",    "dowew.dbf",    aDOWEWdbf,    .T. },;
   { "drukarka", "drukarka.dbf", aDRUKARKAdbf, .F. },;
   { "dzienne",  "dzienne.dbf",  aDZIENNEdbf,  .T. },;
   { "edeklar",  "edeklar.dbf",  aEDEKLARdbf,  .T. },;
   { "etaty",    "etaty.dbf",    aETATYdbf,    .T. },;
   { "ewid",     "ewid.dbf",     aEWIDdbf,     .T. },;
   { "ewidpoj",  "ewidpoj.dbf",  aEWIDPOJdbf,  .T. },;
   { "ewidzwr",  "ewidzwr.dbf",  aEWIDZWRdbf,  .T. },;
   { "faktury",  "faktury.dbf",  aFAKTURYdbf,  .T. },;
   { "fakturyw", "fakturyw.dbf", aFAKTURYWdbf, .T. },;
   { "firma",    "firma.dbf",    aFIRMAdbf,    .T. },;
   { "kartst",   "kartst.dbf",   aKARTSTdbf,   .T. },;
   { "kartstmo", "kartstmo.dbf", aKARTSTMOdbf, .T. },;
   { "kasafisk", "kasafisk.dbf", aKASAFISKdbf, .T. },;
   { "kat_spr",  "kat_spr.dbf",  aKAT_SPRdbf,  .T. },;
   { "kat_zak",  "kat_zak.dbf",  aKAT_ZAKdbf,  .T. },;
   { "kontr",    "kontr.dbf",    aKONTRdbf,    .T. },;
   { "kontrspr", "kontrspr.dbf", aKONTRSPRdbf, .T. },;
   { "krst",     "krst.dbf",     aKRSTdbf,     .T. },;
   { "nieobec",  "nieobec.dbf",  aNIEOBECdbf,  .T. },;
   { "notes",    "notes.dbf",    aNOTESdbf,    .T. },;
   { "oper",     "oper.dbf",     aOPERdbf,     .T. },;
   { "organy",   "organy.dbf",   aORGANYdbf,   .T. },;
   { "ossrej",   "ossrej.dbf",   aOSSREJdbf,   .T. },;
   { "pit_27",   "pit_27.dbf",   aPIT_27dbf,   .F. },;
   { "pozycje",  "pozycje.dbf",  aPOZYCJEdbf,  .T. },;
   { "pozycjew", "pozycjew.dbf", aPOZYCJEWdbf, .T. },;
   { "prac",     "prac.dbf",     aPRACdbf,     .T. },;
   { "prac_hz",  "prac_hz.dbf",  aPRAC_HZdbf,  .T. },;
   { "profil",   "profil.dbf",   aPROFILdbf,   .F. },;
   { "przelewy", "przelewy.dbf", aPRZELEWYdbf, .T. },;
   { "przelpod", "przelpod.dbf", aPRZELPODdbf, .T. },;
   { "rachpoj",  "rachpoj.dbf",  aRACHPOJdbf,  .T. },;
   { "raport",   "raport.dbf",   aRAPORTdbf,   .F. },;
   { "rejestry", "rejestry.dbf", aREJESTRYdbf, .T. },;
   { "rejs",     "rejs.dbf",     aREJSdbf,     .T. },;
   { "rejz",     "rejz.dbf",     aREJZdbf,     .T. },;
   { "relacje",  "relacje.dbf",  aRELACJEdbf,  .T. },;
   { "rob",      "rob.dbf",      aROBdbf,      .F. },;
   { "robwyp",   "robwyp.dbf",   aROBWYPdbf,   .F. },;
   { "rozr",     "rozr.dbf",     aROZRdbf,     .T. },;
   { "samochod", "samochod.dbf", aSAMOCHODdbf, .T. },;
   { "spolka",   "spolka.dbf",   aSPOLKAdbf,   .T. },;
   { "suma_mc",  "suma_mc.dbf",  aSUMA_MCdbf,  .T. },;
   { "tab_doch", "tab_doch.dbf", aTAB_DOCHdbf, .T. },;
   { "tab_dochuks","tab_dochuks.dbf",aTAB_DOCHUKSdbf, .T.},;
   { "tab_pla",  "tab_pla.dbf",  aTAB_PLAdbf,  .T. },;
   { "tab_poj",  "tab_poj.dbf",  aTAB_POJdbf,  .T. },;
   { "tab_vat",  "tab_vat.dbf",  aTAB_VATdbf,  .T. },;
   { "tab_vatue","tab_vatue.dbf",aTAB_VATUEdbf,.T. },;
   { "tabpit4r", "tabpit4r.dbf", aTABPIT4Rdbf, .F. },;
   { "tabpit8r", "tabpit8r.dbf", aTABPIT8Rdbf, .F. },;
   { "tresc",    "tresc.dbf",    aTRESCdbf,    .T. },;
   { "tresckor", "tresckor.dbf", aTRESCKORdbf, .T. },;
   { "umowy",    "umowy.dbf",    aUMOWYdbf,    .T. },;
   { "urzedy",   "urzedy.dbf",   aURZEDYdbf,   .T. },;
   { "vat7zd",   "vat7zd.dbf",   aVAT7ZDdbf,   .T. },;
   { "viudokor", "viudokor.dbf", aVIUDOKORdbf, .T. },;
   { "wyplaty",  "wyplaty.dbf",  aWYPLATYdbf,  .T. },;
   { "wyposaz",  "wyposaz.dbf",  aWYPOSAZdbf,  .T. },;
   { "zaliczki", "zaliczki.dbf", aZALICZKIdbf, .T. },;
   { "zuskodnie","zuskodnie.dbf",aZUSKODNIEdbf,.T. } }

   RETURN

****************************************
FUNCTION dbfIdxOPER()
   do while.not.dostepex('OPER')
   enddo
   _bezpusty=1
   do while _bezpusty=1
      locate all for del<>'-'.and.del<>'+'
      if found()
         repl del with '-'
      else
         _bezpusty=0
      endif
   enddo
   pack
   index on del+firma+mc+dzien+numer to oper
   index on rec_no to oper1
   index on del+firma+mc+numer to oper2
   index on del+firma+mc+dzien to oper3
   index on del+str(rejzid,5) to oper4
   index on del+firma+mc+dzien+Str(lp,5) to oper5
   RETURN
****************************************
FUNCTION dbfIdxEWID()
   do while.not.dostepex('EWID')
   enddo
   pack
   index on del+firma+mc+dzien+numer to ewid
   index on del+firma+iif(zaplata=[1],[-],[+])+mc+dzien to ewid1
   index on del+firma+mc+numer to ewid2
   index on del+firma+mc+dzien to ewid3
   index on del+str(rejzid,5)+numer to ewid4
   index on del+firma+mc+dzien+Str(lp,5) to ewid5
   RETURN
****************************************
FUNCTION dbfIdxTAB_DOCH()
   do while.not.dostepex('TAB_DOCH')
   enddo
   pack
   index on DToS(dataod)+str(podstawa,11,2) to tab_doch
   RETURN
****************************************
FUNCTION dbfIdxTAB_DOCHUKS()
   do while.not.dostepex('TAB_DOCHUKS')
   enddo
   pack
   index on DToS(dataod)+Str(podstod,11,2) to tab_dochuks
   RETURN
****************************************
*do while.not.dostepex('TAB_VAT')
*enddo
*pack
*index on NUMVAT to tab_vat
*index on SYMBVAT to tab_vat1
****************************************
FUNCTION dbfIdxTAB_PLA()
   do while.not.dostepex('TAB_PLA')
   enddo
   pack
   index on DToS( dataod ) TO tab_pla
   RETURN
****************************************
FUNCTION dbfIdxTAB_POJ()
   do while.not.dostepex('TAB_POJ')
   enddo
   pack
   index on del+dtos(oddnia) to tab_poj
   RETURN
****************************************
FUNCTION dbfIdxTAB_VAT()
   do while.not.dostepex('TAB_VAT')
   enddo
   pack
   index on descend(del+dtos(oddnia)) to tab_vat
   RETURN
****************************************
FUNCTION dbfIdxSPOLKA()
   do while.not.dostepex('SPOLKA')
   enddo
   index on del+firma+naz_imie to spolka
   index on str(skarb,3) to spolka1
   RETURN
****************************************
FUNCTION dbfIdxFAKTURY()
   do while.not.dostepex('FAKTURY')
   enddo
   pack
   index on del+firma+rach+str(numer,5) to faktury
   index on del+firma+mc+dzien+rach+str(numer,5) to faktury1
   index on del+firma+mc+rach+str(numer,5) to faktury2
   index on rec_no to faktury3
   RETURN
****************************************
FUNCTION dbfIdxFAKTURYW()
   do while.not.dostepex('FAKTURYW')
   enddo
   pack
   index on del+firma+rach+str(numer,5) to fakturw
   index on del+firma+mc+dzien+rach+str(numer,5) to fakturw1
   index on del+firma+mc+rach+str(numer,5) to fakturw2
   index on rec_no to fakturw3
   RETURN
****************************************
FUNCTION dbfIdxKARTST()
   do while.not.dostepex('KARTST')
   enddo
   pack
   index on del+firma+dtos(DATA_ZAK) to kartst
   index on rec_no to kartst1
   RETURN
****************************************
FUNCTION dbfIdxKARTSTMO()
   do while.not.dostepex('KARTSTMO')
   enddo
   pack
   index on del+ident+dtos(DATA_MOD) to kartstmo
   RETURN
****************************************
FUNCTION dbfIdxAMORT()
   do while.not.dostepex('AMORT')
   enddo
   pack
   index on del+ident+rok to amort
   RETURN
****************************************
FUNCTION dbfIdxKRST()
   do while.not.dostepex('KRST')
   enddo
   pack
   index on krst to krst
   RETURN
****************************************
FUNCTION dbfIdxPOZYCJE()
   do while.not.dostepex('POZYCJE')
   enddo
   pack
   index on del+ident to pozycje
   RETURN
****************************************
FUNCTION dbfIdxPOZYCJEW()
   do while.not.dostepex('POZYCJEW')
   enddo
   pack
   index on del+ident to pozycjew
   RETURN
****************************************
FUNCTION dbfIdxFIRMA()
   do while.not.dostepex('FIRMA')
   enddo
   index on del+symbol to firma
   RETURN
****************************************
FUNCTION dbfIdxSUMA_MC()
   do while.not.dostepex('SUMA_MC')
   enddo
   pack
   index on del+firma+mc to suma_mc
   RETURN
****************************************
FUNCTION dbfIdxDANE_MC()
   do while.not.dostepex('DANE_MC')
   enddo
   pack
   index on del+ident+mc to dane_mc
   RETURN
****************************************
FUNCTION dbfIdxKONTR()
   do while.not.dostepex('KONTR')
   enddo
   pack
   index on del+firma+substr(nazwa,1,15)+substr(adres,1,15) to kontr
   index on del+firma+substr(nr_ident,1,15) to kontr1
   index on Str( id, 6 ) TO kontr2
   index on del + firma + SubStr( salsalid, 1, 16 ) TO kontr3
   RETURN
****************************************
FUNCTION dbfIdxKONTRSPR()
   do while.not.dostepex('KONTRSPR')
   enddo
   pack
   index on nip + DToS( stanna ) to kontrspr
   RETURN
****************************************
FUNCTION dbfIdxKAT_ZAK()
   do while.not.dostepex('KAT_ZAK')
   enddo
   pack
   index on del+firma+symb_rej to kat_zak
   index on Str( id, 6 ) TO kat_zak1
   RETURN
****************************************
FUNCTION dbfIdxKAT_SPR()
   do while.not.dostepex('KAT_SPR')
   enddo
   pack
   index on del+firma+symb_rej to kat_spr
   index on Str( id, 6 ) TO kat_spr1
   RETURN
****************************************
FUNCTION dbfIdxTRESC()
   do while.not.dostepex('TRESC')
   enddo
   pack
   index on del+firma+tresc to tresc
   index on Str( id, 6 ) TO tresc1
   RETURN
****************************************
FUNCTION dbfIdxTRESCKOR()
   do while.not.dostepex('TRESCKOR')
   enddo
   pack
   index on symbol+Str(id1,6)+Str(id2,6) to tresckor
   RETURN
****************************************
FUNCTION dbfIdxURZEDY()
   do while.not.dostepex('URZEDY')
   enddo
   index on del+miejsc_us+urzad to urzedy
   RETURN
****************************************
FUNCTION dbfIdxORGANY()
   do while.not.dostepex('ORGANY')
   enddo
   index on del+nazwa_org to organy
   RETURN
****************************************
FUNCTION dbfIdxREJESTRY()
   do while.not.dostepex('REJESTRY')
   enddo
   index on del+nazwa_rej to rejestry
   RETURN
****************************************
FUNCTION dbfIdxREJS()
   do while.not.dostepex('REJS')
   enddo
   index on del+firma+mc+dzien+numer to rejs
   index on del+firma+iif(zaplata=[1],[-],[+])+mc+dzien to rejs1
   index on del+firma+mc+numer to rejs2
   index on del+firma+mc+dzien to rejs3
   index on del+firma+mc+kolumna+dzien+numer to rejs4
   RETURN
****************************************
FUNCTION dbfIdxREJZ()
   do while.not.dostepex('REJZ')
   enddo
   index on del+firma+mc+dzien+numer to rejz
   index on del+firma+iif(zaplata=[1],[-],[+])+mc+dzien to rejz1
   index on del+firma+mc+numer to rejz2
   index on del+firma+mc+dzien to rejz3
   index on del+firma+mc+kolumna+dzien+numer to rejz4
   RETURN
****************************************
FUNCTION dbfIdxWYPOSAZ()
   do while.not.dostepex('WYPOSAZ')
   enddo
   pack
   index on del+firma+rok+mc+dzien+numer to wyposaz
   RETURN
****************************************
FUNCTION dbfIdxPRAC()
   do while.not.dostepex('PRAC')
   enddo
   pack
   index on del+firma+nazwisko+imie1+imie2 to prac
   index on del+firma+iif(status>'U','-','+')+nazwisko+imie1+imie2 to prac1
   index on del+firma+iif(status<'U','-','+')+nazwisko+imie1+imie2 to prac2
   index on firma + Str( rec_no, 5, 0 ) to prac3
   index on del+firma+pesel to prac4
   index on Str( id, 8 ) TO prac5
   RETURN
****************************************
FUNCTION dbfIdxPRAC_HZ()
   do while.not.dostepex('PRAC_HZ')
   enddo
   pack
   index on del+firma+Str(pracid,8)+DToS(data_przy) TO prac_hz
   RETURN
****************************************
FUNCTION dbfIdxUMOWY()
   do while.not.dostepex('UMOWY')
   enddo
   index on del+ident+numer to umowy
   index on del+firma+dtos(data_umowy) to umowy1
   index on del+firma+dtos(data_rach) to umowy2
   index on del+firma+dtos(data_wyp) to umowy3
   RETURN
****************************************
FUNCTION dbfIdxETATY()
   do while.not.dostepex('ETATY')
   enddo
   pack
   index on del+firma+ident+mc to etaty
   index on del+firma+mc+ident to etaty1
   RETURN
****************************************
FUNCTION dbfIdxNIEOBEC()
   do while.not.dostepex('NIEOBEC')
   enddo
   pack
   index on del+firma+ident+mc to nieobec
   index on del+firma+mc+ident to nieobec1
   RETURN
****************************************
FUNCTION dbfIdxWYPLATY()
   do while.not.dostepex('WYPLATY')
   enddo
   pack
   index on del+firma+ident+mc+dtos(data_wyp) to wyplaty
   index on del+firma+ident+dtos(data_wyp)+mc to wyplaty1
   RETURN
****************************************
FUNCTION dbfIdxZALICZKI()
   do while.not.dostepex('ZALICZKI')
   enddo
   pack
   index on del+firma+ident+mc+dtos(data_wyp) to zaliczki
   index on del+firma+ident+dtos(data_wyp)+mc to zaliczk1
   RETURN
****************************************
FUNCTION dbfIdxDZIENNE()
   do while.not.dostepex('DZIENNE')
   enddo
   pack
   index on del+firma+mc+dzien+numer+numer_rach to dzienne
   RETURN
****************************************
FUNCTION dbfIdxRACHPOJ()
   do while.not.dostepex('RACHPOJ')
   enddo
   pack
   index on del+firma+mc+dzien+nrrej+numer to rachpoj
   index on del+firma+mc+nrrej+dzien+numer to rachpoj1
   RETURN
****************************************
FUNCTION dbfIdxSAMOCHOD()
   do while.not.dostepex('SAMOCHOD')
   enddo
   pack
   index on del+firma+nrrej to samochod
   RETURN
****************************************
FUNCTION dbfIdxRELACJE()
   do while.not.dostepex('RELACJE')
   enddo
   pack
   index on del+firma+trasa to relacje
   RETURN
****************************************
FUNCTION dbfIdxEWIDPOJ()
   do while.not.dostepex('EWIDPOJ')
   enddo
   pack
   index on del+firma+mc+dzien+nrrej+nrkol to ewidpoj
   index on del+firma+mc+nrrej+dzien+nrkol to ewidpoj1
   RETURN
****************************************
FUNCTION dbfIdxDOWEW()
   do while.not.dostepex('DOWEW')
   enddo
   pack
   index on del+firma+zestaw+nrkol to dowew
   index on del+firma+dtos(data)+nrdok+zestaw+nrkol to dowew1
   RETURN
****************************************
FUNCTION dbfIdxPRZELEWY()
   do while.not.dostepex('PRZELEWY')
   enddo
   pack
   index on del+firma+dtos(data) to przelewy
   RETURN
****************************************
FUNCTION dbfIdxPRZELPOD()
   do while.not.dostepex('PRZELPOD')
   enddo
   pack
   index on del+firma+dtos(data) to przelpod
   RETURN
****************************************
FUNCTION dbfIdxROZR()
   do while.not.dostepex('ROZR')
   enddo
   pack
   index on firma+nip+wyr+rodzdok+rokks+dtos(termin) to rozr
   index on firma+rokks+zrodlo+str(recnozrod,10) to rozr1
   index on firma+nip+wyr+rodzdok+rokks+dtos(datadok) to rozr2
   RETURN
****************************************
FUNCTION dbfIdxNOTES()
   do while.not.dostepex('NOTES')
   enddo
   pack
   index on del+firma to notes
   RETURN
****************************************
FUNCTION dbfIdxEDEKLAR()
   do while.not.dostepex('EDEKLAR')
   enddo
   pack
   index on firma+rodzaj+miesiac TO edeklar
   index on firma+miesiac+rodzaj TO edeklar1
   RETURN
****************************************
FUNCTION dbfIdxVAT7ZD()
   do while.not.dostepex('VAT7ZD')
   enddo
   pack
   index on del+firma+mc TO vat7zd
   RETURN
****************************************
FUNCTION dbfIdxKASAFISK()
   do while.not.dostepex('KASAFISK')
   enddo
   pack
   index on firma TO kasafisk
   RETURN
****************************************
FUNCTION dbfIdxEWIDZWR()
   do while.not.dostepex('EWIDZWR')
   enddo
   pack
   index on firma + Str( kasafid, 11, 0 ) + mc + dzien + nrdok TO ewidzwr
   RETURN
****************************************
FUNCTION dbfIdxOSSREJ()
   do while.not.dostepex('OSSREJ')
   enddo
   pack
   index on firma + mc + dzien + nrdok TO ossrej
   RETURN NIL
****************************************
FUNCTION dbfIdxTAB_VATUE()
   do while.not.dostepex('TAB_VATUE')
   enddo
   pack
   index on del + kraj + DToS( oddnia ) TO tab_vatue
   index on del + kraj + Str( Descend( oddnia ) ) to tab_vatue1
   RETURN
****************************************
FUNCTION dbfIdxVIUDOKOR()
   do while.not.dostepex('VIUDOKOR')
   enddo
   pack
   index on firma + kwartal + kraj + rokkor + kwartkor to viudokor
   RETURN
****************************************
FUNCTION dbfIdxZUSKODNIE()
   do while.not.dostepex('ZUSKODNIE')
   enddo
   pack
   index on kod TO zuskodnie
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION dbfZnajdzTablice(cNazwa)
   LOCAL nI := 0
   FOR nI := 1 TO Len(TabliceDbf)
      IF Lower(TabliceDbf[nI][1]) == Lower(cNazwa)
         RETURN TabliceDbf[nI]
      ENDIF
   NEXT
   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION dbfUtworzTabele(cNazwa, cPlik)
   LOCAL aTabInfo := dbfZnajdzTablice(cNazwa)
   LOCAL aDbStruct := {}
   IF aTabInfo <> NIL
      aDbStruct := aTabInfo[3]
      dbCreate(cPlik, aDbStruct, "DBFCDX")
      RETURN .T.
   ENDIF
   RETURN .F.

/*----------------------------------------------------------------------*/

FUNCTION dbfUtworzWszystko(cSciezka, cRozszerzenie, bPostep) // {|aTab,nAktualny,nWszystkie| ... }
   LOCAL nI := 0
   IF cRozszerzenie == NIL .OR. cRozszerzenie == ''
      cRozszerzenie := ".dbf"
   ENDIF
   FOR nI := 1 TO Len(TabliceDbf)
      IF !Empty(bPostep)
         Eval(bPostep, TabliceDbf[nI], nI, Len(TabliceDbf))
      ENDIF
      dbfUtworzTabele(TabliceDbf[nI][1], DodajBackslash(cSciezka) + TabliceDbf[nI][1] + cRozszerzenie)
   NEXT
   RETURN

FUNCTION dbfImportujTablice(cStara, cNowa)
   dbUseArea(.F., "DBFCDX", cStara, ,.F.)
   APPEND FROM cStara VIA "DBFCDX"
   dbCloseArea()
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION dbfUtworzIndeksy(bPostep, cKatalog)  // { | aTab, nAktualny, nWszystkie | ... }
   LOCAL nI := 0, cIdxFunc := "", nIlosc := 0, nLicznik := 1, cAktualnyKatalog := CurDir()
   IF !Empty(bPostep)
      FOR nI := 1 TO Len(TabliceDbf)
         IF TabliceDbf[nI][4] == .T.
            nIlosc := nIlosc + 1
         ENDIF
      NEXT
   ENDIF
   IF !Empty(cKatalog)
      DirChange(cKatalog)
   ENDIF
   FOR nI := 1 TO Len(TabliceDbf)
      IF TabliceDbf[nI][4] == .T.
         IF !Empty(bPostep)
            Eval(bPostep, TabliceDbf[nI], nLicznik, nIlosc)
         ENDIF
         cIdxFunc := "dbfIdx" + Upper(TabliceDbf[nI][1]) + "()"
         &cIdxFunc
         nLicznik := nLicznik + 1
      ENDIF
   NEXT
   IF !Empty(cKatalog)
      DirChange(cAktualnyKatalog)
   ENDIF
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION dbfImportujDaneTym(cSciezka, cRozszerzenie)
   LOCAL aPlikiTym := {}, nI := 0, cFNazwa, cFRozsz, cFSciezka
   IF cRozszerzenie == NIL
      cRozszerzenie := "TYM"
   ENDIF
   aPlikiTym := Directory(DodajBackslash(cSciezka) + "*." + cRozszerzenie)
   FOR nI := 1 TO Len(aPlikiTym)
      hb_FNameSplit(aPlikiTym[nI][1], @cFSciezka, @cFNazwa, @cFRozsz)
      IF File(DodajBackslash(cSciezka) + cFNazwa + ".dbf")
         dbUseArea(.F., "DBFCDX", DodajBackslash(cSciezka) + aPlikiTym[nI][1])
         APPEND FROM (DodajBackslash(cSciezka) + cFNazwa + ".dbf") VIA "DBFNTX"
         dbCloseArea()
         FErase(DodajBackslash(cSciezka) + cFNazwa + ".dbf")
         FRename(DodajBackslash(cSciezka) + aPlikiTym[nI][1], DodajBackslash(cSciezka) + cFNazwa + ".dbf")
      ENDIF
   NEXT
   RETURN

