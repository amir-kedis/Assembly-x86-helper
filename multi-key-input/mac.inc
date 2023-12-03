showmes macro str
    mov ah,09h
    lea dx,str
    int 21h  
endm   

moveCursor macro x, y
    mov dl, x
    mov dh, y
    mov ah, 2H
    int 10h  
endm