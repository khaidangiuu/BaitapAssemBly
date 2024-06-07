.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBAO1 DB LF, CR, 'Danh vao so HEX (0...FFFF) $'
    TBAO2 DB LF, CR, 'Duoi dang nhi phan bang: $'
    TBAO3 DB LF, CR, 'Chu so hex khong hop le, hay nhap lai!!! $'
    TBAO4 DB LF, CR, 'Ban co muon tiep tuc khong? (c/C) $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh         
    MOV AH, 09H     ; Ham hien chuoi ki tu
    LEA DX, TBAO1
    INT 21H         ; In ra TBAO1
    XOR BX, BX      ; Xoa BX
    MOV CL, 4       ; So lan dich trai BX
    MOV AH, 1       ; Ham nhap ki tu
    INT 21h         ; Nhap 1 ki tu => AL = ma ASCII
VongLap:
    CMP AL, 13      ;Ki tu vua nhap la Enter
    JE KetThucLap   ; Dung => Ket thuc
    CMP AL, '0'     ; So sanh neu <=0
    JLE BaoLoi      ; Thi bao loi
    CMP AL, '9'     ; Neu <=9
    JLE ChuSo       ; La chu so
    CMP AL, 'A'     ; Neu < 'A'
    JL BaoLoi       ; Thi bao loi
    CMP AL, 'F'     ; Neu <= 'F'
    JLE ChuCai      ; La chu cai hoa
    JMP BaoLoi
ChuSo:
    AND AL, 0Fh     ; => doi chu so ra nhi phan
    JMP ChenBit     ; Roi chen vao cuoi BX
ChuCai:
    SUB AL, 37h     ; Doi chu cai ra nhi phan
ChenBit:
    SHL BX, CL      ; Dich trai BX de danh cho cho c/s moi
    OR BL, AL       ; chen chu so moi vao 4 bit thap cua BX
    INT 21h         ; Nhap ki tu tu ban phim
    JMP VongLap     ; Lap lai
KetThucLap: 
    MOV AH, 09H     ; Ham hien chuoi ki tu
    LEA DX, TBAO2
    INT 21H         ; in ra TBAO2
    MOV CX, 16      ; so bit can hien
    MOV AH, 2       ; ham hien ki tu
Print:
    ROL BX, 1       ; quay trai BX => CF = MSB
    MOV DL, 0       ; DL = 0
    ADC DL, 30h     ; DL <= 30h + CF
    INT 21h         ; in ki tu trong DL
    LOOP Print      ; lap lai 16 lan 
    JMP Lap
Lap:
    MOV AH, 9       ; Ham hien thi chuoi
    LEA DX, TBAO4
    INT 21H         ; In ra thong bao Lap lai
    MOV AH, 1       ; Ham nhap 1 ki tu
    INT 21H         ; Nhap 1 ki tu tu ban phim
    CMP AL, 'C'     ; So sanh ki tu vua nhap voi 'C'
    JE BEGIN        ; Dung => Lap lai
    CMP AL, 'c'     ; So sanh voi 'c'
    JE BEGIN        ; Dung => Lap lai
    JMP THOAT       ; Sai => thoat
BaoLoi:  
    MOV AH, 09H     ; hien thi chuoi ki tu
    LEA DX, TBAO3
    INT 21H         ; in ra TBAO3
    JMP BEGIN       ; Lap lai tu dau
THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN