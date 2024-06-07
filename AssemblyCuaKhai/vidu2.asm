.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TB1 DB 'Hay go vao 1 chu cai thuong: $'
    TB2 DB 'Chu cai hoa tuong ung la: $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh 
    MOV AH, 09H ;Ham hien chuoi
    LEA DX, TB1 ;Lay dia chi TB1
    INT 21H     ;Hien TB1
    
    MOV AH, 01H ; Ham nhap 1 ki tu
    INT 21H     ; Nhap tu ban phim 
    MOV BL, AL  ; Luu ky tu vua nhap 
    
    MOV AH, 02H ; Ham in ra 1 ki tu
    MOV DL, LF
    INT 21H     ; Xuong dong
    MOV DL, CR
    INT 21H     ; Ve dau dong 
    
    MOV AH, 09H ;Ham hien chuoi
    LEA DX, TB2 ;Lay dia chi TB2
    INT 21H     ;Hien TB2   
    
    MOV DL, BL  ; Lay ky tu vua nhap
    SUB DL, 32  ; Doi ra chu HOA
    MOV AH, 02  ; Ham in ra 1 ky tu
    INT 21H     ; In ra

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN