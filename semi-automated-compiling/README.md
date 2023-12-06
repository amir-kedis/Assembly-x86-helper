# Semi Automated Compiling and running in VSCODE

This guide is for how to facilate the compiling and running of your x86 program as it can get quite tedious to do it manually.
I will use BAT script to automate the process.

## Prerequisites

Before doing this part I assume that you read the [linking multiple files](../linking-multiple-files/README.md) guide. As what we will do now is just automate a part of it.

## Script functions

1. Clean all the .EXE .MAP .OBJ files in the current directory
2. Compile all the .ASM files in the current directory
3. Link ONLY FILES that you specify in the script. (This is the limitation of the script).
4. Run the .EXE file
5. Clean after the program is done running.

## To use the script

1. Open your root code folder in VSCODE (The folder that contains all your .ASM files)
2. Copy the run.bat file into the root code folder.
3. Make sure that in your vscode settings the dosbox copies the whole workspace folder. (If not sure about this check the [linking multiple files](../linking-multiple-files/README.md) guide)
4. Right Click and `open in emulator`
5. type `run` in dosbox and press enter.
6. And voila! Your program is running.

## Current limitations

You have to edit the script just because you cant do this

```bat
TLINK *.OBJ
```

You have to specify the files that you want to link. This is because the TLINK command does not support wildcards. (If you know how to do this please tell me)

### You can try to run this demo if you want make sure to `cd` to the directory where the .asm and .bat files are located.

## The script

```bat
:: =========================================================
:: Author: Amir Anwar
:: This is a batch file to compile and run x86 assembly code
:: =========================================================

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
TLINK MAIN.OBJ STRPROC.OBJ

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
```
