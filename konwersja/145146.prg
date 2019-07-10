#include "directry.ch"
#require hbwin.ch
#include "hblang.ch" 
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    145146.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 12.2 na 13.1
*****************************************************************************
* STACJA - stacja z ktorej odbywa sie instalacja a: lub b:
*****************************************************************************
FUNCTION Main()
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT('PL')
   hb_cdpSelect('PL852')
   SetMode(25, 80)
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )
param_dzw := 'T'
nr_uzytk=0
if file('use.mem')
   restore from use additive
endif
if file('KOLOR.mem')
   restore from kolor additive
   do case
   case KINESKOP='M'
        c1='N/W'
        c2='W/N'
        c3='W+/W'
        *C1='W+/G'
        CColErr='GR+/R,GR+/RB+,,N,R/N'
        CColInf='G/RB+,GR+/B,,N,N/BG'
        CColInb='G*/RB+,GR+/B,,N,N/BG'
        CColDlg=C2+','+C1+',,N,N/W'
        CColStd='GR/N,'+C3+',,N,N/W'
        CColSta='G/N,'+C3+',,N,G/N'
        CColSti='W/N,'+C3+',,N,G/N'
        CColStb='G*/N,'+C3+',,N,G/N'
        CColPro=C2+','+C1+',,N,'+C2
        CColInv='GR/N,N/W,,N,GR/N'
   case KINESKOP='K'
        CColErr='GR+/R,GR+/RB+,,N,R/N'
        CColInf='G/RB+,GR+/B,,N,N/BG'
        CColInb='G*/RB+,GR+/B,,N,N/BG'
        CColDlg='N/GR,N/G,,N,N/W'
        CColStd='GR/N,N/G,,N,N/W'
        CColSta='G/N,N/G,,N,G/N'
        CColSti='N/G,N/G,,N,G/N'
        CColStb='G*/N,N/G,,N,G/N'
        CColPro='N/GR,N/G,,N,N/GR'
        CColInv='GR/N,N/W,,N,GR/N'
   endcase
else
   KINESKOP='K'
   CColErr='GR+/R,GR+/RB+,,N,R/N'
   CColInf='G/RB+,GR+/B,,N,N/BG'
   CColInb='G*/RB+,GR+/B,,N,N/BG'
   CColDlg='N/GR,N/G,,N,N/W'
   CColStd='GR/N,N/G,,N,N/W'
   CColSta='G/N,N/G,,N,G/N'
   CColSti='N/G,N/G,,N,G/N'
   CColStb='G*/N,N/G,,N,G/N'
   CColPro='N/GR,N/G,,N,N/GR'
   CColInv='GR/N,N/W,,N,GR/N'
   c1='N/W'
   c2='W/N'
   c3='W+/W'
   *C1='W+/G'
   if .not.iscolor()
      KINESKOP='M'
      CColErr='GR+/R,GR+/RB+,,N,R/N'
      CColInf='G/RB+,GR+/B,,N,N/BG'
      CColInb='G*/RB+,GR+/B,,N,N/BG'
      CColDlg=C2+','+C1+',,N,N/W'
      CColStd='GR/N,'+C3+',,N,N/W'
      CColSta='G/N,'+C3+',,N,G/N'
      CColSti='W/N,'+C3+',,N,G/N'
      CColStb='G*/N,'+C3+',,N,G/N'
      CColPro=C2+','+C1+',,N,'+C2
      CColInv='GR/N,N/W,,N,GR/N'
   endif
endif
save to KOLOR all like KINESKOP
if file('POLSKA.mem')
   restore from polska additive
else
   POLSKA_1=.f.
   POLSKA_2=.f.
   POLSKA_3='0'
   POLSKA_D='N'
   save to POLSKA all like POLSKA_*
endif
JESTPOL=.f.
if POLSKA_1.and.file('POLZNAK.DEF')
   y=fopen('POLZNAK.DEF',0)
   znaki=freadstr(y,18)
   if ferror()=0
      JESTPOL=.t.
   endif
   fclose(y)
else
   znaki='ACELNOSZZacelnoszz'
endif
__A=substr(znaki,1,1)
__C=substr(znaki,2,1)
__E=substr(znaki,3,1)
__L=substr(znaki,4,1)
__N=substr(znaki,5,1)
__O=substr(znaki,6,1)
__S=substr(znaki,7,1)
__X=substr(znaki,8,1)
__Z=substr(znaki,9,1)
_A=substr(znaki,10,1)
_C=substr(znaki,11,1)
_E=substr(znaki,12,1)
_L=substr(znaki,13,1)
_N=substr(znaki,14,1)
_O=substr(znaki,15,1)
_S=substr(znaki,16,1)
_X=substr(znaki,17,1)
_Z=substr(znaki,18,1)


ODP=' '
param ETRY
CZAS=20
WERSJA4=.f.
WERSJA1=.f.
STACJA=alltrim(upper(ETRY))
if substr(STACJA,len(STACJA),1)='\'
   STACJA=substr(STACJA,1,len(STACJA)-1)
endif
setcancel(.f.)
readexit(.f.)
readinsert(.f.)
set talk off
set exact on
set cursor off
set softseek on
set century on
set date ansi
set deleted off
set wrap on
set scoreboard off
public awaria
set procedure to proc1
KONIEC=0
clear
*if STACJA<>'A:' .and. STACJA<>'B:'
*   do CENTRUJ with 16,'---------------------------------------------------------'
*   do CENTRUJ with 17,'UWAGA !!! Bledny parametr pierwszy. Mozliwe parametry to:'
*   do CENTRUJ with 18,'A:-instalacja ze stacji A:'
*   do CENTRUJ with 19,'B:-instalacja ze stacji B:'
*   do CENTRUJ with 20,'--------------------------'
*   KKK=inkey(0)
*   quit
*endif
do CZEKAJ
*if .not.fc('i.exe')
*   clear
*   do komun with 'Plik I.EXE jest uszkodzony. Uruchom instalacje z innej dyskietki'
*   KKK=inkey(0)
*   quit
*endif


***********************************************
/* if .not.fc('b.exe')
   clear
   do komun with 'Plik B.EXE jest uszkodzony. Uruchom instalacje z innej dyskietki'
   KKK=inkey(0)
   quit
ENDIF */
***********************************************


/* if .not.fc('p.exe')
   clear
   do komun with 'Plik P.EXE jest uszkodzony. Uruchom instalacje z innego dysku'
   KKK=inkey(0)
   quit
ENDIF */
clear
set color to /w
do CENTRUJ with 2," K O N W E R S J A   K S I E G I   wer.14.5  N A   14.6 "
set color to w
set cursor off
if file('param.mem')
   restore from param additive
else
   param_lp=[N]
endif
if file('TRAN146.MEM')
   rest from TRAN146 addi
else
   GOOD=1
   save to TRAN146 all like GOOD
endif
keyb chr(13)
do while GOOD < 8
   @  6,19 to 14,61 doub
   @  7,20 prompt ' 1. Kontrola zasobow                     '
   @  8,20 prompt ' 2. Tworzenie kopii awaryjnej            '
   @  9,20 prompt ' 3. Tworzenie nowych struktur            '
   @ 10,20 prompt ' 4. Doczytanie danych do nowych struktur '
   @ 11,20 prompt ' 5. Aktualizacja danych                  '
   @ 12,20 prompt ' 6. Porzadkowanie zbiorow                '
   @ 13,20 prompt ' 7. Wkopiowanie nowej wersji programu    '
   menu to GOOD
   do case
   case GOOD=1
        save scre to ROBGO
        do CZEKAJ
        WOLNE=diskspace()
        @ 20,10 say 'Wolna przestrzen na dysku ............: '+transform(WOLNE/1024000,'9 999 999.99')+' MB'
        RAZEM=0
        ZAJMAX=0
        ZAJDBF:=directory('*.dbf','D')
        aeval(zajdbf,{|zbi|RAZEM+=zbi[F_SIZE]})
        ZAJMAX=ZAJMAX+(RAZEM*1.7)
        @ 21,10 say 'Ilosc miejsca potrzebna do instalacji : '+transform(ZAJMAX/1024000,'9 999 999.99')+' MB'
        RAZEM=0
        ZAJEXE:=directory('*.exe','D')
        aeval(zajexe,{|zbi|RAZEM+=zbi[F_SIZE]})
        ZAJMAX=ZAJMAX+(RAZEM*1)
        @ 21,10 say 'Ilosc miejsca potrzebna do instalacji : '+transform(ZAJMAX/1024000,'9 999 999.99')+' MB'
        RAZEM=0
        ZAJNTX:=directory('*.ntx','D')
        aeval(zajntx,{|zbi|RAZEM+=zbi[F_SIZE]})
        ZAJMAX=ZAJMAX+(RAZEM*0.45)
        @ 21,10 say 'Ilosc miejsca potrzebna do instalacji : '+transform(ZAJMAX/1024000,'9 999 999.99')+' MB'
        RAZEM=0
        ZAJMEM:=directory('*.mem','D')
        aeval(zajmem,{|zbi|RAZEM+=zbi[F_SIZE]})
        ZAJMAX=ZAJMAX+(RAZEM*0.1)
        @ 21,10 say 'Ilosc miejsca potrzebna do instalacji : '+transform(ZAJMAX/1024000,'9 999 999.99')+' MB'
        RAZEM=0
        ZAJTXT:=directory('*.txt','D')
        aeval(zajtxt,{|zbi|RAZEM+=zbi[F_SIZE]})
        ZAJMAX=ZAJMAX+(RAZEM*0.2)
        ZAJMAX=ZAJMAX+1024000
        @ 21,10 say 'Ilosc miejsca potrzebna do instalacji : '+transform(ZAJMAX/1024000,'9 999 999.99')+' MB'
        WOLNE=diskspace()
        @ 20,10 say 'Wolna przestrzen na dysku ............: '+transform(WOLNE/1024000,'9 999 999.99')+' MB'
        if wolne<zajmax
           save scre to robkon
           do komun with 'ZA MALO MIEJSCA NA DYSKU !!!'
           quit
        endif
        inkey(5)
        //!B /y >>instal.146
        //a146_db_prac()
        GOOD=2
        save to TRAN146 all like GOOD
        rest scre from ROBGO
   case GOOD=2
        save scre to ROBGO
        do CZEKAJ
        @24,0
        if file('BOOK122.rar')
           dele file BOOK122.rar
        endif
        !7z a BOOK146.7z *.db* *.mem *.txt *.bat menu.exe prog.exe pol*.* >> instal.146
        GOOD=3
        save to TRAN146 all like GOOD
        rest scre from ROBGO
   case GOOD=3
        save scre to ROBGO
        do CZEKAJ

        //dbfUtworzIndeksy()
        //use
        dbfInicjujDane()
        dbfUtworzWszystko("", ".TYM")

        GOOD=4
        save to TRAN146 all like GOOD
        rest scre from ROBGO
   case GOOD=4
        save scre to ROBGO
        do CZEKAJ

        dbfImportujDaneTym("", "TYM")
        AEval(Directory("*.TYM"), { |aFile| ;
           FRename(aFile[F_NAME],  SubStr(aFile[F_NAME], 1, Len(aFile[F_NAME]) - 3 ) + "dbf" ) } )
 
        GOOD=5
        save to TRAN146 all like GOOD
        rest scre from ROBGO
   case GOOD=5
        save scre to ROBGO
        do CZEKAJ

        use prac excl
        repl AKTYWNY with 'T', RODZOBOW with '1' all
        use

        use tresc excl
        repl RODZAJ with 'O', OPCJE with ' ' all
        use
        
        use kat_spr excl
        repl OPCJE WITH " " all
        use
        
        use kat_zak excl
        repl OPCJE WITH " " all
        use
        
        GOOD=6
        save to TRAN146 all like GOOD
        rest scre from ROBGO
   case GOOD=6
        save scre to ROBGO
        do CZEKAJ
         
        AEval(Directory("*.NTX"), { |aFile| ;
           FErase(aFile[F_NAME]) } )
        dbfUtworzIndeksy()
        use

        GOOD=7
        save to TRAN146 all like GOOD
        rest scre from ROBGO
   case GOOD=7
        save scre to ROBGO
        do CZEKAJ
        GOOD=8
*        !I /y >>instal.072
        !P x -y >>instal.146
        save to TRAN146 all like GOOD
        KONIEC=1
        rest scre from ROBGO
   endcase
   if KONIEC=0
      keyb chr(13)
   endif
enddo
set color to
errorlevel(GOOD)
RETURN
***************************PROCEDURA  CENTRUJ******************************
****** par.wej.->nwier  - numer wiersza do wyswietlenia tekstu*************
******           ctekst - tekst do wyswietlenia****************************
***************************************************************************

PROC CENTRUJ

PARA nwier,ctekst

PRIV nwier
PRIV ctekst

@ nwier,((80-len(ctekst))/2) say ctekst

RETURN
***************************PROCEDURA  CZEKAJ ******************************
*PROC CZEKAJ
*
*set color to /w
*@ 15,20 clear to 19,60
*set color to /w*
*@ 15,20 to 19,60
*set color to /w
*do centruj with 17,'PROSZE CZEKAC. SYSTEM PRACUJE...'
*set color to
*
*RETURN
***************************Funkcja FC file compare - porownanie zbiorow*
func FC
para nfil
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
R=.t.
x1=fopen(nfil,0)
if fblad(ferror())<>0
   R=.f.
endif
size1=fseek(x1,0,2)
fseek(x1,0,0)

x2=fopen(stacja+'\'+nfil,0)
if fblad(ferror())<>0
   R=.f.
endif
size2=fseek(x2,0,2)
fseek(x2,0,0)

if size1#size2
   R=.f.
endif

pozycja=0
if R=.t.
   poz=pozycja
   rozmem=min(50000,memory(2)*512)

   do while pozycja<size1
      inf1=space(rozmem)
      inf2=space(rozmem)

      fread(x1,@inf1,rozmem)
      if fblad(ferror())<>0
         R=.f.
         exit
      endif

      fread(x2,@inf2,rozmem)
      if fblad(ferror())<>0
         R=.f.
         exit
      endif

      pozycja=pozycja+rozmem
      rozmem=min(rozmem,size1-pozycja)
      fseek(x1,pozycja,0)
      fseek(x2,pozycja,0)
   enddo
   rele rozmem
endif
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
fclose(x1)
fclose(x2)
release all like inf
return R
