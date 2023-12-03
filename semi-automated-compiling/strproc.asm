;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               Author:  Amir Anwar                 ;;
;;               Date:    03/12/2023                 ;;
;;                    strproc.asm                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUBLIC PrintDigit
.386
DATA SEGMENT USE16

DATA ENDS
CODE SEGMENT USE16

  ;Prints a single digit to the screen
  ;Input: AL = digit to print
PrintDigit PROC
             MOV AH, 02h  ; Print character
             ADD AL, 30h  ; Convert to ASCII
             MOV DL, AL   ; Move to DL
             INT 21h      ; Print

             RET          ; Return
PrintDigit ENDP

CODE ENDS
END PrintDigit