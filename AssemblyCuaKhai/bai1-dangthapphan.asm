.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TB1 DB LF, CR, "Moi nhap so thap phan: $" 
    TB2 DB LF, CR, "Tong: $"
    TB3 DB LF, CR, "So vua nhap deo phai so Hex, nhap lai ngay!$"
    TB4 DB LF, CR, "Ban co muon tiep tuc khong? (C/c) $"
    N DW ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh
    MOV AH, 09h
    LEA DX, TB1
    INT 21H
    CALL INDEC       ; Nhap 1 so dang Hexa
    MOV N, AX       ; Dua so vua nhap vao bien N
    PUSH AX 

    MOV AH, 09H
    LEA DX, TB2
    INT 21H                 
    POP AX
    CALL TinhTong   ; Tinh tong
    CALL OUTDEC    ; Hien thi tong o dang nhi phan
    
Lap:
    MOV AH, 9       ; Ham hien chuoi ki tu
    LEA DX, TB4
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
; in noi dung cua AX duoi dang thap phan co dau  
; Vao: AX
; Ra: Khong
OUTDEC PROC
    PUSH AX         ; Cat cac thanh ghi
    PUSH BX
    PUSH CX
    PUSH DX
; If AX<0    
    OR AX, AX       ; AX<0?
    JGE END_IF1     ; Sai -> end_if
; Then    
    PUSH AX         ; Cat so can dua ra
    MOV DL, '-'     ; Lay ki tu '-'
    MOV AH, 2       ; Ham hien 1 ki tu
    INT 21H         ; Hien ki tu '-'
    POP AX          ; Lay lai AX
    NEG AX          ; AX=AX-1
END_IF1:
;Lay ra cac so thap phan    
    XOR CX, CX      ; CX=0, CX dem cac chu so thap phan
    MOV BX, 10D     ; BX chua so chia
LAPLAI1:
    XOR DX, DX      ; DX chua so bi chia
    DIV BX          ; AX=thuong, DX=du
    PUSH DX         ; Cat so du vao ngan xep
    INC CX          ; Dem = Dem+1
    OR AX, AX       ; Thuong = 0?
    JNE LAPLAI1     ; Sai -> tiep tuc
    ; Doi chu so thanh ki tu va dua ra man hinh
    MOV AH, 2
    ; For Dem lan Do
PRINT:
    POP DX          ; Chu so trong DL
    OR DL, 30H      ; Doi no thanh ki tu
    INT 21H         ; In ra man hinh
    LOOP PRINT      ; Lap lai cho den khi xong
    ; End_for
    POP DX          ; Khoi phuc lai cac thanh ghi
    POP CX
    POP BX
    POP AX
    RET             ; Return
OUTDEC ENDP
; Thu thuc tinh tong S=(1+2+...+N)*2
; Vao: Bien N la so nguyen
; Ra: AX tong S
TinhTong PROC
    PUSH BX
    PUSH CX         ; Cat thanh ghi
    XOR AX, AX      ; xoa AX
    MOV BX, 2       ; Phan tu dau tien
    MOV CX, N       ; for N lan
LAPCONG:
    ADD AX, BX      ; AX = AX+BX
    ADD BX, 2       ; BX = BX+2
    LOOP LAPCONG    ; Lap lai
    POP CX
    POP BX          ; Khoi phuc thanh ghi
    RET             ; Return
TinhTong ENDP

END MAIN