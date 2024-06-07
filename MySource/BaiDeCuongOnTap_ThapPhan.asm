.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBAO1 DB LF, CR, "Moi nhap M: $"
    TBAO2 DB LF, CR, "Moi nhap N: $"
    TBAO3 DB LF, CR, "Tong S1=1+2+...+N: $"
    TBAO4 DB LF, CR, "Ban co thoat khong? (k/K) $"
    TBAO5 DB LF, CR, "Tong S2=1^2+2^2+...+N^2: $" 
    TBAO6 DB LF, CR, "Tong S3=1*M+2*M+...+N*M: $"
    TBAO7 DB LF, CR, "Tong cac so le nho hon N, S4= $"
    TBAO8 DB LF, CR, "Tong cac so chan nho hon N, S5= $"
    TBAO9 DB LF, CR, "(S6<N)&&(S6%M==0): $"    
    TBAO10 DB LF, CR, "S10.Tim A sao cho S10=1+2+...+A>N. A= $"
    TBAO11 DB LF, CR, "S7.Uoc chung lon nhat cua M và N: $"
    TBAO12 DB LF, CR, "S8.Boi chung nho nhat cua M va N: $"
    TBAO13 DB LF, CR, "S9.M mu N = $"
    M DW ?
    N DW ?
    SUM DW ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh
; In ra thong bao nhap so M
    MOV AH, 09H
    LEA DX, TBAO1
    INT 21H 
    CALL INDEC
    MOV M, AX  
    PUSH AX

; In ra thong bao nhap so N
    MOV AH, 09H
    LEA DX, TBAO2
    INT 21H 
    CALL INDEC
    MOV BX, AX 
    MOV N, BX 
    PUSH BX
; In ra tong S1=1+2+...+N  
    MOV AH, 09H
    LEA DX, TBAO3
    INT 21H 
    POP BX 
    POP AX 
    CALL S1
    CALL OUTDEC
; In ra tong S2=1^2+2^2+...+N^2    
    MOV AH, 09H
    LEA DX, TBAO5
    INT 21H 
    CALL S2
    CALL OUTDEC
;In ra tong S3=1*M+2*M+...+N*M    
    MOV AH, 09H
    LEA DX, TBAO6
    INT 21H 
    CALL S3
    CALL OUTDEC
; In ra tong cac so le nho hon N    
    MOV AH, 09H
    LEA DX, TBAO7
    INT 21H 
    CALL S4
    CALL OUTDEC
; In ra tong cac so chan nho hon N    
    MOV AH, 09H
    LEA DX, TBAO8
    INT 21H 
    CALL S5
    CALL OUTDEC 
; In ra tong cac so nho hon N ma chia het cho M   
    MOV AH, 09H
    LEA DX, TBAO9
    INT 21H 
    CALL S6
    CALL OUTDEC 
    ; In ra so nguyen A sao cho 1+2+..+A>N   
    MOV AH, 09H
    LEA DX, TBAO11
    INT 21H 
    CALL S7
    CALL OUTDEC
    ; In ra so nguyen A sao cho 1+2+..+A>N   
    MOV AH, 09H
    LEA DX, TBAO12
    INT 21H 
    CALL S8
    CALL OUTDEC
    ; In ra so nguyen A sao cho 1+2+..+A>N   
    MOV AH, 09H
    LEA DX, TBAO13
    INT 21H 
    CALL S9
    CALL OUTDEC   
; In ra so nguyen A sao cho 1+2+..+A>N   
    MOV AH, 09H
    LEA DX, TBAO10
    INT 21H 
    CALL S10
    CALL OUTDEC
; In ra thong bao co thoat khong    
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

S1 PROC
    PUSH BX
    PUSH CX         ; Cat thanh ghi
    XOR AX, AX      ; xoa AX
    MOV BX, 1       ; Phan tu dau tien
    MOV CX, N       ; for N lan
LAPS1:
    ADD AX, BX      ; AX = AX+BX
    INC BX          ; BX = BX+1
    LOOP LAPS1    ; Lap lai
    POP CX
    POP BX          ; Khoi phuc thanh ghi
    RET             ; Return
S1 ENDP 

S2 PROC
    PUSH BX
    PUSH CX         ; Cat thanh ghi
    XOR AX, AX      ; xoa AX 
    MOV SUM, 0      ; Cho bien Sum = 0 de luu tong
    MOV BX, 1       ; Phan tu dau tien
    MOV CX, N       ; for N lan
LAPS2:        
    CMP BX, CX      ; So sanh BX>CX?
    JG THOIS2       ; Dung => Ket thuc lap
    MOV AX, BX      ; AX = AX+BX
    MUL BX          ; AX=AX*BX 
    ADD SUM, AX     ; Dua tong vao Sum de luu
    INC BX          ; BX = BX+1
    JMP LAPS2    ; Lap lai 
THOIS2:           
    MOV AX, SUM     ; Chuyen bien Sum vao AX de hien thi
    POP CX
    POP BX          ; Khoi phuc thanh ghi
    RET             ; Return
S2 ENDP  

S3 PROC
    PUSH BX
    PUSH CX         ; Cat thanh ghi  
    MOV SUM, 0      ; Cho bien Sum=0 de luu tong
    MOV AX, 1       ; Cho AX=1 la phan tu dau tien
    MOV BX, M       ; 
    MOV CX, N       ; for N lan 
LAPS3: 
    CMP AX, CX      ; So sanh AX>CX?
    JG THOIS3       ; Dung =>Ket thuc, hien thi ket qua
    PUSH AX         ; Cat gia tri trong AX di
    MUL BX          ; AX=AX*BX(S=1*M)
    ADD SUM, AX     ; Dua SUM+=AX vao bien SUM de luu
    POP AX          ; Lay gia tri trong AX ra
    INC AX          ; AX = BX+1
    JMP LAPS3       ; Lap lai 
THOIS3:
    MOV AX, SUM     ; Tra lai tong cho AX de hien thi
    POP CX
    POP BX          ; Khoi phuc thanh ghi
    RET             ; Return
S3 ENDP   

S4 PROC
    PUSH BX
    PUSH CX         ; Cat thanh ghi
    MOV SUM, 0      ; Cho bien tong = 0
    MOV BX, 1       ; Phan tu dau tien
    MOV CX, N       ; for N lan
LAPS4:
    
    CMP BX, CX      ; So sanh BX>=CX?
    JGE THOIS4      ; Dung => Ket thuc

    MOV AX, BX
    AND AX, 1       ; Kiem tra xem co phai so chan khong
    JZ SoChan       ; Dung => nhay sang lable sochan

    MOV AX, BX      ; Neu la so le thi dua vao AX
    ADD SUM, AX     ; Them AX vao Sum, SUM+=AX
SoChan:
    INC BX          ; BX++
    JMP LAPS4       ; Lap lai
THOIS4:
    MOV AX, SUM     ; Dua biem SUM tro lai AX de hien thi
    POP CX
    POP BX          ; Khoi phuc cac thanh ghi
    RET             ; return
S4 ENDP

S5 PROC
    PUSH BX
    PUSH CX         ; Cat thanh ghi
    MOV SUM, 0      ; Cho bien tong = 0
    MOV BX, 1       ; Phan tu dau tien
    MOV CX, N       ; for N lan
LAPS5:
    
    CMP BX, CX      ; So sanh BX>=CX?
    JGE THOIS5      ; Dung => Ket thuc

    MOV AX, BX
    AND AX, 1       ; Kiem tra xem co phai so chan khong
    JNZ SoLe        ; Sai => nhay sang lable sole 
    MOV AX, BX      ; Neu la so chan thi dua vao AX
    ADD SUM, AX     ; Them AX vao Sum, SUM+=AX
    
SoLe:
    INC BX          ; BX++
    JMP LAPS5       ; Lap lai
    
THOIS5:
    MOV AX, SUM     ; Dua biem SUM tro lai AX de hien thi
    POP CX
    POP BX          ; Khoi phuc cac thanh ghi
    RET             ; return
S5 ENDP   

S6 PROC
    PUSH BX
    PUSH CX
    PUSH DX         ; Cat thanh ghi

    MOV SUM, 0      ; Khoi tao SUM bang 0
    MOV AX, 1       ; Khoi tao DX bang 1 (bien dem vong lap)
    MOV BX, M       ; Nap M vao BX
    MOV CX, N       ; Nap N vao CX (gioi han tren)

LAPS6:
    CMP AX, CX
    JGE THOIS6      ; Neu AX >= CX, nhay den THOIS6

    XOR DX, DX      ; Xoa DX truoc khi DIV de tranh tran 
    PUSH AX         ; Cat AX di vi sao khi chia se anh huong
    DIV BX          ; AX/BX -> thuong trong AX, so du trong DX

    CMP DX, 0       ; Kiem tra neu so du bang 0
    JNE K_CHIA_HET  ; Neu khong bang 0, nhay den K_CHIA_HET
    POP AX          ; Khoi phuc lai gia tri cua AX
    ADD SUM, AX     ; Neu chia het, cong thuong vao SUM
    PUSH AX
K_CHIA_HET:
    POP AX          ; Khoi phuc lai gia tri cua AX
    INC AX          ; Tang bien dem vong lap
    JMP LAPS6       ; Lap lai vong lap

THOIS6:
    MOV AX, SUM     ; Chuyen SUM vao AX de tra ve gia tri
    POP DX
    POP CX
    POP BX          ; Khoi phuc lai thanh ghi
    RET
S6 ENDP

; Ham tim uoc chung lon nhat
; Vao: M, N
; Ra: AX = UCLN
S7 PROC
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
S7 ENDP
; Ham tim boi chung nho nhat
; Vao: M, N
; Ra: AX = BCNN
S8 PROC
    PUSH BX         ;
    PUSH CX         ; Cat cac thanh ghi

    MOV AX, M       ; Dat AX = M
    MOV BX, N       ; Dat BX = N

    ; Tinh boi so chung nho nhat 
    ; Cong thuc LCM(M,N)=(M*N)/gcd(M,N)
    
    MUL BX          ; Nhan AX voi BX <=> M*N 
    PUSH AX         ; Cat AX di
    CALL S7        ; Goi ham tim UCLN ra
    MOV BX, AX      ; Luu UCLN vao BX            
    POP AX          ; Lay AX ra
    DIV BX          ; Chia AX cho BX

    POP CX          ; 
    POP BX          ; Khoi phuc cac thanh ghi
    RET             ; Return
S8 ENDP

; M^N
; Vao: M va N
; Ra: BX = Ket qua cua m^n
S9 PROC
    PUSH BX
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
    POP CX
    POP BX          ; Khoi phuc thanh ghi
    RET             ; Return
S9 ENDP

S10 PROC
    PUSH CX         ; Cat thanh ghi
    MOV SUM, 0      ; Cho bien tong = 0
    XOR AX, AX      ; Cho AX=0 de luu gia tri can tim
    MOV CX, N       ; for N lan
LAPS10:
    
    CMP SUM, CX      ; So sanh SUM>N?
    JG THOIS10       ; Dung => Ket thuc 
    INC AX           ; Sai => AX++
    ADD SUM, AX      ; Them AX vao Sum, SUM+=AX
    JMP LAPS10       ; Lap lai
    
THOIS10:
    POP CX          ; Khoi phuc cac thanh ghi
    RET             ; return
S10 ENDP

END MAIN