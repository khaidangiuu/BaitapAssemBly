.MODEL  Small
.STACK 100h
.DATA 
    LF EQU 10
    CR EQU 13 
    TBAO1 DB CR, LF, "Nhap so nhi phan thu nhat: $"
    TBAO2 DB CR, LF, "Nhap so nhi phan thu hai: $"
    TBAO3 DB CR, LF, "Tong cua hai so la: $"
    TBAO4 DB CR, LF, 'Loi! Hay nhap lai. $' 
    Tieptuc DB CR, LF, "Ban co muon thoat chuong trinh khong? (C/K): $"
    A DW ?
    B DW ?
    Tong DW ? 
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
BEGIN:  
      
NHAP_SO_THU_NHAT:
NhapLai1:
    MOV AH, 09H   ; ham hien thi chuoi 
    LEA DX, TBAO1
    INT 21H        ; hien thi thong bao 1
          
    XOR BX, BX   ; Xoa BX 
    XOR AX, AX   ; Xoa AX
    MOV AH, 1    ; Ham nhap ky tu
    INT 21h      ; Nhap ky tu 
    
NhapKyTu1: 
    CMP AL, 13   ; La phim ENTER?
    JE DungNhap1  ; True -> ket thuc nhap
    CMP AL, 48    ; So sanh voi 0 
    JE ThucHien1  ; Dung -> tiep tuc thuc hien
    CMP AL, 49    ; So sanh voi 1 
    JE ThucHien1  ; Dung -> Tiep tuc thuc hien
    JNE BaoLoi1   ; Sai -> Thong bao loi
ThucHien1:   
    AND AL, 0Fh    ; False -> doi ra gia tri nhi phan  
    SHL BX, 1      ; Danh cho cho bit moi tim duoc
    OR BL, AL      ; Chen bit nay vao cuoi BX
    INT 21h        ; Nhap tiep ky tu khac
    JMP NhapKyTu1   ; Lap lai
DungNhap1: 
 
    MOV A, BX        ; Dua so vua nhap vao A
    JMP NHAP_SO_THU_HAI  ; nhay sang nhap so thu 2
BaoLoi1:
    MOV AH, 9       ; Ham hien chuoi ki tu
    LEA DX, TBAO4
    INT 21H         ; in ra thong bao loi
    JMP NhapLai1    ; nhap lai so 1
    
NHAP_SO_THU_HAI:
NhapLai2:
    MOV AH, 09H   ; ham hien chuoi
    LEA DX, TBAO2
    INT 21H        ; hien thi thong bao 2
          
    XOR BX, BX   ; Xoa BX 
    XOR AX, AX
    MOV AH, 1    ; Ham nhap ky tu
    INT 21h      ; Nhap ky tu 
    
NhapKyTu2: 
    CMP AL, 13   ; La phim ENTER?
    JE DungNhap2  ; True -> ket thuc nhap
    CMP AL, 48    ; So sanh voi 0
    JE ThucHien2  ; dung -> tiep tuc thuc hien
    CMP AL, 49    ; So sanh voi 1 
    JE ThucHien2  ; Dung -> tiep tuc thuc hien
    JNE BaoLoi2   ; Sai -> Bao loi
    
ThucHien2:   
    AND AL, 0Fh  ; False -> doi ra gia tri nhi phan  
    SHL BX, 1    ; Danh cho cho bit moi tim duoc
    OR BL, AL    ; Chen bit nay vao cuoi BX
    INT 21h      ; Nhap tiep ky tu khac
    JMP NhapKyTu2 ; Lap lai
DungNhap2:

    MOV B, BX    ; Luu vao B
    ADD BX, A    ; Cong A voi B, luu vao BX
    MOV Tong, BX ; Luu vao Tong 
    MOV AH, 09H
    LEA DX, TBAO3
    INT 21H        ; hien thi math1

    MOV CX, 16     ; So lan lap
    MOV AH, 2      ; Ham hien ki tu
Print:  
    XOR DL, DL     ; Xoa DL = 0
    ROL BX, 1      ; 
    ADC DL, 30H    ; Cong DL=DL+30H(48)
    INT 21H        ; Hien ki tu
    LOOP Print     ; Lap lai
    JMP THONG_BAO_THOAT

BaoLoi2:
    MOV AH, 9       ; Ham hien chuoi
    LEA DX, TBAO4
    INT 21H         ; In ra thong bao loi
    JMP NhapLai2    ; nhap lai so thu 2
                            
THONG_BAO_THOAT:
    MOV AH, 09H
    LEA DX, Tieptuc
    INT 21H        ; hien thi thong bao Tieptuc
    
    MOV AH, 01H
    INT 21H        ; doc 1 ky tu tu ban phim
    
    CMP AL, 'K'    ; kiem tra AL ?= 'K'
    JE  BEGIN      ; dung => lap lai tu dau
    CMP AL, 'C'    ; kiem tra AL ?= 'C'
    JE  THOAT      ; dung => thoat           
THOAT:
    MOV AH, 4Ch
    INT 21H
MAIN ENDP
END MAIN