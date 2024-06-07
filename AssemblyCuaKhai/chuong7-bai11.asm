.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBAO1 DB LF, CR, 'Danh vao so nhi phan (toi da 16 so) $'
    TBAO2 DB LF, CR, 'Duoi dang Hex no bang: $'
    TBAO3 DB LF, CR, 'Ban co muon tiep tuc khong? (c/C) $'
    TBAO4 DB LF, CR, 'So vua nhap loi, moi nhap lai!!!$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh     
    
    MOV AH, 09H     ; ham hien thong bao
    LEA DX, TBAO1
    INT 21H         ; In ra thong bao nhap
     
    XOR AX, AX      ; Xoa AX=0
    XOR BX, BX      ; Xoa BX=0
    
    MOV AH, 1       ; ham nhap 1 ki tu
    INT 21H         ; nhap ki tu
        
NhapKyTu:
    CMP AL, 13      ; la phim enter
    JE DungNhap     ; dung => ket thuc nhap
    CMP AL, 48      ; So sanh voi '0'
    JE ThucHien     ; Dung -> tiep tuc thuc hien
    CMP AL, 49      ; So sanh voi '1'
    JE ThucHien     ; Dung -> tiep tuc thuc hien
    JNE BaoLoi      ; Sai -> Bao loi
ThucHien:
    AND AL, 0Fh     ; sai => doi ra gia tri nhi phan
    SHL BX, 1       ; danh cho nay cho bit moi tim duoc
    OR BL, AL       ; chen bit nay vao cuoi bx
    INT 21H         ; nhap tiep ki tu khac
    JMP NhapKyTu    ; lap lai
DungNhap:     

; Bieu dien so hexa trong BX
    MOV AH, 09H     ; ham hien thi chuoi
    LEA DX, TBAO2 
    INT 21H         ; hien thi chuoi tbao
    MOV AX, BX
    
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
Lap:
    MOV AH, 9       ; Ham hien chuoi ki tu
    LEA DX, TBAO3
    INT 21H         ; In ra thong bao co tiep tuc khong
    MOV AH, 1       ; ham nhap 1 ki tu
    INT 21H         ; Nhap 1 ki tu tu ban phim
    CMP AL, 'C'     ; So sanh voi 'C'
    JE BEGIN        ; Dung -> Lap
    CMP AL, 'c'     ; So sanh voi 'c'
    JE BEGIN        ; Dung -> Lap
    JMP THOAT       ; Sai -> thoat
BaoLoi:
    MOV AH, 9       ; Ham hien chuoi ki tu
    LEA DX, TBAO4
    INT 21H         ; In ra thong bao loii
    JMP BEGIN       ; Lap lai tu dau

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN