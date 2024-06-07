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
    ;MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh
    ; khai bao cac bien
    MOV AX, 5
    MOV BX, 3
    MOV CX, 2
    CMP AX, BX      ; SO SANH AX<BX
    JL THEN         ; Dung thi chuyen sang Then de thuc hien cong viec
    CMP BX, CX      ; so sanh BX<CX
    JL ELSE_        ; Dung => chuyen sang cong viec tiep theo
    MOV CX, 0       ; Sai => CX=0
    JMP THOAT       ; END_IF
THEN:
    MOV AX, 0       ; Neu AX<BX => AX=0
    JMP THOAT       ; Thoat 
ELSE_:
    MOV BX, 0       ; Neu BX<CX => BX=0
    JMP THOAT       ; thoat

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN