#  Linking multiple files in dosbox and vscode
## Prerequisites
1. Create a folder and open <i>this folder</i> in vscode
2. Install MASM/TASM<br>
3. Open the extension's settings and change<br>
DOS environment emulator : <b>DOSBOX</b> <br>
Masmtasm.ASM: Mode <b> WORKSPACE</b>

## Common errors & quick fixes
* unresolved external : don't forget EXTRN (without E) & PUBLIC
* unexpected end of file encountered: don't forget END main & END \<proc_name>
* missing segment

## Run

The steps are simple:<br>
1. Right click on a file -> open Emulator
2. check that the mounted folder is correct
```cmd
dir
```
when executing this ☝ you should see the asm files you just wrote in this folder, <br>
if not, please open vscode in this folder and try again<br> 

3. Assemble all files using masm/tasm
```
tasm *.asm
```

4. link 
```
link main.obj+file1.obj+file2.obj...
```
5. When prompted, give the file a name: for example 'game'
then press enter a few times
```
Run File[main.exe]: game
```
6. Type that name you just gave to the file and press enter. congratulations
```
game
```
### Video:
<a href="https://drive.google.com/file/d/1l-RGUmo9k0g7NOWlr9L35E1jCDhEQL4u/view?usp=drive_link
">Simple video demo</a>
