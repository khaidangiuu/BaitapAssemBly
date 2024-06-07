 .MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBAO1 DB LF, CR, 'Danh vao mot chuoi cac so thap phan: $'
    TBAO2 DB LF, CR, 'Tong cua chung: $'
    TBAO3 DB LF, CR, 'Ban co muon thoat khong (C/K) $'
    TBAO4 DB LF, CR, 'So vua nhap bi loi, moi nhap lai!!$'
    Tong DW ?
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
    CMP AL, '0'     ; So sanh neu < 0
    JL BaoLoi       ; Bao loi
    CMP AL, '9'     ; Neu > 9
    JG BaoLoi       ; Bao loi
    SUB AL, '0'     ; Chuyen ky tu so ve gia tri so
    ;JMP ChenBit     ; Roi chen vao cuoi BX
ChenBit:
    ;SHL BX, CL      ; Dich trai BX de danh cho cho c/s moi
    ADD BL, AL      ; Tính t?ng s? dã nh?p
    INT 21h         ; Nhap ki tu tiep theo tu ban phim
    JMP VongLap     ; Lap lai 

BaoLoi:
    MOV AH, 09H     ; Ham in chuoi ki tu
    LEA DX, TBAO4   
    INT 21H         ; In ra thong bao Loi
    JMP BEGIN       ; Lap lai tu dau

KetThucLap:  

    MOV Tong, BX ; Luu vao Tong
     
    MOV AH, 09H     ; Ham hien chuoi ki tu
    LEA DX, TBAO2
    INT 21H         ; in ra TBAO2
     
    
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
    CMP AL, 'c'     ; neu 'K' thi lap lai
    JE THOAT       ; Lap lai tu dau
    JMP THOAT

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN