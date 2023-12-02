; A simple program to check for multiple key presses
; The program infinitly prints the values of flag1 and flag2


.model small
.stack 100h
.data
    flag1 db 'n'
    flag2 db '0'
.code
main proc
    mov ax, @data ; set data segment
    mov ds, ax

    readkey: ; label used for infinit loop
        
    ; al hold the scan code of the pressed or released key
    in al, 60h ; read scan code

    ; end the program when pressing the esc key
    cmp al, 1h
    jz kill

    ; check for the up arrow key
    cmp al, 48h       ; the scan code for pressing the up arrow key
    jnz not_pressed
    mov flag1, 'y'
    not_pressed:
    cmp al, 48h + 80h ; the scan code for releasing the up arrow key
    jnz not_release
    mov flag1, 'n'
    not_release:

    ; check for the w key
    cmp al, 11h       ; the scan code for pressing the w key 
    jnz not_pressed2
    mov flag2, '1'
    not_pressed2:
    cmp al, 11h + 80h ; the scan code for releassing the w key
    jnz not_release2
    mov flag2, '0'
    not_release2:

    ; print the content of flag1 and flag2
    mov ah, 2h
    mov dl, flag1
    int 21H
    mov dl, flag2
    int 21H

    jmp readkey ; loop until the program is terminated

    kill:
    mov ah, 4CH
    int 21H
main endp
end main
