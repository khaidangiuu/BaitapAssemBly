.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBAO1 DB LF, CR, "Nhap M: $"
    TBAO2 DB LF, CR, "Nhap N: $"
    TBAO3 DB LF, CR, "M^N (dang hex) = $"   
    TBAO4 DB LF, CR, "Ban co muon thoat khong?(k/K) $"
    M DW ?
    N DW ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh
    MOV AH, 09H
    LEA DX, TBAO1
    INT 21H 
    CALL INDEC
    MOV M, AX  
    PUSH AX
;
    MOV AH, 09H
    LEA DX, TBAO2
    INT 21H 
    CALL INDEC
    MOV BX, AX 
    MOV N, BX 
    PUSH BX
    ;   
    MOV AH, 09H
    LEA DX, TBAO3
    INT 21H 
    POP BX 
    POP AX 
    CALL mMuN
    CALL OutHex
    
    MOV AH, 09H
    LEA DX, TBAO4
    INT 21H 
    MOV AH, 01H
    INT 21H
    CMP AL, 'K'
    JE BEGIN
    CMP AL, 'k'
    JE BEGIN
    JMP THOAT 

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP     
; Nhap vao 1 so thap phan pham vi tu -32768 den 32768
; Vao: Khong
; Ra: AX = gia tri nhi phan tuong duong cua so
INDEC PROC
    PUSH BX         ; Cat cac thanh ghi
    PUSH CX
    PUSH DX
BATDAU:
    XOR BX, BX      ; BX=0 de chua tong
; am=false    
    XOR CX, CX      ; CX chua dau
; Doc ky tu    
    MOV AH, 1       ; Ham nhap ky tu
    INT 21H         ; Nhap ky tu tu ban phim
; case ky tu OF    
    CMP AL, '-'     ; Neu co dau am(-)
    JE AM           ; Dung -> lable am
    CMP AL, '+'     ; Neu co dau duong(+)
    JE DUONG        ; Dung -> lable duong
    JMP LAPLAI2     ; Sai, bat dau xu ly
AM:
    MOV CX, 1       ; am = true
DUONG:
    INT 21H
; end_case
LAPLAI2:
; IF Neu ky tu nam trong khoang tu 0-9
    CMP AL, '0'     ; So sanh >= 0
    JNGE LOI        ; Sai -> bao loi
    CMP AL, '9'     ; So sanh <= 9
    JNLE LOI        ; Sai -> bao loi
; THEN doi ky tu thanh chu so   
    AND AX, 000FH   ; Doi thanh chu so
    PUSH AX         ; Cat vao ngan xep
; Tong=10*tong+chuso    
    MOV AX, 10
    MUL BX          ; AX=tong*10
    POP BX          ; Phuc hoi chu so
    ADD BX, AX      ; Tong = tong*10+chuso
; Doc ky tu    
    MOV AH, 1       ; Ham nhap 1 ky tu
    INT 21H         ; Nhap 1 ky tu tu ban phim
    CMP AL, 0DH     ; Kiem tra co phai enter
    JNE LAPLAI2     ; Sai -> nhap so tiep theo
; until CR    
    MOV AX, BX      ; Luu so vua nhap vao AX
; IF am    
    OR CX, CX       ; So am ?
    JE KETTHUCLAP2  ; Sai -> ket thuc
; Then    
    NEG AX          ; Dung -> lay bu 2 cua AX
; End_if
KETTHUCLAP2:
    POP DX          ; Phuc hoi cac thanh ghi
    POP CX
    POP BX
    RET             ; Return
; Neu khong phai ky tu hop le    
LOI:
    MOV AH, 2       ;
    MOV DL, 0DH
    INT 21H         ; xuong dong
    MOV DL, 0AH
    INT 21H         ; ve dau dong
    JMP BATDAU      ; lam lai tu dau
INDEC ENDP 
; in noi dung cua AX duoi dang hex
; Vao: AX
; Ra: Khong
OutHex proc  
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
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
    POP DX
    POP CX
    POP BX
    POP AX
    RET
OutHex endp
; M^N
; Vao: M va N
; Ra: BX = Ket qua cua m^n
mMuN PROC
    PUSH AX
    PUSH CX         ; Cat thanh ghi
    XOR AX, AX      ; xoa AX 
    MOV AX, M
    MOV BX, M
    MOV CX, N       ; for N lan
LAPCONG:
    
    MUL BX          ; AX=AX*BX
    DEC CX          ; Giam CX di 1 don vi
    CMP CX, 0       ; So sanh CX=0?
    JE THOI         ; Dung => ket thuc
    LOOP LAPCONG    ; Lap lai   
    THOI:  
    MOV BX, AX      ; Chuyen AX vao BX
    POP CX
    POP AX          ; Khoi phuc thanh ghi
    RET             ; Return
mMuN ENDP
END MAIN