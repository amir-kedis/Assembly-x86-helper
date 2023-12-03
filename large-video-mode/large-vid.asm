;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               Author: Amir Anwar                     ;;
;;               Date:  02/12/2023                      ;;
;;           Purpose:  Large screen size                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.386
DATA SEGMENT USE16

  ; SCREEN INFO
  SCREEN_WIDTH  EQU 1280
  SCREEN_HEIGHT EQU 1024
  SCREEN_SIZE   EQU SCREEN_WIDTH * SCREEN_HEIGHT

  ; Video modes
  VGA_MODE_13H  EQU 13H
  SVGA_MODE_101 EQU 101H
    

  ; Color
  currentColor  dw  0

DATA ENDS
CODE SEGMENT USE16
             ASSUME CS:CODE,DS:DATA
  BEG:       
             MOV    AX,DATA
             MOV    DS,AX

  ; set video mode to 1280x1024x256
             MOV    AX, 4F02H
             MOV    BX,101H
             INT    10H
  
  ; Fill screen with random colors

             MOV    ECX,SCREEN_SIZE   ; 1280*1024 number of pixel
             MOV    DI,0              ; start at 0
             MOV    EAX, 0A000H        ; video memory
             MOV    ES, EAX            ; ES:DI = 0A000:0000



            ; wait for key press
              MOV    AH,0
              INT    16H


       

             MOV    AH,4CH
             INT    21H               ;back to dos
CODE ENDS
END BEG