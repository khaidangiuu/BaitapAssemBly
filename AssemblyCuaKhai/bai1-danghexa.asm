.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TieptucSTR DB LF, CR, "Ban co tiep tuc khong? (k/K): $" 
    TB1 DB LF, CR, "Moi nhap so Hex (0...FFFF): $" 
    TB2 DB LF, CR, "Tong duoi dang nhi phan: $"
    TB3 DB LF, CR, "So vua nhap deo phai so Hex, nhap lai ngay!$"
    TB4 DB LF, CR, "Ban co muon tiep tuc khong? (C/c) $"
    N DW ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh
    MOV AH, 09h
    LEA DX, TB1
    INT 21H
    CALL Nhap       ; Nhap 1 so dang Hexa
    MOV N, BX       ; Dua so vua nhap vao bien N 

    MOV AH, 09H
    LEA DX, TB2
    INT 21H
    CALL TinhTong   ; Tinh tong 
    MOV BX, AX      ; Lay tong
    CALL HienThi    ; Hien thi tong o dang nhi phan
    
Lap:
    MOV AH, 9       ; Ham hien chuoi ki tu
    LEA DX, TB4
    INT 21H         ; In ra thong bao co tiep tuc khong
    MOV AH, 1       ; ham nhap 1 ki tu
    INT 21H         ; Nhap 1 ki tu tu ban phim
    CMP AL, 'C'     ; So sanh voi 'C'
    JE BEGIN        ; Dung -> Lap
    CMP AL, 'c'     ; So sanh voi 'c'
    JE BEGIN        ; Dung -> Lap
    JMP THOAT       ; Sai -> thoat

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP  
; thu tuc nhap mot so o dang Hexa
; vao: khong
; ra: BX chua so vua nhap
Nhap PROC 
    PUSH AX
    PUSH CX         ; Cat cac thanh ghi
    XOR BX, BX      ; xoa BX
    MOV CL, 4       ; cho so lan lap la 4
    MOV AH, 1       ; ham nhap ky tu
    INT 21H         ; nhap ky tu tu ban phim
VongLap:
    CMP AL, 13      ; so sanh voi Enter?
    JE KetThuc      ; dung -> ket thuc
    CMP AL, '0'     ; so sanh <= 0
    JLE BaoLoi      ; dung -> bao loi
    CMP AL, '9'     ; so sanh <= 9
    JLE ChuSo       ; dung -> la chu so
    CMP AL, 'A'     ; so sanh < A
    JL BaoLoi       ; dung -> bao loi
    CMP AL, 'F'     ; so sanh <= F
    JLE ChuCai      ; dung -> la chu cai
    JMP BaoLoi      ; sai -> bao loi
ChuSo:
    AND AL, 0FH     ; doi chu so ra so
    JMP ChenBit
ChuCai:
    SUB AL, 37H     ; la chu cai thi +37h
ChenBit:
    SHL BX, CL
    OR BL, AL
    INT 21H         ; nhap so tiep theo
    JMP VongLap     ; lap lai vong lap
KetThuc:
    POP CX
    POP AX          ; Khoi phuc cac thanh ghi 
    RET 
BaoLoi:  
    MOV AH, 09H     ; hien thi chuoi ki tu
    LEA DX, TB3
    INT 21H         ; in ra TBAO3
    JMP BEGIN       ; Lap lai tu dau
Nhap ENDP 
; Thu thuc tinh tong S=(1+2+...+N)*2
; Vao: Bien N la so nguyen
; Ra: AX tong S
TinhTong PROC
    PUSH BX
    PUSH CX         ; Cat thanh ghi
    XOR AX, AX      ; xoa AX
    MOV BX, 2       ; Phan tu dau tien
    MOV CX, N       ; for N lan
LAPCONG:
    ADD AX, BX      ; AX = AX+BX
    ADD BX, 2       ; BX = BX+2
    LOOP LAPCONG    ; Lap lai
    POP CX
    POP BX          ; Khoi phuc thanh ghi
    RET             ; Return
TinhTong ENDP
; thu tuc hien thi 1 so o dang nhi phan
; vao: BX chua so can in
; ra: khong
HienThi PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX         ; Cat cac thanh ghi
    MOV CX, 16      ; so bit can hien
    MOV AH, 2       ; ham hien ki tu
Print:
    ROL BX, 1       ; quay trai BX => CF = MSB
    MOV DL, 0       ; DL = 0
    ADC DL, 30h     ; DL <= 30h + CF
    INT 21h         ; in ki tu trong DL
    LOOP Print      ; lap lai 16 lan 
    POP DX
    POP CX
    POP BX
    POP AX          ; Khoi phuc cac thanh ghi
    RET    
HienThi ENDP
END MAIN