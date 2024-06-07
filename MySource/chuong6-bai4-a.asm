.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh  
    MOV CX, 50   ; dat CX bang so luong phan tu
    MOV AX, 1    ; dat AX bang phan tu dau tien
    MOV DX, 0    ; dat DX=0 de tinh tong
LOOP_:
    ADD DX, AX   ; them ptu hien tai vao tong
    ADD AX, 4   ; tang gia tri cua ptu hien tai
    LOOP LOOP_   ; lap lai cho tat ca cac phan tu

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN