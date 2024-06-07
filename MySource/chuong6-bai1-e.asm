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
    ; Khai bao cac bien AX, BX, CX
    MOV AX, 2
    MOV BX, 3 
    MOV CX, 4
    CMP AX, BX     ; AX<BX
    JL THEN       ; dung, chuyen den hien thi ki tu
    CMP BX, CX     ; BX<CX
    JL THEN        ; dung, chuyen den hien thi ki tu
    JMP ELSE_       ; sai, ket thuc chuong trinh
THEN:
    MOV DX, 0       ; DX = 0
    JMP THOAT      ; va thoat ra
ELSE_:
    MOV DX, 1       ; DX = 1

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN