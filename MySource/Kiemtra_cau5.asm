.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBao DB 'Ban co muon thoat khong (K/k)$'
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh 
    MOV AH, 09H ;Ham hien chuoi
    LEA DX, TBao ;Lay dia chi TB1
    INT 21H     ;Hien TB1
    
    MOV AH, 01H ; Ham nhap 1 ki tu
    INT 21H     ; Nhap tu ban phim 
    
    ; if(ky_tu='K')or(ky_tu='k')
    CMP AL, 'K'     ; ky_tu=y
    JE THEN         ; dung, chuyen den hien thi ki tu
    CMP AL, 'k'     ; ky_tu='Y'
    JE THEN         ; dung, chuyen den hien thi ki tu
    JMP ELSE_       ; sai, ket thuc chuong trinh
THEN:  
    MOV DL, CR
    INT 21H     ; Ve dau dong 
    JMP BEGIN
    
ELSE_:
    MOV AH, 4CH
    INT 21H         ; tro ve DOS
END_IF:

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN