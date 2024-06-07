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
    MOV AH, 2       ; Chuan bi hien thi
    ; if AL<=BL
    CMP AL, BL      ;AL<=BL?
    JNBE ELSE_      ; neu khong, hien thi ki tu trong BL
    ;then           ; AL<=BL
    MOV DL, AL      ; chuyen vao ki tu DL de hien thi
    JMP DISPLAY     ; toi display
ELSE_:
    MOV DL, BL      ; chuyen ki tu vao DL de hien thi
DISPLAY:
    INT 21H         ; hien thi no

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN