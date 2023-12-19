set_interrupt proc
            
            push ax
            push es
            push bx
            mov ax, 3509h ; Get Interrupt Vector
            int  21h ; -> ES:BX
            mov old_int_offset, bx ; - > save these values
            mov old_int_seg, es
            pop bx
            pop es
            cli ; this is optional
        ; replace the existing int09h handler with ours
            push DS 
            mov dx, offset myint ; new offset 
            mov ax, seg myint ; new segment
            mov ds, ax 
            mov ax, 2509h
            int 21h
            pop ds  
            pop ax
            sti
            ret
set_interrupt endp
;-----------------------------------------------------;
ret_interrupt proc
              cli
              push ax
              push ds
              push dx
              mov dx,old_int_offset ; the offset of the old interrupt IMPORTANT: make sure this is done before the ds because it will cause crashes
              mov ds,old_int_seg
              mov ax, 2509h ; interrupt to set your interrupt handler
              int 21h
              pop dx
              pop ds    
              pop ax
              sti
              ret
ret_interrupt endp
; ------------------ MY Own handler ------------------;
myint proc          ;  my keyboard interrupt handler 
    push bx
    in   al, 60h ; listen from port 60h
    mov  ah, 0
    mov  bx, ax
    and  bx, 127           ; 7-bit scancode goes to BX
    shl  ax, 1             ; 1-bit pressed/released goes to AH
    xor  ah, 1             ; -> AH=1 Pressed, AH=0 Released
    mov  [KeyList + bx], ah
    mov  al, 20h           ; The non specific EOI (End Of Interrupt)
    out  20h, al
    pop  bx 
    iret
myint endp