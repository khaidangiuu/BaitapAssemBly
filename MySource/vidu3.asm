.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TB1 DB 'Chao cac ban! $'
    TB2 DB 'Ten toi la: Thao Dinh Khai. $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh 
    MOV AH, 09H ;Ham hien chuoi
    LEA DX, TB1 ;Lay dia chi TB1
    INT 21H     ;Hien TB1 
    
    MOV AH, 02H ; Ham in ra 1 ki tu
    MOV DL, LF
    INT 21H     ; Xuong dong
    MOV DL, CR
    INT 21H     ; Ve dau dong 
    
    MOV AH, 09H ;Ham hien chuoi
    LEA DX, TB2 ;Lay dia chi TB2
    INT 21H     ;Hien TB2   
THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN