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
    ; Khoi tao cac bien
    MOV CX, 0       ; thuong   
    MOV AX, 9       ; so bi chia
    MOV BX, 3       ; so chia
WHILE_:
    CMP AX, BX      ; so sanh so bi chia >= so chia
    JL END_WHILE    ; sai -> thoat
    INC CX          ; dung -> tang bo dem cua thuong
    SUB AX, BX      ; tru bot so chia tu so bi chia
    JMP WHILE_      ; lap lai
END_WHILE:

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN