.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBAO1 DB LF, CR, "Nhap M: $"
    TBAO2 DB LF, CR, "Nhap N: $"
    TBAO3 DB LF, CR, "Boi so chung nho nhat cua M va N: $"  
    TBAO4 DB LF, CR, "Uoc so chung lon nhat cua M va N: $" 
    TBAO5 DB LF, CR, "Ban co muon thoat khong?(c/C) $"
    M DW ?
    N DW ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh   
    MOV AH, 09H     ;Ham in chuoi ky tu
    LEA DX, TBAO1
    INT 21H         ; Hien TBAO1
    CALL INDEC      ; Goi ham nhap
    MOV M, AX       ; Luu so vua nhap vao M
    ;PUSH AX
;
    MOV AH, 09H     ; Ham in chuoi ky tu
    LEA DX, TBAO2
    INT 21H         ; In ra TBAO 2
    CALL INDEC      ; Goi ham nhap
    MOV N, AX       ; Luu so vua nhap vao N
    ;PUSH BX   

    MOV AH, 09H
    LEA DX, TBAO3
    INT 21H         ; In ra TBao3
    ;POP BX 
    ;POP AX 
    CALL BCNN        ; Goi ham tim BCNN
    CALL OUTDEC     ; Goi ham in thap phan
    
    MOV AH, 09H
    LEA DX, TBAO4
    INT 21H         ; In ra TBAO4
    ;POP BX 
    ;POP AX 
    CALL UCLN        ; Goi ham tim UCLN
    CALL OUTDEC     ; Goi ham in thap phan
    
       
    MOV AH, 09H
    LEA DX, TBAO5 
    INT 21H         ; In ra TBAO5
    MOV AH, 01H     ; Ham nhap 1 ky tu
    INT 21H         ; Nhap 1 ky tu tu ban phim
    CMP AL, 'k'     ; So sanh voi 'k'
    JE BEGIN        ; Neu = 'k' thi bat dau lai
    CMP AL, 'K'     ; So sanh voi 'K'
    JE BEGIN        ; Neu = thi bat dau lai
    JMP THOAT       ; Sai thi ket thuc

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
; Ham tim uoc chung lon nhat
; Vao: M, N
; Ra: AX = UCLN
UCLN PROC
    PUSH BX         ; Luu trang thai cua BX
    MOV AX, M     ; Lay gia tri cua M vao AX
    MOV BX, N     ; Lay gia tri cua N vao BX

gcd_loop:
    CMP AX, BX      ; So sanh hai so
    JE gcd_done     ; Neu bang nhau, ket thuc vong lap
    JA larger       ; Neu AX lon hon BX, nhay toi larger
    SUB BX, AX      ; Tru BX cho AX
    JMP gcd_loop    ; Lap lai vong lap
larger:
    SUB AX, BX      ; Tru AX cho BX
    JMP gcd_loop    ; Lap lai vong lap
gcd_done:

    POP BX          ; Khoi phuc trang thai cua BX
    RET             ; Tra ve
UCLN ENDP
; Ham tim boi chung nho nhat
; Vao: M, N
; Ra: AX = BCNN
BCNN PROC
    PUSH BX         ;
    PUSH CX         ; Cat cac thanh ghi

    MOV AX, M       ; Dat AX = M
    MOV BX, N       ; Dat BX = N

    ; Tinh boi so chung nho nhat 
    ; Cong thuc LCM(M,N)=(M*N)/gcd(M,N)
    
    MUL BX          ; Nhan AX voi BX <=> M*N 
    PUSH AX         ; Cat AX di
    CALL UCLN        ; Goi ham tim UCLN ra
    MOV BX, AX      ; Luu UCLN vao BX            
    POP AX          ; Lay AX ra
    DIV BX          ; Chia AX cho BX

    POP CX          ; 
    POP BX          ; Khoi phuc cac thanh ghi
    RET             ; Return
BCNN ENDP

END MAIN