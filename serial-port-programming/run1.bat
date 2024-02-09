:: =========================================================
:: Author: Amir Anwar
:: This is a batch file to compile and run x86 assembly code
:: =========================================================

:: Choose PORT for serial communication (COM1, COM2, OR pts/1, pts/2, ...)
serial1=directserial  realport:COM1


:: Clean files
echo "=================================="
echo "Clean files"
DEL *.MAP
DEL *.OBJ
DEL *.EXE


:: Compile
echo "=================================="
echo "Compile"
TASM *.ASM

:: LINKING (IMPORTANT)
echo "=================================="
echo "Linking"
TLINK MAIN.OBJ 

:: YOU HAVE TO SPECIFY THE FILES MANULAAY TILL NOW
:: YOU CAN'T SAY TLINK *.OBJ
:: IF YOU FOUND ANOTHER WAY LET US KNOW

:: Run
MAIN.EXE

:: Clean files Silently you can remove this part
:: completely if you want it is not required
DEL *.MAP
DEL *.OBJ
DEL *.EXE