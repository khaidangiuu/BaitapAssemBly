.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    matkhau DB 5 DUP('X'), "$"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh 
    MOV AH, 0AH     ; ham nhap 1 chuoi ki tu 
    LEA DX, matkhau
    INT 21H         ; bat dau nhap 5 ki tu
    MOV AH, 02H     ; Ham hien thi 1 ki tu
    MOV DL, CR
    INT 21H         ; Ve dau dong
    
    MOV CX, 5
    MOV AH, 02H     ; ham hien thi 1 ki tu
    MOV DL, 'X'
    loop_print:
    INT 21H         ; hien thi ki tu 'X'
    LOOP loop_print ; lap lai 5 lan do da cho CX=5

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN