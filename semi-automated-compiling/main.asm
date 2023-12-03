;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               Author:  Amir Anwar                 ;;
;;               Date:    03/12/2023                 ;;
;;                    MAIN.ASM                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EXTRN PrintDigit:PROC
.386
DATA SEGMENT USE16

     ; SCREEN CONSTANTS
     SCREEN_WIDTH  EQU 80
     SCREEN_HEIGHT EQU 25

DATA ENDS
CODE SEGMENT USE16
          ASSUME CS:CODE,DS:DATA
     BEG: 
          MOV    AX,DATA
          MOV    DS,AX

     ; Clear screen
          MOV    AH,0
          MOV    AL,3
          INT    10H                        ; clear screen

     ; Set cursor position to center of screen
          MOV    AH,2                       ; set cursor position
          MOV    BH,0                       ; page number
          MOV    DH,SCREEN_HEIGHT/2         ; row
          MOV    DL,SCREEN_WIDTH/2 - 5     ; column
          INT    10H

          MOV    AL, 0                      ; char to print
          CALL   PrintDigit
          MOV    AL, 2                      ; char to print
          CALL   PrintDigit
          MOV    AL, 6                      ; char to print
          CALL   PrintDigit

     ; Wait for key press
          MOV    AH,1                       ; wait for key press
          INT    21H

          MOV    AH,4CH
          INT    21H                        ;back to dos
CODE ENDS
END BEG