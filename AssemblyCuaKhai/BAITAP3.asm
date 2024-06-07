.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBAO1 DB 'Xin moi nhap so nguyen N ('0' or '1') $'
    TBAO2 DB LF, CR, 'Tong (dang hex): $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh     
    MOV AH, 09H
    LEA DX, TBAO1
    INT 21H
    
    MOV AH, 1       ; ham nhap 1 ki tu
    INT 21H         ; nhap ki tu    
NhapKyTu:
    CMP AL, 13      ; la phim enter
    JE DungNhap     ; dung => ket thuc nhap
    AND AL, 0Fh     ; sai => doi ra gia tri nhi phan
    SHL BX, 1       ; danh cho nay cho bit moi tim duoc
    OR BL, AL       ; chen bit nay vao cuoi bx
    INT 21H         ; nhap tiep ki tu khac
    JMP NhapKyTu    ; lap lai
DungNhap: 

    XOR AX, AX      ; xoa AX   
    MOV CX, 1       ; cho BX=1 
    
    MOV CX, BX
    XOR AX, AX
    
LOOP_:
    ADD AX, CX      ; cong so hien tai cua day vao tong AX
    INC CX          ; tang gia tri BX len 1 de chuyen sang so tiep theo trong day
    CMP CX, BX
    JLE LOOP_ 
    

; Bi?u di?n s? hexa trong BX
    MOV AH, 09H     ; ham hien thi chuoi
    LEA DX, TBAO2 
    INT 21H         ; hien thi chuoi tbao
    MOV AX, BX
    
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
    
ChuCai:
    ADD DL, 37h
    
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