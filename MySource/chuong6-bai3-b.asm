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
    MOV AX, 0       ; khoi tao bien AX=0 de tinh tong
    MOV CX, 100     ; khoi tao bien CX=100 de bat dau voi so dau tien
    MOV DX, 5       ; khoi tao bien DX=5 de lam dk dung
LOOP_:
    ADD AX, CX      ; cong so hien tai cua day vao tong AX
    SUB CX, 5       ; Giam gia tri CX xuong 5 de chuyen sang so tiep theo trong day
    CMP CX, DX      ; so sanh so hien tai voi 5
    JGE LOOP_       ; neu CX >= 5 thi tiep tuc vong lap
    JMP THOAT       ; neu CX < 5 thi thoat

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN