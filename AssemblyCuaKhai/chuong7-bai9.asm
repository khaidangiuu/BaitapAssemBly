.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    LapLai DB LF, CR, "Ban co tiep tuc khong? (C/c): $"
    TB1 DB LF, CR, "Danh vao mot ki tu: $"
    TB2 DB LF, CR, "Ma ASCII cua ki tu duoi dang hex: $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS

BEGIN:
    ; Hien thi yeu cau nhap ki tu
    MOV AH, 9       ; ham hien thi chuoi ki tu
    LEA DX, TB1
    INT 21h         ; in ra chuoi TB1
    
    ; Nhap ki tu
    MOV AH, 1       ; ham nhap 1 ki tu tu ban phim
    INT 21h         ; nhap 1 ki tu
    MOV BL, AL      ; BL chua ki tu nhap vao

    ; In ma ASCII cua ki tu duoi dang nhi phan
    MOV AH, 9       ; ham hien thi chuoi ki tu
    LEA DX, TB2
    INT 21h         ; in ra TB2

    MOV CX, 4       ; Bien lap lai
    MOV AH, 2       ; Ham in ki tu
InHexa:
    MOV DL, BH      ; chuyen BH vao DL
    ; dich phai DL 4 vi tri
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    CMP DL, 9       ; So sanh voi > 9
    JA ChuCai       ; Dung => Chu cai
    ADD DL, 30h     ; Sai => DL=DL+30h(48)
    JMP TiepTuc
ChuCai:
    ADD DL, 37h     ; Neu DL>9 => DL=DL+37h
TiepTuc:
    INT 21h         ; in ra ki tu
    ; quay trai BX 4 vi tri
    ROL BX, 1
    ROL BX, 1
    ROL BX, 1
    ROL BX, 1
    LOOP InHexa     ; Lap lai 4 lan 
    
Lap: 
    MOV AH, 9       ; Ham hien thi chuoi
    LEA DX, LapLai
    INT 21H         ; In ra thong bao 
    MOV AH, 1       ; Ham nhap 1 ki tu
    INT 21H         ; Nhap ki tu tu ban phim
    CMP AL, 'C'     ; so sanh ki tu vua nhap voi 'C'
    JE BEGIN        ; Dung => Lap lai tu dau
    CMP AL, 'c'     ; so sanh ki tu vua nhap voi 'c'
    JE BEGIN        ; Dung => Lap lai tu dau
    JMP THOAT       ; Sai thi thoat

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trình
MAIN ENDP
END MAIN
