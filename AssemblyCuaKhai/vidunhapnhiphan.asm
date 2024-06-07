.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TB1 DB "Moi ban nhap ki tu (0 hoac 1): $" 
    TB2 DB LF, CR, "So ban vua nhap la: $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh   
    MOV AH, 09H
    LEA DX, TB1
    INT 21H
    
    XOR BX, BX      ; xoa BX
    MOV AH, 1       ; ham nhap 1 ki tu
    INT 21H         ; nhap ki tu    
NhapKyTu:
    CMP AL, 13      ; la phim enter
    JE DungNhap     ; dung => ket thuc nhap
    AND AL, 0Fh     ; sai => doi ra gia tri nhi phan
    SHL BX, 1       ; danh cho nay cho bit moi tim duoc
    OR BL, AL       ; chen bit nay vao cuoi bx
    INT 21H         ; nhap tiep ki tu khac
    JMP NhapKyTu    ; lap lai
DungNhap:   
    MOV AH, 09H
    LEA DX, TB2
    INT 21H   
    
    MOV CX, 16
    MOV AH, 2
Print:
    ROL BX, 1
    MOV DL, 0
    ADC DL, 30H
    INT 21H
    LOOP Print

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN