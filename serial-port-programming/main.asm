;This is a macro to clear the upper half of the screen when it's compleltely full of charachters
clearUpper MACRO
   
mov ax,060Dh
mov bh,04h
mov ch,0       
mov cl,0       
mov dh,12    
mov dl,79
int 10h 
  
ENDM clearUpper 
;-----------------------------------------------------------------------------------------------
;This is a macro to clear the lower half of the screen when it's compleltely full of charachters

clearLower MACRO
   
mov ax,060Ch
mov bh,40h
mov ch,13     
mov cl,0        
mov dh,24    
mov dl,79 
int 10h 
  
ENDM clearLower
;--------------------------------------------------------------------------------------------------
;this is a macro to get the cursor position of the send mode in dx "we need to save the cursor position every time we go to revieve mode or send mode"
saveCursorS MACRO
mov ah,3h
mov bh,0h
int 10h
mov xposS,dl
mov yposS,dh
ENDM saveCursorS  
;---------------------------------------------------------------------------------------------------
;this is a macro to get the cursor position of the recieve mode in dx "we need to save the cursor position every time we go to revieve mode or send mode"
saveCursorR MACRO
mov ah,3h
mov bh,0h
int 10h
mov xposR,dl
mov yposR,dh
ENDM saveCursorR 
;----------------------------------------------------------------------------------------------------
;this is a macro to set the cursor in the right position
setCursor MACRO x,y
mov ah,2
mov bh,0
mov dl,x
mov dh,y
int 10h
ENDM setCursor

;-----------------------------------------------------------------------------------------------------
.MODEL SMALL
.STACK 64
.DATA
 
value db ?     ;value which will be sent or recieved by user
yposS db 0     ;y position of sending initial will be 0
xposS db 0     ;x position of sending initail wiil be 0
xposR db 0     ;x position of recieving initial will be 0
yposR db 0Dh   ;y position of recieving initial wil be D because of lower part of screen                                          

.CODE

main proc far
     mov ax,@data
     mov ds,ax
     
; set divisor latch access bit

mov dx,3fbh 			; Line Control Register
mov al,10000000b		;Set Divisor Latch Access Bit
out dx,al

;Set LSB byte of the Baud Rate Divisor Latch register.

mov dx,3f8h			
mov al,0ch			
out dx,al

;Set MSB byte of the Baud Rate Divisor Latch register.

mov dx,3f9h
mov al,00h
out dx,al

;Set port configuration
mov dx,3fbh
mov al,00011011b
out dx,al     

;spliting screen to two halfs

   mov ah, 0      ;open text mode
   mov al, 3
   int 10h
   
   mov ah,6       ; function 6
   mov al,0       ; scroll by 1 line    
   mov bh,04h     ; normal video attribute         
   mov ch,0       ; upper left Y
   mov cl,0       ; upper left X
   mov dh,12      ; lower right Y
   mov dl,79      ; lower right X 
   int 10h           


   mov ah,6        ; function 6
   mov al,0        ; scroll by 1 line    
   mov bh,40h      ; normal video attribute         
   mov ch,13       ; upper left Y
   mov cl,0        ; upper left X
   mov dh,24       ; lower right Y
   mov dl,79       ; lower right X 
   int 10h      



;start sending and recieving
call detect

detect proc

progloop:

mov ah,1    ;check if a key is pressed
int 16h
jz dummy2   ; if not then jmp to recieving mode
jnz send    ;if yes jmp to send mode



send:

mov ah,0   ;clear the keyboard buffer
int 16h 

mov value,al  ; save the key ascii code in al
CMP al,0Dh    ; check if the key is enter
jnz cont
jz newline
;----------------------------
dummy2:jmp recieve
;----------------------------

newline:
CMP yposS,12   ;check first about if y position in 12 then the enter must do the same as clear the screen 
jz  XS
jnz YS
XS:clearUpper
mov xposS,0             ;set the cursor manually to 0,0
mov yposS,0
setCursor xposS,yposS
jmp print
 
YS:inc yposS     ;if enter go to the next line so we need to change the position of x,y manually then call the macro of setting cursor
mov xposS,0

cont:
setCursor xposS,yposS  ; setting the cursor
CMP xposS,79           ; if the x goes to 79 the most right of screen check where is y
JZ checkY
jnz print

checkY:CMP yposS,12    ;if y goes to the lower bound of the first half of the screen go to clear the upper half of screen
JNZ print
clearUpper
mov xposS,0             ;set the cursor manually to 0,0
mov yposS,0
setCursor xposS,yposS

jmp print               ; if none of the above happened then go to print the char on the user screen
 


print:mov ah,2          ; printing the char
mov dl,value
int 21h
  
mov dx,3FDH 		; Line Status Register
AGAIN:In al , dx 	;Read Line Status
test al , 00100000b
jz recieve                    ;Not empty
mov dx , 3F8H		; Transmit data register
mov al,value        ; put the data into al
out dx , al         ; sending the data
CMP al,27           ; if the key was esc terminate the programe and this check must be after the send is done
JZ dummy
saveCursorS         ; we need to save the cursor here 
jmp progloop        ; loop again

dummy:jmp exit

dummy3:jmp send


recieve:
mov ah,1            ;check if there is key pressed then go to the sending mode
int 16h
jnz dummy3

mov dx , 3FDH		; Line Status Register
in al , dx 
test al , 1
JZ recieve           


mov dx , 03F8H
in al , dx 
mov value,al              ;check if the recieved data is sec key then terminate the programe 
CMP value,27
JZ  dummy

CMP value,0Dh             ;check if the key is enter
JNZ contR
JZ newlineR


newlineR:
cmp yposR,24
JZ XR
jnz YR
XR:
clearLower
mov xposR,0
mov yposR,0Dh
setCursor xposR,yposR
jmp printR

YR:
inc yposR
mov xposR,0

contR:
setCursor xposR,yposR
CMP xposR,79
JZ checkYR
jnz printR

checkYR: cmp yposR,24
jnz printR
clearLower
mov xposR,0
mov yposR,0Dh
setCursor xposR,yposR

printR:mov ah,2
mov dl,value
int 21h

saveCursorR

jmp progloop

           
             
detect endp



exit:
mov ah, 4ch
int 21h
main endp

end main