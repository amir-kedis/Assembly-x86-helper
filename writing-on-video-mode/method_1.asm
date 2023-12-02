
.model small
.stack 64
.data
mes db 'lw l8yt 7agh wrong ab8a 8wly ya bro$' 
.code 
showmes macro str
    mov ah,09h
    lea dx,str
    int 21h  
endm showmes    

showchar macro str
    mov ah,02h
    mov dl,str
    int 21h  
endm showchar 

main proc   

mov ax,@data
mov ds,ax  


;--------------------------------MODE 13H-------------------------------------;
mov ah,0          ;Change video mode (Graphical MODE)
mov al,13h        ;Max memory size 16KByte
                  ;AL:4 (320*200=64000 [2 bits for each pixel,4 colours])
                  ;AL:6 (640*200=128000[1 bit  for each pixel,2 colours B/W])
int 10h
;---------------------------------------Screen Coloring------------------------------------------------;
    mov ax ,0600h
    mov bh,09h
    mov cx,0h
    mov dx , 184fh
    int 10h

;--------------------------Writing Character Number of times-------------------;
mov ah,9          ;Display
mov bh,0          ;!Page does not work here like normal text mode so leave it 0 so that i work properly (noticed this by testing)
mov al,44h        ;Letter D
mov cx,5d        ;5 times
mov bl,0Bh       ;?colors are diffrent from text mode 
                 ;*1. no background color 
                 ;*2.format are diffrent the value will be for text coloring only 
                 ;*3.check this link for available colors https://en.wikipedia.org/wiki/BIOS_color_attributes
int 10h
;---------------------------You can move the cursor-------------------;
mov ah,2           
mov dl,34 ;*1.the row can write up to 40 characters one character takes 8 pixles
mov dh,24 ;*2.so the screen is 40*24 char  (24 by testing)
int 10h                

mov ah,9          ;Display
mov bh,0          ;Page 0
mov al,44h        ;Letter D
mov cx,6h         ;5 times
mov bl,9h        
int 10h
;---------------------------Display String and Single Char-------------------;   

mov ah,2           
mov dl,2 
mov dh,12 
int 10h  

;?As for as i know you can't color this text in this two cases 

showmes mes 

mov ah,2           
mov dl,2 
mov dh,13 
int 10h  

showchar 'a' 


;! if you chnage the mode to  6 or 4 the colors will change from above as will as the dimensions
;! you can follow the same pattern and test them


MOV    AH,0                   ; Waite for key press
INT    16H

MOV    AH,4CH
INT    21H                    ;back to dos          
        
main endp 

end main 


