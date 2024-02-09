# Serial Port Programming

& everything related

## 📖 What we will look into

- what programs makes the simulation on both Linux and Windows
- How to compile and what is the preferred workflow when running the 2 windows in the same computer

## 🎲 Programs

To start the serial communication we must simulate the com communication ports in our device using a program

- Windows
  - [Virtual COM Port Driver: create virtual COM ports in a system](https://www.virtual-serial-port.org/) - lasts for 14 days only (free trial)
  - [Free Virtual Serial Ports](https://freevirtualserialports.com/) - free alternative - less features
- Linux
  - Socat: `sudo apt-get install socat` - to install

```bash
socat -d -d pty,raw,echo=0 pty,raw,echo=0
```

output:

```bash
2024/02/09 19:52:51 socat[1000160] N PTY is /dev/pts/1
2024/02/09 19:52:51 socat[1000160] N PTY is /dev/pts/2
2024/02/09 19:52:51 socat[1000160] N starting data transfer loop with FDs [5,5] and [7,7]
```

notice: the output is pts/1 and pts/2, it may be different in your case and we will use them in the script

## 🔥 Fastest way to test

- open the virtual com port program and create 2 ports
- open your projects 2 times
  - in VS code, right click and run in emulator (check other compiling tutorials)
- in the first window, use the first script which compiles the code and runs and tells dosbox to use the first port
- in the second window, use the second script which compiles the code and runs and tells dosbox to use the second port
  and viola, you have 2 windows communicating with each other

Scripts:

```bash
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

make 2 of this script and change the port name run different script in each window.

ps: you can test with the given files.
