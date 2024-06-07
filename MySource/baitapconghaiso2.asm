.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    Tong DB  "Tong cua "
    x DB ?
    tb1 DB " va "
    y DB ?
    tb2 DB " la "
    z DB ?
    tb3 DB "$"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BATDAU:
; Cac cau lenh cua chuong trinh   
    MOV AH, 02H     ; Ham 02 hien thi 1 ki tu
    MOV DL, '?'
    INT 21H         ; Hien thi dau '?'
    
    MOV AH, 01H     ; Ham 01 nhap 1 ki tu
    INT 21H         ; Nhap so thu 1
    LEA BX, Tong    ; Lay dia chi bien tong
    MOV x, AL  ; Luu so vua nhap vao vi tri x
    INT 21H         ; Nhap so thu 2
    MOV y, AL ; Luu vao vi tri y 
    
    SUB AL, 30H     ; AL-48
    MOV AH, x
    SUB AH, 30H     ; AL+48     
    
    ADD AL, AH
    ADD AL, 30H
    MOV z, AL
    
    ;add al, [bx]+9  ; Tinh tong AL = y+x
    ;mov [bx]+19, al ; Luu vao z
    
    MOV AH, 02H     ; Hien 1 ki tu
    MOV DL, LF      
    INT 21H         ; Xuong dong
    MOV DL, CR
    INT 21H         ; Ve dau dong
    
    MOV AH, 09H     ; Ham hien 1 xau ki tu
    LEA DX, Tong
    INT 21H         ; Hien thi Tong

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN