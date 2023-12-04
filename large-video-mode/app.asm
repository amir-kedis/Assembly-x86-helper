;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               Author: Amir Anwar               ;;
;;               Date: 04/12/2023                 ;;
;;              Heavely inspired by:              ;;
;;                 Fe Lfda Sawa                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.386
.MODEL COMPACT
.STACK 4096
DATA SEGMENT USE16

  
     ; SCREEN INFO
     VIDEO_MODE    EQU 4F02h     ; SVGA MODE
     VIDEO_MODE_BX EQU 0101h     ; SCREEN SIZES
     ; AVILABLE MODES
     ; https://en.wikipedia.org/wiki/VESA_BIOS_Extensions
     ; 0100h => 640x400x256 =>> RECOMMENDED
     ; 0101h => 640X480x256 =>> RECOMMENDED WITH CAUTION
     ; ... UP TO
     ; 0107h => 1280x1024x256 ; Be careful with large sizes as they require 32bit pointers 

     SCREEN_WIDTH  EQU 640   
     SCREEN_HEIGHT EQU 480

     BG_COLOR      EQU 1h        ; BLACK

DATA ENDS
CODE SEGMENT USE16
                ASSUME CS:CODE,DS:DATA
     BEG:       
                MOV    AX,DATA
                MOV    DS,AX
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
     ; Set video mode
                MOV    AX,VIDEO_MODE
                MOV    BX,VIDEO_MODE_BX
                INT    10h                   ; Set video mode

     ; Clear Screen
                MOV    AH, 0Bh               ; Function 0Bh = Clear screen
                MOV    BH, 00h               ; Page number
                MOV    BL, BG_COLOR          ; Background color
                INT    10h                   ; Call video interrupt

                MOV    CX, SCREEN_WIDTH
                MOV    DX, SCREEN_HEIGHT

     ; THE FOLLOWING CODE IS COPIED FROM
     ; the Fe Lfda Sawa project
     ; Don't ask me how it works
     ; I don't know

     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                jmp    Start                 ;Avoid drawing before the calculations
     Drawit:    
                MOV    AH,0Ch                ;set the configuration to writing a pixel
                push   bx
     ; next 6 lines to make the pattern darker
                cmp    bl, 32
                jb     DontDarken
                cmp    bl, 175
                ja     DontDarken
                add    bl, 72
     DontDarken:
                MOV    AL, bl                ;choose white as color
                MOV    BH,00h                ;set the page number
                pop    bx
                INT    10h                   ;execute the configuration
     Start:     
                mov    AX, 0                 ;  |
                mov    AL, DL                ;  |  > Multuply DL*Dl and Store in AX then BX
                Mul    DL                    ;  |
                mov    bx, AX                ;  |
                mov    AL, CL                ;  \
                Mul    CL                    ;  \   > Multuply CL*Cl and Store in AX


     ;/////////////THIS LINE CHOOSES THE PATTERN TO BE DRAWN\\\\\\\\\\\\\\\\\\\\\\\\\\\\
     ;Xor bx, AX     ;  Relation between DL^2 and CL^2, Sub : X2-Y2 = Hyberbolic Patterns, Add: X2+Y2 = Circular, OR/AND: Rectangular, Xor: Diagonal
     ;SUB BX, AX
     ;ADD BX, AX
     OR BX, AX
        
                DEC    CX                    ;  loop iteration in x direction
                JNZ    TRY                   ;  check if we can draw current x and y and excape the y iteration
                mov    CX, 640               ;  if loop iteration in y direction, then x should start over so that we sweep the grid
                DEC    DX                    ;  loop iteration in y direction
                JZ     ENDING                ;  both x and y reached 00 so end program
     TRY:       Sub    BX, 70E4h
                Jp     Drawit                ;js for quarter circle, also parity produces patterns (in addition to formula pattern)
                jmp    Start                 ; loop
     ENDING:    

     ; Wait for key press
                MOV    AH, 00h               ; Function 00h = Wait for key press
                INT    16h                   ; Call keyboard interrupt

                MOV    AH,4CH
                INT    21H                   ;back to dos
CODE ENDS
END BEG