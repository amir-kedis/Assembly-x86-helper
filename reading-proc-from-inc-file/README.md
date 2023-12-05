## <h1 style="text-align: center;">Calling a Procedure from an inc file</h1>  
The include command in assembly, replaces the the line of the command with the content of the file to be included; so in order to call a procedure which is inside an **'inc'**, we simple call the include command inside the code segment.

## Code example
### Proc in a .inc file
``` assembly
; insdie a .inc file called proc.inc

myproc proc far
  ; the code of the procedure
myproc endp
```
### Including the .inc file and calling the proc in an asm file
``` assembly
.model small
.stack 64
  ; variables
.code
include proc.inc

main proc far
  ; some code

  call myproc

  ; some other code
main endp
end main
```