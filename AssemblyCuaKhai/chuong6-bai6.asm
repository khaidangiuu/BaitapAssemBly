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
    ; khoi tao cac bien
    MOV CX, 0       ; tich   
    MOV AX, 2       ; M=2
    MOV BX, 4       ; N=4
REPEAT:
    ADD CX, AX      ; cong M vao tich so
    DEC BX          ; giam N
UNTIL:
    CMP BX, 0       ; So sanh N=0
    JNE REPEAT      ; Sai => Lap lai

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN