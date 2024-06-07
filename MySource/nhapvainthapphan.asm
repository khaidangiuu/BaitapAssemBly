.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    Tbao1 DB LF, CR, "Moi nhap vao so thap phan: $" 
    Tbao2 DB LF, CR, "So vua nhap la: $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh 
    MOV AH, 09H
    LEA DX, Tbao1
    INT 21H
    CALL NHAP10 
    
    MOV AH, 09H
    LEA DX, TBAO2
    INT 21H
    CALL IN10

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP 
; Nhap mot so thap phan
; Vao: khong
; Ra: AX
NHAP10 PROC
    PUSH AX
Lai:
    XOR BX, BX
    MOV AH, 1
Lap:
    INT 21H
    CMP AL, 0DH ;13
    JE KetThucLap
    CMP AL, '0'
    JB Lai
    CMP AL, '9'
    JA Lai
    AND AX, 0FH
    PUSH AX
    MOV AX, 10
    MUL BX
    POP BX
    ADD BX, AX
    MOV AH,1 
    JMP Lap
KetThucLap:
    POP AX
    RET
NHAP10 ENDP
; in ra so thap phan
; Vao: AX
; Ra; khong
IN10 PROC
    XOR CX, CX
    MOV BL, 10
Tiep:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    OR AX, AX
    JNE Tiep
    MOV AH, 2
Print:
    POP DX
    OR DX, 30H
    INT 21H
    LOOP Print
    RET
IN10 ENDP
END MAIN 
