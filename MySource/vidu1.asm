.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TieptucSTR DB LF, CR, "Ban co $ tiep tuc khong? (k/K): $" 
    TBao DB  "Hello World!$"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh
    MOV AH, 09H     ;Ham hien chuoi ki tu
    LEA DX, TieptucSTR    ;Lay dia chi chuoi can hien
    INT 21H         ;Hien chuoi

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN