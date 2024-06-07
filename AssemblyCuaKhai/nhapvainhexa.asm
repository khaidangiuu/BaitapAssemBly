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
    XOR BX, BX ; X�a BX
    MOV CL, 4 ; S? l?n d?ch tr�i BX
    MOV AH, 1 ; H�m nh?p k� t?
    INT 21h ; Nh?p 1 k� t? ? AL = m� ASCII
VongLap:
    CMP AL, 13 ; K� t? v?a nh?p l� Enter?
    JE KetThucLap ; ��ng ? K?t th�c
    CMP AL, '9' ; So s�nh v?i '9'
    JG ChuCai ; L?n hon ? l� ch? c�i hoa
    AND AL, 0Fh ; Kh�ng l?n hon ? d?i ch? s? ra nh? ph�n
    JMP ChenBit ; R?i ch�n v�o cu?i BX
ChuCai:
    SUB AL, 37h ; �?i ch? c�i ra gi� tr? nh? ph�n
ChenBit:
    SHL BX, CL ; D?ch tr�i BX d? d�nh ch? cho c/s m?i
    OR BL, AL ; Ch�n ch? s? m?i v�o 4 bit th?p c?a BX
    INT 21h ; Nh?n ti?p k� t? t? b�n ph�m
    JMP VongLap ; L?p l?i
KetThucLap:      
    MOV CX, 4
    MOV AH, 2
InHexa:
    MOV DL, BH
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    CMP DL, 9
    JA ChuCai
    ADD DL, 30h
    JMP TiepTuc
    
TiepTuc:
    INT 21h
    ROL BX, 1
    ROL BX, 1
    ROL BX, 1
    ROL BX, 1
    LOOP InHexa
    
THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN