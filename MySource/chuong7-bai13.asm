.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBAO1 DB LF, CR, 'Danh vao so HEX 1 (0...FFFF): $'
    TBAO DB LF, CR, 'Danh vao so HEX 2 (0...FFFF): $'
    TBAO2 DB LF, CR, 'Tong cua chung: $'
    TBAO3 DB LF, CR, 'Ban co muon thoat khong (C/K) $'
    TBAO4 DB LF, CR, 'So vua nhap bi loi! Hay nhap lai.$'
    A DW ?
    B DW ?
    Tong DW ? 
    Tran DB 0   ; Bien luu trang thai tran
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh
NhapSoThuNhat:
    MOV AH, 09H     ; Ham hien chuoi ki tu
    LEA DX, TBAO1
    INT 21H         ; In ra TBAO1
             
    XOR BX, BX      ; Xoa BX
    MOV CL, 4       ; So lan dich trai BX
    MOV AH, 1       ; Ham nhap ki tu
    INT 21h         ; Nhap 1 ki tu => AL = ma ASCII
VongLap1:
    CMP AL, 13      ;Ki tu vua nhap la Enter
    JE KetThucLap1  ; Dung => Ket thuc
    CMP AL, '0'     ; So sanh neu < 0
    JL  BaoLoi1     ; Thi bao loi
    CMP AL, '9'     ; Neu <=9
    JLE ChuSo1      ; La chu so
    CMP AL, 'A'     ; Neu < 'A'
    JL BaoLoi1      ; Thi bao loi
    CMP AL, 'F'     ; Neu <= 'F'
    JLE ChuCai1     ; La chu cai hoa
    JMP BaoLoi1     ; Khong thi bao loi
ChuSo1:
    AND AL, 0Fh     ; => doi chu so ra nhi phan
    JMP ChenBit1    ; Roi chen vao cuoi BX
ChuCai1:
    SUB AL, 37h     ; Doi chu cai ra nhi phan
ChenBit1:
    SHL BX, CL      ; Dich trai BX de danh cho cho c/s moi
    OR BL, AL       ; chen chu so moi vao 4 bit thap cua BX
    INT 21h         ; Nhap ki tu tu ban phim
    JMP VongLap1     ; Lap lai   
    
BaoLoi1:
    MOV AH, 09H     ; Ham in chuoi ki tu
    LEA DX, TBAO4   
    INT 21H         ; In ra thong bao Loi
    JMP NhapSoThuNhat       ; Nhap lai so thu nhat
    
KetThucLap1:
    MOV A, BX 
    
NhapSoThuHai:
    MOV AH, 09H     ; Ham hien chuoi ki tu
    LEA DX, TBAO
    INT 21H         ; In ra TBAO1
             
    XOR BX, BX      ; Xoa BX
    MOV CL, 4       ; So lan dich trai BX
    MOV AH, 1       ; Ham nhap ki tu
    INT 21h         ; Nhap 1 ki tu => AL = ma ASCII
VongLap2:
    CMP AL, 13      ;Ki tu vua nhap la Enter
    JE KetThucLap2  ; Dung => Ket thuc
    CMP AL, '0'     ; So sanh neu < 0
    JL  BaoLoi2     ; Thi bao loi
    CMP AL, '9'     ; Neu <=9
    JLE ChuSo2      ; La chu so
    CMP AL, 'A'     ; Neu < 'A'
    JL BaoLoi2      ; Thi bao loi
    CMP AL, 'F'     ; Neu <= 'F'
    JLE ChuCai2     ; La chu cai hoa
    JMP BaoLoi2     ; Khong thi bao loi
ChuSo2:
    AND AL, 0Fh     ; => doi chu so ra nhi phan
    JMP ChenBit2     ; Roi chen vao cuoi BX
ChuCai2:
    SUB AL, 37h     ; Doi chu cai ra nhi phan
ChenBit2:
    SHL BX, CL      ; Dich trai BX de danh cho cho c/s moi
    OR BL, AL       ; chen chu so moi vao 4 bit thap cua BX
    INT 21h         ; Nhap ki tu tu ban phim
    JMP VongLap2    ; Lap lai

BaoLoi2:
    MOV AH, 09H     ; Ham in chuoi ki tu
    LEA DX, TBAO4   
    INT 21H         ; In ra thong bao Loi
    JMP NhapSoThuHai       ; Nhap lai so thu 2
    
KetThucLap2:
    MOV B, BX
    
    ADD BX, A    ; Cong A voi B, luu vao BX
    JNC KhongTran      ; neu khong tran
    MOV Tran, '1'          ; Tran gang C = '0'     
    JMP BoQuaTran
KhongTran:
    MOV Tran, '0'          ; Khong tran gan C = '0' 
BoQuaTran:
    
    MOV Tong, BX ; Luu vao Tong
     
    MOV AH, 09H     ; Ham hien chuoi ki tu
    LEA DX, TBAO2
    INT 21H         ; in ra TBAO2
    
    
    MOV CX, 4       ; Bien lap
    MOV AH, 2       ; ham hien thi ki tu
    MOV DL, Tran       ; Lay co nho
    Int 21h         ; in co nho
InHexa:
    MOV DL, BH      ; chuyen BH vao DL
    ; Dich phai DL 4 vi tri
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    CMP DL, 9       ; So sanh > 9
    JA ChuCai       ; Dung => chuyen den ChuCai
    ADD DL, 30h     ; Sai => DL=DL+30h doi thanh ki tu 0->9
    JMP TiepTuc   
ChuCai:
    ADD DL, 37h     ; Neu DL>9 => DL=DL+37h doi thanh A->Z    
TiepTuc:
    INT 21h         ; in ra ki tu
    ; Quay trai BX 4 lan
    ROL BX, 1
    ROL BX, 1
    ROL BX, 1
    ROL BX, 1
    LOOP InHexa     ; lap lai 4 lan

LapLai:  
    MOV AH, 09H     ; hien thi chuoi ki tu
    LEA DX, TBAO3
    INT 21H         ; in ra TBAO3 
    MOV AH, 01H
    INT 21H         ; nhap 1 ki tu tu ban phim
    CMP AL, 'C'     ; neu 'C' thi thoat
    JE THOAT
    CMP AL, 'K'     ; neu 'K' thi lap lai
    JE BEGIN       ; Lap lai tu dau


THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN