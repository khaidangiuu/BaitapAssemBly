.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBAO1 DB LF, CR, "Moi nhap so thu nhat: $"
    TBAO2 DB LF, CR, "Moi nhap so thu hai: $"
    TBAO3 DB LF, CR, "Ket qua: $"
    TBAO4 DB LF, CR, "So vua nhap bi loi! Moi nhap lai: $"
    TBAO5 DB LF, CR, "Ban co muon tiep tuc khong? (C/c)$"
    A DW ?
    B DW ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh 
    MOV AH, 9
    LEA DX, TBAO1
    INT 21H 
    CALL Nhap
    MOV A, BX
    
    MOV AH, 9
    LEA DX, TBAO2
    INT 21H  
    CALL Nhap
    MOV B, BX 
    
    MOV AH, 9
    LEA DX, TBAO3
    INT 21H
    
    MOV AX, A
    MOV BX, B
    CMP AX, BX
    JG Lon
    ADD AX, BX
    MOV BX, AX
    CALL NhoHon
    JMP Lap
Lon:
    SUB AX, BX
    MOV BX, AX
    CALL LonHon 
Lap:
    MOV AH, 9       ; Ham hien chuoi ki tu
    LEA DX, TBAO5
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

Nhap proc
MoiNhap:
    XOR BX, BX      ; Xoa BX
    MOV CL, 4       ; So lan dich trai BX
    MOV AH, 1       ; Ham nhap ki tu
    INT 21h         ; Nhap 1 ki tu => AL = ma ASCII
VongLap:
    CMP AL, 13      ;Ki tu vua nhap la Enter
    JE KetThucLap   ; Dung => Ket thuc
    CMP AL, '0'     ; So sanh neu < 0
    JL BaoLoi       ; Thi bao loi
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
RET 

BaoLoi:  
    MOV AH, 09H     ; hien thi chuoi ki tu
    LEA DX, TBAO4
    INT 21H         ; in ra TBAO4
    JMP MoiNhap       ; Lap lai tu dau
Nhap endp

LonHon proc
    MOV CX, 16      ; so bit can hien
    MOV AH, 2       ; ham hien ki tu
Print:
    ROL BX, 1       ; quay trai BX => CF = MSB
    MOV DL, 0       ; DL = 0
    ADC DL, 30h     ; DL <= 30h + CF
    INT 21h         ; in ki tu trong DL
    LOOP Print      ; lap lai 16 lan
    RET
LonHon endp

NhoHon proc
    MOV CX, 4       ; Bien lap
    MOV AH, 2       ; ham hien thi ki tu
InHexa:
    MOV DL, BH      ; chuyen BH vao DL
    ; Dich phai DL 4 vi tri
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    CMP DL, 9       ; So sanh > 9
    JA ChuCai1       ; Dung => chuyen den ChuCai
    ADD DL, 30h     ; Sai => DL=DL+30h doi thanh ki tu 0->9
    JMP TiepTuc   
ChuCai1:
    ADD DL, 37h     ; Neu DL>9 => DL=DL+37h doi thanh A->Z    
TiepTuc:
    INT 21h         ; in ra ki tu
    ; Quay trai BX 4 lan
    ROL BX, 1
    ROL BX, 1
    ROL BX, 1
    ROL BX, 1
    LOOP InHexa     ; lap lai 4 lan 
    RET
NhoHon endp
   
END MAIN