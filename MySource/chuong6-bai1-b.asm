.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TieptucSTR DB LF, CR, "Ban co tiep tuc khong? (k/K): $" 
    Hello DB LF, CR, "XIN CHAO: $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh
    ; Vi du cho AL lon hon 0
    MOV AL, 2   
    ; if AL<BL
    CMP AL, 0       ;AL<0?
    JNL ELSE_       ; neu khong, nhay sang else
    ;then           ; AL<BL
    MOV AH, 0FFH    ; AH=0FFh
    JMP DISPLAY     ; toi display
ELSE_:
    MOV AH, 0      ; AH=0
DISPLAY:
    INT 21H         ; hien thi no 
    ; Ket qua chuong trinh AH=0

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN