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
    XOR BX, BX ; Xóa BX
    MOV CL, 4 ; S? l?n d?ch trái BX
    MOV AH, 1 ; Hàm nh?p kí t?
    INT 21h ; Nh?p 1 kí t? ? AL = mã ASCII
VongLap:
    CMP AL, 13 ; Kí t? v?a nh?p là Enter?
    JE KetThucLap ; Ðúng ? K?t thúc
    CMP AL, '9' ; So sánh v?i '9'
    JG ChuCai ; L?n hon ? là ch? cái hoa
    AND AL, 0Fh ; Không l?n hon ? d?i ch? s? ra nh? phân
    JMP ChenBit ; R?i chèn vào cu?i BX
ChuCai:
    SUB AL, 37h ; Ð?i ch? cái ra giá tr? nh? phân
ChenBit:
    SHL BX, CL ; D?ch trái BX d? dành ch? cho c/s m?i
    OR BL, AL ; Chèn ch? s? m?i vào 4 bit th?p c?a BX
    INT 21h ; Nh?n ti?p kí t? t? bàn phím
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