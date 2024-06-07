.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TieptucSTR DB LF, CR, "Ban co tiep tuc khong? (k/K): $" 
    TB1 DB "Nhap so thu nhat: $"
    TB2 DB "Nhap so thu hai: $"
    TB3 DB "Tong cua hai so la: $"
    TB4 DB "Hieu cua 10 va Tong cua hai so la: $"
    ; Khai bao bien
    A DB ?
    B DB ?
    C DB ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh  
    MOV AH, 09H     ; ham hien xau ki tu
    LEA DX, TB1
    INT 21H         ; ham hien thong bao nhap so thu nhat
    MOV AH, 01H     ; ham nhap 1 ki tu
    INT 21H         ; nhap so thu nhat
    SUB AL, 30H     ; doi chu so thanh so
    MOV A, AL       ; luu lai so thu nhat
    
    MOV AH, 09H     ; ham hien xau ki tu
    LEA DX, TB2
    INT 21H         ; ham hien thong bao nhap so thu hai
    MOV AH, 01H     ; ham nhap 1 ki tu
    INT 21H         ; nhap so thu hai
    SUB AL, 30H     ; doi chu so thanh so
    MOV B, AL       ; luu lai so thu nhat  
    
    MOV AH, 09H     ; ham hien thi xau
    LEA DX, TB3
    INT 21H         ; hien thi thong bao tong
    
    MOV AH, 09H
    MOV DL, A
    ADD DL, B
    ADD DL, 30H
    INT 21H      
    
    MOV DX, 0
WHILE_:
    CMP B, A
    JL THOAT:
    INC DX
    SUB A, B
    JMP WHILE_: 
    
    

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN 