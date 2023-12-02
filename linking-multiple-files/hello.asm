EXTRN msg: FAR              ; msg is not defined here
PUBLIC print                ; make this proc available

.model small
.code
; just prints the stored value in msg till the $
print PROC
    mov dx, offset msg
    mov ah, 9
    int 21h
    ret                     ; important
print ENDP
end print                   ; solves: unexpected end of file encountered