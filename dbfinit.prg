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

FUNCTION dbfInicjujDane()

// Create: AMORT.DBF
public  aAMORTdbf := {;
   { "ID", "+", 4, 0 },;
   { "DEL", "C", 1, 0 },;
   { "FIRMA", "C", 3, 0 },;
   { "IDENT", "C", 5, 0 },;
   { "ROK", "C", 4, 0 },;
   { "WART_POCZ", "N", 12, 2 },;
   { "PRZEL", "N", 6, 2 },;
   { "WART_MOD", "N", 12, 2 },;
   { "WART_AKT", "N", 12, 2 },;
   { "UMORZ_AKT", "N", 12, 2 },;
   { "STAWKA", "N", 6, 2 },;
   { "WSPDEG", "N", 4, 2 },;
   { "LINIOWO", "N", 12, 2 },;
   { "DEGRES", "N", 12, 2 },;
   { "MC01", "N", 9, 2 },;
   { "MC02", "N", 9, 2 },;
   { "MC03", "N", 9, 2 },;
   { "MC04", "N", 9, 2 },;
   { "MC05", "N", 9, 2 },;
   { "MC06", "N", 9, 2 },;
   { "MC07", "N", 9, 2 },;
   { "MC08", "N", 9, 2 },;
   { "MC09", "N", 9, 2 },;
   { "MC10", "N", 9, 2 },;
   { "MC11", "N", 9, 2 },;
   { "MC12", "N", 9, 2 },;
   { "ODPIS_ROK", "N", 12, 2 },;
   { "ODPIS_SUM", "N", 12, 2 } }

// Create: DANE_MC.DBF
public aDANE_MCdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "IDENT", "C", 5, 0 },;                       //  3
   { "MC", "C", 2, 0 },;                          //  4
   { "G_PRZYCH1", "N", 11, 2 },;                  //  5
   { "G_PRZYCH2", "N", 11, 2 },;                  //  6
   { "G_PRZYCH3", "N", 11, 2 },;                  //  7
   { "G_PRZYCH4", "N", 11, 2 },;                  //  8
   { "G_KOSZTY1", "N", 11, 2 },;                  //  9
   { "G_KOSZTY2", "N", 11, 2 },;                  //  10
   { "G_KOSZTY3", "N", 11, 2 },;                  //  11
   { "G_KOSZTY4", "N", 11, 2 },;                  //  12
   { "G_UDZIAL1", "C", 6, 0 },;                   //  13
   { "G_UDZIAL2", "C", 6, 0 },;                   //  14
   { "G_UDZIAL3", "C", 6, 0 },;                   //  15
   { "G_UDZIAL4", "C", 6, 0 },;                   //  16
   { "N_PRZYCH1", "N", 11, 2 },;                  //  17
   { "N_PRZYCH2", "N", 11, 2 },;                  //  18
   { "N_KOSZTY1", "N", 11, 2 },;                  //  19
   { "N_KOSZTY2", "N", 11, 2 },;                  //  20
   { "N_UDZIAL1", "C", 6, 0 },;                   //  21
   { "N_UDZIAL2", "C", 6, 0 },;                   //  22
   { "STRATY", "N", 11, 2 },;                     //  23
   { "STRATY_N", "N", 11, 2 },;                   //  24
   { "POWODZ", "N", 11, 2 },;                     //  25
   { "RENTALIM", "N", 11, 2 },;                   //  26
   { "SKLADKI", "N", 11, 2 },;                    //  27
   { "SKLADKIW", "N", 11, 2 },;                   //  28
   { "PODSTAWA", "N", 11, 2 },;                   //  29
   { "STAW_WUE", "N", 5, 2 },;                    //  30
   { "STAW_WUR", "N", 5, 2 },;                    //  31
   { "STAW_WUC", "N", 5, 2 },;                    //  32
   { "STAW_WUZ", "N", 5, 2 },;                    //  33
   { "STAW_WUW", "N", 5, 2 },;                    //  34
   { "STAW_WFP", "N", 5, 2 },;                    //  35
   { "STAW_WFG", "N", 5, 2 },;                    //  36
   { "STAW_WSUM", "N", 5, 2 },;                   //  37
   { "WAR_WUE", "N", 8, 2 },;                     //  38
   { "WAR_WUR", "N", 8, 2 },;                     //  39
   { "WAR_WUC", "N", 8, 2 },;                     //  40
   { "WAR_WUZ", "N", 8, 2 },;                     //  41
   { "WAR_WUW", "N", 8, 2 },;                     //  42
   { "WAR_WFP", "N", 8, 2 },;                     //  43
   { "WAR_WFG", "N", 8, 2 },;                     //  44
   { "WAR_WSUM", "N", 8, 2 },;                    //  45
   { "WAR5_WUE", "N", 8, 2 },;                    //  46
   { "WAR5_WUR", "N", 8, 2 },;                    //  47
   { "WAR5_WUC", "N", 8, 2 },;                    //  48
   { "WAR5_WUZ", "N", 8, 2 },;                    //  49
   { "WAR5_WUW", "N", 8, 2 },;                    //  50
   { "WAR5_WFP", "N", 8, 2 },;                    //  51
   { "WAR5_WFG", "N", 8, 2 },;                    //  52
   { "MC_WUE", "N", 2, 0 },;                      //  53
   { "MC_WUR", "N", 2, 0 },;                      //  54
   { "MC_WUC", "N", 2, 0 },;                      //  55
   { "MC_WUZ", "N", 2, 0 },;                      //  56
   { "MC_WUW", "N", 2, 0 },;                      //  57
   { "ORGANY", "N", 11, 2 },;                     //  58
   { "ZWROT_REN", "N", 11, 2 },;                  //  59
   { "ZWROT_SWI", "N", 11, 2 },;                  //  60
   { "REHAB", "N", 11, 2 },;                      //  61
   { "KOPALINY", "N", 11, 2 },;                   //  62
   { "DAROWIZ", "N", 11, 2 },;                    //  63
   { "INNE", "N", 11, 2 },;                       //  64
   { "BUDOWA", "N", 11, 2 },;                     //  65
   { "INWEST11", "N", 11, 2 },;                   //  66
   { "DOCHZWOL", "N", 11, 2 },;                   //  67
   { "AAA", "N", 11, 2 },;                        //  68
   { "BBB", "N", 11, 2 },;                        //  69
   { "ZALICZKAP", "N", 11, 2 },;                  //  70
   { "ZALICZKA", "N", 11, 2 },;                   //  71
   { "PIT597", "N", 11, 2 },;                     //  72
   { "PIT569", "N", 11, 2 },;                     //  73
   { "PIT5104", "N", 11, 2 },;                    //  74
   { "PIT5105", "N", 11, 2 },;                    //  75
   { "PIT5AGOSK", "N", 11, 2 },;                  //  76
   { "PIT5ANAJK", "N", 11, 2 },;                  //  77
   { "PIT5AGOSP", "N", 11, 2 },;                  //  78
   { "PIT5ANAJP", "N", 11, 2 },;                  //  79
   { "G21", "N", 11, 2 },;                        //  80
   { "H385", "N", 11, 2 },;                       //  81
   { "ZDROWIE", "N", 11, 2 },;                    //  82
   { "ZDROWIEW", "N", 11, 2 },;                   //  83
   { "WYNAGRO", "N", 11, 2 },;                    //  84
   { "UBIEGBUD", "N", 11, 2 },;                   //  85
   { "UBIEGINW", "N", 11, 2 },;                   //  86
   { "ODSEODMAJ", "N", 11, 2 },;                  //  87
   { "STAW5_WUZ", "N", 5, 2 },;                   //  88
   { "INNEODPOD", "N", 11, 2 },;                  //  89
   { "PODSTZDR", "N", 11, 2 } }                   //  90

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
   { "STAW_PODA2", "N", 5, 2 } }                  // 113

// Create: EWID.DBF
public aEWIDdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "MC", "C", 2, 0 },;                          //  4
   { "DZIEN", "C", 2, 0 },;                       //  5
   { "DATAPRZY", "D", 8, 0 },;                    //  6
   { "NUMER", "C", 40, 0 },;                      //  7
   { "TRESC", "C", 30, 0 },;                      //  8
   { "HANDEL", "N", 11, 2 },;                     //  9
   { "PRODUKCJA", "N", 11, 2 },;                  //  10
   { "USLUGI", "N", 11, 2 },;                     //  11
   { "UWAGI", "C", 14, 0 },;                      //  12
   { "ZAPLATA", "C", 1, 0 },;                     //  13
   { "KWOTA", "N", 11, 2 },;                      //  14
   { "LP", "N", 5, 0 },;                          //  15
   { "ZAPIS", "N", 10, 0 },;                      //  16
   { "REJZID", "N", 5, 0 },;                      //  17
   { "RY20", "N", 11, 2 },;                       //  18
   { "RY17", "N", 11, 2 },;                       //  19
   { "RY10", "N", 11, 2 } }                       //  20

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
   { "KM", "N", 4, 0 } }                          //   10

// Create: FAKTURY.DBF
public aFAKTURYdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "REC_NO", "N", 5, 0 },;                      //  4
   { "MC", "C", 2, 0 },;                          //  5
   { "DZIEN", "C", 2, 0 },;                       //  6
   { "NUMER", "N", 5, 0 },;                       //  7
   { "NAZWA", "C", 100, 0 },;                      //  8
   { "ADRES", "C", 100, 0 },;                      //  9
   { "SPOSOB_P", "N", 1, 0 },;                    //  10
   { "TERMIN_Z", "N", 2, 0 },;                    //  11
   { "KWOTA", "N", 12, 2 },;                      //  12
   { "DATAS", "D", 8, 0 },;                       //  13
   { "DATAZ", "D", 8, 0 },;                       //  14
   { "ZAMOWIENIE", "C", 30, 0 },;                 //  15
   { "NR_IDENT", "C", 30, 0 },;                   //  16
   { "RACH", "C", 1, 0 },;                        //  17
   { "ODBNAZWA", "C", 60, 0 },;                   //  18
   { "ODBADRES", "C", 40, 0 },;                   //  19
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
   { "WARTRANSP", "C", 1, 0 },;                   //  31
   { "PRZEZNACZ", "C", 40, 0 },;                  //  32
   { "DATA2TYP", "C", 1, 0 },;                    //  33
   { "FAKTTYP", "C", 60, 0 },;                    //  34
   { "ROZRZAPF", "C", 1, 0 },;                    //  35
   { "ZAP_TER", "N", 3, 0 },;                     //  36
   { "ZAP_DAT", "D", 8, 0 },;                     //  37
   { "ZAP_WART", "N", 11, 2 },;                   //  38
   { "SPLITPAY", "C", 1, 0 } }                     //  39

// Create: FAKTURYW.DBF
public aFAKTURYWdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "REC_NO", "N", 5, 0 },;                      //  4
   { "MC", "C", 2, 0 },;                          //  5
   { "DZIEN", "C", 2, 0 },;                       //  6
   { "NUMER", "N", 5, 0 },;                       //  7
   { "NAZWA", "C", 100, 0 },;                      //  8
   { "ADRES", "C", 100, 0 },;                      //  9
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
   { "SYMBOL", "C", 10, 0 },;                     //  3
   { "NAZWA", "C", 60, 0 },;                      //  4
   { "NAZWA_SKR", "C", 60, 0 },;                  //  5
   { "SPOLKA", "L", 1, 0 },;                      //  6
   { "ORGAN", "N", 2, 0 },;                       //  7
   { "REJESTR", "N", 2, 0 },;                     //  8
   { "MIEJSC", "C", 20, 0 },;                     //  9
   { "GMINA", "C", 20, 0 },;                      //  10
   { "ULICA", "C", 20, 0 },;                      //  11
   { "NR_DOMU", "C", 5, 0 },;                     //  12
   { "NR_MIESZK", "C", 5, 0 },;                   //  13
   { "KOD_P", "C", 6, 0 },;                       //  14
   { "POCZTA", "C", 20, 0 },;                     //  15
   { "SKRYTKA", "C", 5, 0 },;                     //  16
   { "TEL", "C", 10, 0 },;                        //  17
   { "FAX", "C", 10, 0 },;                        //  18
   { "TLX", "C", 10, 0 },;                        //  19
   { "PRZEDM", "C", 40, 0 },;                     //  20
   { "KGN1", "C", 8, 0 },;                        //  21
   { "EKD1", "C", 8, 0 },;                        //  22
   { "NR_REGON", "C", 35, 0 },;                   //  23
   { "NR_KONTA", "C", 32, 0 },;                   //  24
   { "BANK", "C", 30, 0 },;                       //  25
   { "NAZWISKO", "C", 30, 0 },;                   //  26
   { "NIP", "C", 13, 0 },;                        //  27
   { "NKP", "C", 15, 0 },;                        //  28
   { "ODZUS", "C", 20, 0 },;                      //  29
   { "NR_FAKT", "N", 5, 0 },;                     //  30
   { "LICZBA", "N", 5, 0 },;                      //  31
   { "VAT", "C", 1, 0 },;                         //  32
   { "NR_RACH", "N", 5, 0 },;                     //  33
   { "KOR_FAKT", "N", 5, 0 },;                    //  34
   { "KOR_RACH", "N", 5, 0 },;                    //  35
   { "NR_SKUP", "N", 5, 0 },;                     //  36
   { "DATAVAT", "D", 8, 0 },;                     //  37
   { "DETAL", "C", 1, 0 },;                       //  38
   { "LICZBA_WYP", "N", 5, 0 },;                  //  39
   { "RYCZALT", "C", 1, 0 },;                     //  40
   { "SKARB", "N", 3, 0 },;                       //  41
   { "DATA_ZAL", "D", 8, 0 },;                    //  42
   { "DATA_REJ", "D", 8, 0 },;                    //  43
   { "NUMER_REJ", "C", 11, 0 },;                  //  44
   { "PARAM_WOJ", "C", 20, 0 },;                  //  45
   { "PARAM_POW", "C", 20, 0 },;                  //  46
   { "HASLO", "C", 10, 0 },;                      //  47
   { "FAKT_MIEJ", "C", 20, 0 },;                  //  48
   { "VATOKRES", "C", 1, 0 },;                    //  49
   { "PARAP_PUW", "N", 5, 2 },;                   //  50
   { "PARAP_FUW", "N", 5, 2 },;                   //  51
   { "PARAP_FWW", "N", 5, 2 },;                   //  52
   { "NIPUE", "C", 13, 0 },;                      //  53
   { "ROKOPOD", "N", 11, 2 },;                    //  54
   { "ROKOGOL", "N", 11, 2 },;                    //  55
   { "STRUSPRWY", "N", 6, 2 },;                   //  56
   { "STRUSPROB", "N", 6, 2 },;                   //  57
   { "NR_FAKTW", "N", 5, 0 },;                    //  58
   { "DEKLNAZWI", "C", 20, 0 },;                  //  59
   { "DEKLIMIE", "C", 15, 0 },;                   //  60
   { "DEKLTEL", "C", 25, 0 },;                    //  61
   { "DATAKS", "C", 1, 0 },;                      //  62
   { "PITOKRES", "C", 1, 0 },;                    //  63
   { "VATOKRESDR", "C", 1, 0 },;                  //  64
   { "VATFORDR", "C", 2, 0 },;                    //  65
   { "UEOKRES", "C", 1, 0 },;                     //  66
   { "DATA2TYP", "C", 1, 0 },;                    //  67
   { "ROZRZAPK", "C", 1, 0 },;                    //  68
   { "ROZRZAPS", "C", 1, 0 },;                    //  69
   { "ROZRZAPZ", "C", 1, 0 },;                    //  70
   { "ROZRZAPF", "C", 1, 0 },;                    //  71
   { "RODZNRKS", "C", 1, 0 },;                    //  72
   { "EMAIL", "C", 60, 0 } }                      //  73

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
   { "DOWOD_ZAK", "C", 10, 0 },;                  //  10
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

// Create: KAT_SPR.DBF
public aKAT_SPRdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "SYMB_REJ", "C", 2, 0 },;                    //   4
   { "OPIS", "C", 40, 0 },;                       //   5
   { "OPCJE", "C", 1, 0 } }                       //   6

// Create: KAT_ZAK.DBF
public aKAT_ZAKdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "SYMB_REJ", "C", 2, 0 },;                    //   4
   { "OPIS", "C", 40, 0 },;                       //   5
   { "OPCJE", "C", 1, 0 } }                       //   6

// Create: KONTR.DBF
public aKONTRdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "NAZWA", "C", 100, 0 },;                      //  4
   { "ADRES", "C", 100, 0 },;                      //  5
   { "NR_IDENT", "C", 30, 0 },;                   //  6
   { "EXPORT", "C", 1, 0 },;                      //  7
   { "BANK", "C", 28, 0 },;                       //  8
   { "KONTO", "C", 32, 0 },;                      //  9
   { "TEL", "C", 20, 0 },;                        //  10
   { "UE", "C", 1, 0 },;                          //  11
   { "KRAJ", "C", 2, 0 } }                        //  12

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
   { "PLATNE", "L", 1, 0 } }                      //   9

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
   { "NUMER", "C", 40, 0 },;                      //  6
   { "NAZWA", "C", 100, 0 },;                      //  7
   { "ADRES", "C", 100, 0 },;                      //  8
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
   { "K16OPIS", "C", 30, 0 } }                    //  32

// Create: ORGANY.DBF
public aORGANYdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "NAZWA_ORG", "C", 60, 0 } }                  //   3

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
   { "OSWIAD26R", "C", 1, 0 } }                   //  80

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

// Create: REJESTRY.DBF
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
   { "NUMER", "C", 40, 0 },;                      //  6
   { "NAZWA", "C", 100, 0 },;                      //  7
   { "ADRES", "C", 100, 0 },;                      //  8
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
   { "DATA_ZAP", "D", 8, 0 },;                    //  36
   { "KRAJ", "C", 2, 0 },;                        //  37
   { "UE", "C", 1, 0 },;                          //  38
   { "SEK_CV7", "C", 2, 0 },;                     //  39
   { "ROZRZAPS", "C", 1, 0 },;                    //  40
   { "ZAP_TER", "N", 3, 0 },;                     //  41
   { "ZAP_DAT", "D", 8, 0 },;                     //  42
   { "ZAP_WART", "N", 11, 2 },;                   //  43
   { "OPCJE", "C", 1, 0 },;                       //  44
   { "TROJSTR", "C", 1, 0 },;                     //  45
   { "KOL36", "N", 11, 2 },;                      //  46
   { "KOL37", "N", 11, 2 },;                      //  47
   { "KOL38", "N", 11, 2 },;                      //  48
   { "KOL39", "N", 11, 2 },;                      //  49
   { "KOLUMNA2", "C", 2, 0 },;                    //  50
   { "NETTO2", "N", 11, 2 },;                     //  51
   { "DATATRAN", "D", 8, 0 } }                    //  52

// Create: REJZ.DBF
public aREJZdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "MC", "C", 2, 0 },;                          //  4
   { "DZIEN", "C", 2, 0 },;                       //  5
   { "NUMER", "C", 40, 0 },;                      //  6
   { "NAZWA", "C", 100, 0 },;                     //  7
   { "ADRES", "C", 100, 0 },;                     //  8
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
   { "DATATRAN", "D", 8, 0 } }                    //  66

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
   { "NRDOK", "C", 40, 0 },;                      //  9
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
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "NAZ_IMIE", "C", 30, 0 },;                   //  4
   { "PESEL", "C", 11, 0 },;                      //  5
   { "NIP", "C", 13, 0 },;                        //  6
   { "IMIE_O", "C", 15, 0 },;                     //  7
   { "IMIE_M", "C", 15, 0 },;                     //  8
   { "MIEJSC_UR", "C", 20, 0 },;                  //  9
   { "DATA_UR", "D", 8, 0 },;                     //  10
   { "MIEJSC_ZAM", "C", 20, 0 },;                 //  11
   { "GMINA", "C", 20, 0 },;                      //  12
   { "ULICA", "C", 20, 0 },;                      //  13
   { "NR_DOMU", "C", 10, 0 },;                    //  14
   { "NR_MIESZK", "C", 10, 0 },;                  //  15
   { "KOD_POCZT", "C", 6, 0 },;                   //  16
   { "POCZTA", "C", 20, 0 },;                     //  17
   { "RODZ_DOK", "C", 1, 0 },;                    //  18
   { "DOWOD_OSOB", "C", 9, 0 },;                  //  19
   { "NAZW_RODU", "C", 30, 0 },;                  //  20
   { "OBYWATEL", "C", 22, 0 },;                   //  21
   { "PLEC", "C", 1, 0 },;                        //  22
   { "UDZIAL1", "C", 7, 0 },;                     //  23
   { "UDZIAL2", "C", 7, 0 },;                     //  24
   { "UDZIAL3", "C", 7, 0 },;                     //  25
   { "UDZIAL4", "C", 7, 0 },;                     //  26
   { "UDZIAL5", "C", 7, 0 },;                     //  27
   { "UDZIAL6", "C", 7, 0 },;                     //  28
   { "UDZIAL7", "C", 7, 0 },;                     //  29
   { "UDZIAL8", "C", 7, 0 },;                     //  30
   { "UDZIAL9", "C", 7, 0 },;                     //  31
   { "UDZIAL10", "C", 7, 0 },;                    //  32
   { "UDZIAL11", "C", 7, 0 },;                    //  33
   { "UDZIAL12", "C", 7, 0 },;                    //  34
   { "G_RODZAJ1", "C", 40, 0 },;                  //  35
   { "G_RODZAJ2", "C", 40, 0 },;                  //  36
   { "G_RODZAJ3", "C", 40, 0 },;                  //  37
   { "G_RODZAJ4", "C", 40, 0 },;                  //  38
   { "G_REGON1", "C", 35, 0 },;                   //  39
   { "G_REGON2", "C", 35, 0 },;                   //  40
   { "G_REGON3", "C", 35, 0 },;                   //  41
   { "G_REGON4", "C", 35, 0 },;                   //  42
   { "G_MIEJSC1", "C", 40, 0 },;                  //  43
   { "G_MIEJSC2", "C", 40, 0 },;                  //  44
   { "G_MIEJSC3", "C", 40, 0 },;                  //  45
   { "G_MIEJSC4", "C", 40, 0 },;                  //  46
   { "N_PRZEDM1", "C", 40, 0 },;                  //  47
   { "N_PRZEDM2", "C", 40, 0 },;                  //  48
   { "N_MIEJSC1", "C", 40, 0 },;                  //  49
   { "N_MIEJSC2", "C", 40, 0 },;                  //  50
   { "TELEFON", "C", 10, 0 },;                    //  51
   { "SKARB", "N", 3, 0 },;                       //  52
   { "S_RODZAJ", "C", 30, 0 },;                   //  53
   { "ODLICZ1", "C", 30, 0 },;                    //  54
   { "G_NIP1", "C", 13, 0 },;                     //  55
   { "G_NIP2", "C", 13, 0 },;                     //  56
   { "G_NIP3", "C", 13, 0 },;                     //  57
   { "G_NIP4", "C", 13, 0 },;                     //  58
   { "PARAM_WOJ", "C", 20, 0 },;                  //  59
   { "PARAM_POW", "C", 20, 0 },;                  //  60
   { "PARAM_KW", "N", 9, 2 },;                    //  61
   { "H384", "C", 20, 0 },;                       //  62
   { "H386", "D", 8, 0 },;                        //  63
   { "ODLICZ2", "C", 30, 0 },;                    //  64
   { "SPOSOB", "C", 1, 0 },;                      //  65
   { "KOD_TYTU", "C", 6, 0 },;                    //  66
   { "KRAJ", "C", 10, 0 },;                       //  67
   { "OBLKWWOL", "C", 1, 0 },;                    //  68
   { "PARAM_KWD", "D", 8, 0 },;                  //  69
   { "PARAM_KW2", "N", 9, 2 } }                   //  70

// Create: SUMA_MC.DBF
public aSUMA_MCdbf := {;
   { "ID", "+", 4, 0 },;                          //  1
   { "DEL", "C", 1, 0 },;                         //  2
   { "FIRMA", "C", 3, 0 },;                       //  3
   { "MC", "C", 2, 0 },;                          //  4
   { "HANDEL", "N", 12, 2 },;                     //  5
   { "WYR_TOW", "N", 12, 2 },;                    //  6
   { "USLUGI", "N", 12, 2 },;                     //  7
   { "ZAKUP", "N", 12, 2 },;                      //  8
   { "UBOCZNE", "N", 12, 2 },;                    //  9
   { "REKLAMA", "N", 12, 2 },;                    //  10
   { "WYNAGR_G", "N", 12, 2 },;                   //  11
   { "WYDATKI", "N", 12, 2 },;                    //  12
   { "PUSTA", "N", 12, 2 },;                      //  13
   { "POZYCJE", "N", 5, 0 },;                     //  14
   { "ZAMEK", "L", 1, 0 },;                       //  15
   { "VAT760", "N", 12, 2 },;                     //  16
   { "VAT723", "N", 12, 2 },;                     //  17
   { "VAT759", "N", 12, 2 },;                     //  18
   { "VAT7F", "C", 1, 0 },;                       //  19
   { "VAT740", "N", 12, 2 },;                     //  20
   { "VAT736", "N", 12, 2 },;                     //  21
   { "VAT762", "N", 12, 2 },;                     //  22
   { "MIES6OPOD", "N", 11, 2 },;                  //  23
   { "MIES6OGOL", "N", 11, 2 },;                  //  24
   { "NRSTOPODNE", "N", 11, 2 },;                 //  25
   { "NRSTOPODVA", "N", 11, 2 },;                 //  26
   { "NRSTMIESNE", "N", 11, 2 },;                 //  27
   { "NRSTMIESVA", "N", 11, 2 },;                 //  28
   { "NRPOOPODNE", "N", 11, 2 },;                 //  29
   { "NRPOOPODVA", "N", 11, 2 },;                 //  30
   { "NRPOMIESNE", "N", 11, 2 },;                 //  31
   { "NRPOMIESVA", "N", 11, 2 },;                 //  32
   { "KORZAK1MC", "C", 6, 0 },;                   //  33
   { "KORZAK2MC", "C", 6, 0 },;                   //  34
   { "KORZAK3MC", "C", 6, 0 },;                   //  35
   { "KORZAK4MC", "C", 6, 0 },;                   //  36
   { "KORZAK1VAT", "N", 11, 2 },;                 //  37
   { "KORZAK2VAT", "N", 11, 2 },;                 //  38
   { "KORZAK3VAT", "N", 11, 2 },;                 //  39
   { "KORZAK4VAT", "N", 11, 2 },;                 //  40
   { "KORSPR1MC", "C", 6, 0 },;                   //  41
   { "KORSPR2MC", "C", 6, 0 },;                   //  42
   { "KORSPR3MC", "C", 6, 0 },;                   //  43
   { "KORSPR4MC", "C", 6, 0 },;                   //  44
   { "KORSPR1VAT", "N", 11, 2 },;                 //  45
   { "KORSPR2VAT", "N", 11, 2 },;                 //  46
   { "KORSPR3VAT", "N", 11, 2 },;                 //  47
   { "KORSPR4VAT", "N", 11, 2 },;                 //  48
   { "LICZ_MIES", "N", 1, 0 },;                   //  49
   { "KASA_ODL", "N", 11, 0 },;                   //  50
   { "KASA_ZWR", "N", 11, 0 },;                   //  51
   { "RY20", "N", 12, 2 },;                       //  52
   { "RY17", "N", 12, 2 },;                       //  53
   { "RY10", "N", 12, 2 },;                       //  54
   { "NOWYTRAN", "N", 11, 2 },;                   //  55
   { "KOREKST", "N", 11, 2 },;                    //  56
   { "KOREKPOZ", "N", 11, 2 },;                   //  57
   { "ZWR180DNI", "N", 11, 2 },;                  //  58
   { "F1", "C", 1, 0 },;                          //  59
   { "F2", "C", 1, 0 },;                          //  60
   { "F3", "C", 1, 0 },;                          //  61
   { "F4", "C", 1, 0 },;                          //  62
   { "F5", "C", 1, 0 },;                          //  63
   { "P4IL_POD", "N", 2, 0 },;                    //  64
   { "P4SUM_WYP", "N", 11, 2 },;                  //  65
   { "P4SUM_ZAL", "N", 11, 2 },;                  //  66
   { "VATART129", "N", 11, 2 },;                  //  67
   { "ZWR60DNI", "N", 11, 2 },;                   //  68
   { "P4POTRAC", "N", 4, 2 },;                    //  69
   { "P4NALZAL33", "N", 11, 2 },;                 //  70
   { "P4OGRZAL", "N", 11, 2 },;                   //  71
   { "P4OGRZAL33", "N", 11, 2 },;                 //  72
   { "P4DODZAL", "N", 11, 2 },;                   //  73
   { "P4NADZWR", "N", 11, 2 },;                   //  74
   { "P4PFRON", "N", 11, 2 },;                    //  75
   { "P4AKTYW", "N", 11, 2 },;                    //  76
   { "P4ZAL13", "N", 11, 2 },;                    //  77
   { "P4WYNAGR", "N", 11, 2 },;                   //  78
   { "ZWR25DNI", "N", 11, 2 },;                   //  79
   { "VATZALMIE", "N", 11, 2 },;                  //  80
   { "VATNADKWA", "N", 11, 2 },;                  //  81
   { "P8ZLECRY", "N", 11, 2 },;                   //  82
   { "P8WYNAGR", "N", 11, 2 },;                   //  83
   { "P8POTRAC", "N", 4, 2 },;                    //  84
   { "P8ZLECIN", "N", 11, 2 },;                   //  85
   { "A89B1", "N", 11, 2 },;                      //  86
   { "A89B4", "N", 11, 2 },;                      //  87
   { "A111U6", "N", 11, 2 },;                     //  88
   { "WERJPKVAT", "N", 3, 0 },;                   //  89
   { "ZWRRAVAT", "N", 11, 2 } }                   //  90

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
   { "DEL", "C", 1, 0 },;                         //   2
   { "PODSTAWA", "N", 11, 2 },;                   //   3
   { "PROCENT", "N", 2, 0 },;                     //   4
   { "KWOTAZMN", "N", 11, 2 },;                   //   5
   { "DEGRES", "L", 1, 0 },;                      //   6
   { "KWOTADE1", "N", 11, 2 },;                   //   7
   { "KWOTADE2", "N", 11, 2 },;                   //   8
   { "DATAOD", "D", 8, 0 },;                      //   9
   { "DATADO", "D", 8, 0 },;                      //  10
   { "PROCENT2", "N", 5, 2 } }                    //  11

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

// Create: TRESC.DBF
public aTRESCdbf := {;
   { "ID", "+", 4, 0 },;                          //   1
   { "DEL", "C", 1, 0 },;                         //   2
   { "FIRMA", "C", 3, 0 },;                       //   3
   { "TRESC", "C", 30, 0 },;                      //   4
   { "STAN", "N", 12, 2 },;                       //   5
   { "RODZAJ", "C", 1, 0 },;                      //   6
   { "OPCJE", "C", 1, 0 } }                       //   7

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
   { "PODATEK", "N", 12, 2 },;                    //  21
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
   { "STAW_PODA2", "N", 5, 2 } }                  //  84

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
   { "faktury",  "faktury.dbf",  aFAKTURYdbf,  .T. },;
   { "fakturyw", "fakturyw.dbf", aFAKTURYWdbf, .T. },;
   { "firma",    "firma.dbf",    aFIRMAdbf,    .T. },;
   { "kartst",   "kartst.dbf",   aKARTSTdbf,   .T. },;
   { "kartstmo", "kartstmo.dbf", aKARTSTMOdbf, .T. },;
   { "kat_spr",  "kat_spr.dbf",  aKAT_SPRdbf,  .T. },;
   { "kat_zak",  "kat_zak.dbf",  aKAT_ZAKdbf,  .T. },;
   { "kontr",    "kontr.dbf",    aKONTRdbf,    .T. },;
   { "krst",     "krst.dbf",     aKRSTdbf,     .T. },;
   { "nieobec",  "nieobec.dbf",  aNIEOBECdbf,  .T. },;
   { "notes",    "notes.dbf",    aNOTESdbf,    .T. },;
   { "oper",     "oper.dbf",     aOPERdbf,     .T. },;
   { "organy",   "organy.dbf",   aORGANYdbf,   .T. },;
   { "pit_27",   "pit_27.dbf",   aPIT_27dbf,   .F. },;
   { "pozycje",  "pozycje.dbf",  aPOZYCJEdbf,  .T. },;
   { "pozycjew", "pozycjew.dbf", aPOZYCJEWdbf, .T. },;
   { "prac",     "prac.dbf",     aPRACdbf,     .T. },;
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
   { "tab_poj",  "tab_poj.dbf",  aTAB_POJdbf,  .T. },;
   { "tab_vat",  "tab_vat.dbf",  aTAB_VATdbf,  .T. },;
   { "tabpit4r", "tabpit4r.dbf", aTABPIT4Rdbf, .F. },;
   { "tabpit8r", "tabpit8r.dbf", aTABPIT8Rdbf, .F. },;
   { "tresc",    "tresc.dbf",    aTRESCdbf,    .T. },;
   { "tresckor", "tresckor.dbf", aTRESCKORdbf, .T. },;
   { "umowy",    "umowy.dbf",    aUMOWYdbf,    .T. },;
   { "urzedy",   "urzedy.dbf",   aURZEDYdbf,   .T. },;
   { "wyplaty",  "wyplaty.dbf",  aWYPLATYdbf,  .T. },;
   { "wyposaz",  "wyposaz.dbf",  aWYPOSAZdbf,  .T. },;
   { "zaliczki", "zaliczki.dbf", aZALICZKIdbf, .T. } }
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
   index on del+DToS(dataod)+str(podstawa,11,2) to tab_doch
   RETURN
****************************************
*do while.not.dostepex('TAB_VAT')
*enddo
*pack
*index on NUMVAT to tab_vat
*index on SYMBVAT to tab_vat1
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
   RETURN
****************************************
FUNCTION dbfIdxKAT_ZAK()
   do while.not.dostepex('KAT_ZAK')
   enddo
   pack
   index on del+firma+symb_rej to kat_zak
   RETURN
****************************************
FUNCTION dbfIdxKAT_SPR()
   do while.not.dostepex('KAT_SPR')
   enddo
   pack
   index on del+firma+symb_rej to kat_spr
   RETURN
****************************************
FUNCTION dbfIdxTRESC()
   do while.not.dostepex('TRESC')
   enddo
   pack
   index on del+firma+tresc to tresc
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
   index on rec_no to prac3
   index on del+firma+pesel to prac4
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

