;AUTHOR : SHEHAB KHALED

;---------------------------------------
.MODEL SMALL
.STACK 32

;---------------------------------------
.DATA

filename db 'filename.bin', 0
buffer_size equ FILE_SIZE
buffer db buffer_size dup(?)

errtext db "YOUR ERROR MESSAGE", 10, "$"

IMAGE_HEIGHT equ ;YOUR HEIGHT
IMAGE_WIDTH equ ;YOUR WIDTH

SCREEN_WIDTH equ 320
SCREEN_HEIGHT equ 200
;---------------------------------------
.code

MAIN PROC FAR
    MOV AX,@DATA
    MOV DS,AX

    mov ah, 03Dh
    mov al, 0 ; open attribute: 0 - read-only, 1 - write-only, 2 -read&write
    mov dx, offset filename ; ASCIIZ filename to open
    int 21h

    jc error_exit       ; Jump if carry flag set (error)

    mov bx, AX
    mov ah, 03Fh
    mov cx, buffer_size ; number of bytes to read
    mov dx, offset buffer ; were to put read data
    int 21h


    ; Check for errors
    jc error_exit       ; Jump if carry flag set (error)

    mov ah, 3Eh         ; DOS function: close file
    INT 21H

    MOV DI,320/2 - IMAGE_WIDTH/2 ;STARTING PIXEL
    CALL drawImage

    MOV AH, 0
    INT 16h

    error_exit:
    mov ah, 9
    mov dx, offset errtext
    int 21h

    MOV AH,4CH
    INT 21H

MAIN ENDP

drawImage PROC

    mov ah,0
    mov al,13h
    int 10h

    PUSH DI
    PUSH DX

    MOV AX, 0A000h 
    MOV ES, AX

    XOR DI, DI
    MOV CX, 320 * 200 ; Total pixels in the screen (320x200)
    MOV AL, 0fH ; Set color to black

    REP STOSB

    POP DX
    POP DI

    MOV SI,offset buffer
    
    MOV DX,IMAGE_HEIGHT

    REPEAT:
    MOV CX,IMAGE_WIDTH
    DRAW_PIXELS:
        ; Check if the byte at [SI] is 250 TO SKIP IT
        mov AH,BYTE PTR [SI]
        CMP BYTE PTR [SI], 250
        JE SKIP_DRAW

        ; Draw the pixel
        MOVSB
        JMP DECC

        SKIP_DRAW:
        INC DI
        INC SI

        DECC:
        DEC CX

        JNZ DRAW_PIXELS

    ADD DI,SCREEN_WIDTH - IMAGE_WIDTH
    DEC DX
    JNZ REPEAT

    RET

drawImage ENDP

     END MAIN

