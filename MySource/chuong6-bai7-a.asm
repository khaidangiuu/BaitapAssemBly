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
    MOV AH, 1       ; ham nhap 1 ki tu
    MOV CX, 80      ; lap lai toi da 80 lan
DocKiTu:
    INT 21h         ; nhap 1 ki tu
    CMP AL, 32     ; so sanh voi khoang trang
    LOOPE DocKiTu    ; lap lai neu chua du 80 ki tu
THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN