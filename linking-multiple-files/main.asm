; Author:       George magdy
; Date:         2 Dec 2023
; Title:        Linking multiple files in dsobox and vscode

EXTRN print: FAR            ; signal that the print proc is not defined here
PUBLIC msg                  ; make the msg available to other modules/files

.model small
.stack 64
.data
    msg db "Hey CMP26$"
.code

main PROC
    mov ax, @data
    mov ds, ax

    call print

    mov ax, 4c00h
    int 21h    
main ENDP
end main