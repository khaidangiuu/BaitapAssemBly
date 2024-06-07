.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBAO1 DB LF, CR, "Moi nhap canh A: $"
    TBAO2 DB LF, CR, "Moi nhap canh B: $"
    TBAO3 DB LF, CR, "Moi nhap canh C: $"
    TBAO4 DB LF, CR, "So vua nhap loi! Moi nhap lai: $"
    TBAO5 DB LF, CR, "Chu vi cua tam giac la: $"
    TBAO6 DB LF, CR, "Day khong phai tam giac!!$"
    TBAO7 DB LF, CR, "Ban co muon tiep tuc khong? (C/c) $"
    A DW ?
    B DW ?
    C DW ?
    P DW ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh
    MOV AH, 9        ; Ham hien thi chuoi
    LEA DX, TBAO1
    INT 21H          ; In ra thong bao nhap so 1
    CALL NHAP        ; Goi den ham con Nhap
    MOV A, BX        ; Dua so vua nhap vao A
     
    MOV AH, 9
    LEA DX, TBAO2
    INT 21H          ; In ra thong bao nhap so 2
    CALL NHAP
    MOV B, BX        ; ;Dua so vua nhap vao B
    
    MOV AH, 9
    LEA DX, TBAO3
    INT 21H          ; In ra thong bao nhap so 3
    CALL NHAP
    MOV C, BX        ; Dua so vua nhap vao C
    
    MOV AH, 9
    LEA DX, TBAO5
    INT 21H          ; In ra thong bao chu vi
    CALL ChuVi       ; Goi den ham con tinh chu vi
    CALL HienThi     ; Goi den ham con Hien thi
Lap:
    MOV AH, 9       ; Ham hien chuoi ki tu
    LEA DX, TBAO7
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
; Ham con nhap
NHAP PROC
NhapLai:
    PUSH AX
    PUSH DX      ; Cat thanh ghi
    XOR BX, BX   ; Xoa BX 
    XOR AX, AX   ; Xoa AX
    MOV AH, 1    ; Ham nhap ky tu
    INT 21h      ; Nhap ky tu 
    
NhapKyTu: 
    CMP AL, 13   ; La phim ENTER?
    JE DungNhap  ; True -> ket thuc nhap
    CMP AL, 48    ; So sanh voi 0 
    JE ThucHien  ; Dung -> tiep tuc thuc hien
    CMP AL, 49    ; So sanh voi 1 
    JE ThucHien  ; Dung -> Tiep tuc thuc hien
    JNE BaoLoi   ; Sai -> Thong bao loi
ThucHien:   
    AND AL, 0Fh    ; False -> doi ra gia tri nhi phan  
    SHL BX, 1      ; Danh cho cho bit moi tim duoc
    OR BL, AL      ; Chen bit nay vao cuoi BX
    INT 21h        ; Nhap tiep ky tu khac
    JMP NhapKyTu   ; Lap lai
DungNhap:
    POP DX
    POP AX         ; Khoi phuc thanh ghi
    RET            ; return
BaoLoi:
    MOV AH, 9       ; Ham hien chuoi ki tu
    LEA DX, TBAO4
    INT 21H         ; in ra thong bao loi
    JMP NhapLai    ; nhap lai so 1 
    
NHAP ENDP
; Ham con tinh chu vi
ChuVi PROC
    PUSH AX
    PUSH CX         ; Cat thanh ghi

    MOV AX, A       ; Dua A vao AX
    MOV BX, B       ; Dua B vao BX
    MOV CX, C       ; Dua C vao CX
    ; if((A+B>C)&&(A+C>B)&&(B+C>A))

    ; then
    ; Chu vi P=A+B+C
    ADD BX, AX      ; BX+=AX 
    ADD BX, CX      ; BX+=CX
    POP CX
    POP AX          ; Khoi phuc thanh ghi
    RET             ; Return

ChuVi ENDP

HienThi PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX         ; cat thanh ghi
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
    POP DX
    POP CX
    POP BX
    POP AX          ; Khoi phuc thanh ghi 
    RET
HienThi ENDP
END MAIN