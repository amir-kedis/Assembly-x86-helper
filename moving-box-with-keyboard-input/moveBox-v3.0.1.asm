;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Author: Amir Anwar         ;;
;;      CoAuthor: George Magdy       ;;
;;        Date:  25/11/2023          ;;
;;        Title: Moving BOX          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.386 ; 80386 ` 32-bit
DATA SEGMENT USE16                              ; Equivalent to .data in 32-bit ; Doctor Allowed using .386

  ; Screen Info
  SCREEN_WIDTH  EQU 320
  SCREEN_HEIGHT EQU 200
  SCREEN_SIZE   EQU SCREEN_WIDTH*SCREEN_HEIGHT

  ; Color Info
  COLOR_BLACK   EQU 0
  COLOR_WHITE   EQU 15
  BOX_COLOR     DB  45                          ; You can choose any color between 0 and 255

  ; Box Info
  BOX_SIZE      EQU 20
  boxX          dw  ?
  boxY          dw  ?


DATA ENDS                                       ; It must be ended unlike .data in 32-bit

CODE SEGMENT USE16                                          ; Equivalent to .code in 32-bit
                     ASSUME CS:CODE,DS:DATA                 ; To tell him to replace .data and .code with CODE and DATA
  BEG:                                                      ; MUST BE BEG (DON'T KNOW WHY YET)
  ;MOV    AX,DATA
  ;MOV    DS,AX ; Seems to be completely unnecessary
  ; ASSUME DS:DATA does the same thing

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CODE STARTS HERE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; Set Video Mode (320x200 256 colors)
                     MOV    AX,13H
                     INT    10H
  
  ; Set Box Position to the top left square ;* tweaked
                     MOV    boxX, 0
                     MOV    boxY, 0

  ; Clear the screen
                     call   clearScreen                     ; Loops and procedures can be called its just pusha and jmp and allows you to use ret

  ; Draw the box
                     call   drawBox

  ; MAIN LOOP
  mainLoop:          
  ; wait for a key press
                     mov    ah, 00h
                     int    16h                             ; wait for key press - store key in ah

  ; Handle arrow keys (ah stores the scan code of the key not the ASCII code)
                     cmp    ah, 48h                         ; up arrow
                     je     moveUp
                     cmp    ah, 50h                         ; down arrow
                     je     moveDown
                     cmp    ah, 4bh                         ; left arrow
                     je     moveLeft
                     cmp    ah, 4dh                         ; right arrow
                     je     moveRight

                     cmp    ah, 13h                         ; R key
                     je     changeClrToRed
                     cmp    ah, 22h                         ; G key
                     je     changeClrToGreen
                     cmp    ah, 11h                         ; W key
                     je     changeClrToWhite
                     cmp    ah, 39h                         ; space key
                     je     changeClrToNextClr


                     cmp    ah, 01h                         ; escape
                     je     exit

                     jmp    mainLoop                        ; keep looping

  moveUp:            
  ;* check top border
                     cmp    boxY, 0
                     je     mainLoop

                     sub    boxY, BOX_SIZE
                     call   clearScreen
                     call   drawBox
                     jmp    mainLoop
  
  moveDown:          
  ;* check bottom border
                     cmp    boxY, SCREEN_HEIGHT - BOX_SIZE
                     je     mainLoop
               
                     add    boxY, BOX_SIZE
                     call   clearScreen
                     call   drawBox
                     jmp    mainLoop
  
  moveLeft:          
  ;* check left border
                     cmp    boxX, 0
                     je     mainLoop
               
                     sub    boxX, BOX_SIZE
                     call   clearScreen
                     call   drawBox
                     jmp    mainLoop

  moveRight:         
  ;* check right border
                     cmp    boxX, SCREEN_WIDTH - BOX_SIZE
                     je     mainLoop
               
                     add    boxX, BOX_SIZE
                     call   clearScreen
                     call   drawBox
                     jmp    mainLoop

  changeClrToRed:    
                     mov    BOX_COLOR, 4
                     call   drawBox
                     jmp    mainLoop

  changeClrToGreen:  
                     mov    BOX_COLOR, 2
                     call   drawBox
                     jmp    mainLoop
  
  changeClrToWhite:  
                     mov    BOX_COLOR, 15
                     call   drawBox
                     jmp    mainLoop
  
  changeClrToNextClr:
                     mov    al, BOX_COLOR
                     inc    al
                     mov    BOX_COLOR, al
                     call   drawBox
                     jmp    mainLoop

  drawBox:                                                  ; (Imagine it as a Procedure)
  ; summary: draws a box at the given position (boxX, boxY)
  ;          with the given size (BOX_SIZE)
  ;          and the given color (BOX_COLOR)

  ; write the color to the video memory
                     mov    ax, 0A000h
                     mov    es, ax

  ; get the start of the row
                     mov    di, boxY
                     imul   di, SCREEN_WIDTH                ; di = boxY * SCREEN_WIDTH (two operand multiplication)
                     add    di, boxX

  ; counters
                     mov    cx, BOX_SIZE
                     mov    dx, SCREEN_WIDTH - BOX_SIZE

  drawBoxRow:        
                     push   cx
                     mov    cx, BOX_SIZE
  drawBoxPixel:      
                     mov    bl, BOX_COLOR
                     mov    byte ptr es:[di], bl
                     inc    di
                     loop   drawBoxPixel

                     add    di, dx
                     pop    cx
                     loop   drawBoxRow

                     ret                                    ; return from the procedure (return to the caller - pop flags and ip)
  

  clearScreen:       
  ; summary: clears the screen by setting all pixels to black
                     mov    ax, 0A000h
                     mov    es, ax                          ; set the video segment

                     mov    di, 0
                     mov    cx, SCREEN_SIZE                 ; set the counter to the screen size
                     mov    al, COLOR_WHITE                 ; set the color to black
                     rep    stosb
                     ret

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  exit:                                                     ; exit the program
                     MOV    AH,4CH
                     INT    21H                             ;back to dos
CODE ENDS
END BEG