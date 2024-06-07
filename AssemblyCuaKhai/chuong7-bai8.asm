.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TieptucSTR DB LF, CR, "Ban co tiep tuc khong? (C/K): $"
    TB1 DB LF, CR, "Nhap vao mot ki tu: $"
    TB2 DB LF, CR, "Ma ASCII cua ki tu duoi dang nhi phan: $"
    TB3 DB LF, CR, "So bit 1 trong ma ASCII la: $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS

BEGIN:
    ; Hien thi yeu cau nhap ki tu
    MOV AH, 9       ; ham hien thi chuoi ki tu
    LEA DX, TB1
    INT 21h         ; in ra chuoi TB1
    
    ; Nhap ki tu
    MOV AH, 1       ; ham nhap 1 ki tu tu ban phim
    INT 21h         ; nhap 1 ki tu
    MOV BL, AL      ; BL chua ki tu nhap vao

    ; In ma ASCII cua ki tu duoi dang nhi phan
    MOV AH, 9       ; ham hien thi chuoi ki tu
    LEA DX, TB2
    INT 21h         ; in ra TB2

    ; In ma ASCII duoi dang nhi phan
   
    MOV CX, 16      ; Bien dem vong lap
    MOV AH, 2       ; Ham hien thi 1 ki tu
Print:
    ROL BX, 1       ; Quay trai BX => CF=MSB
    MOV DL, 0       ; DL=0
    ADC DL, 30H     ; DL=0+48+CF
    INT 21H         ; in ki tu trong DL
    LOOP Print      ; Lap lai 16 lan

    ; Tinh so bit 1 trong ma ASCII
    MOV AH, 0
    MOV AL, BL      ; AL chua ky tu nhap vao
    MOV CX, 8       ; Duyet qua moi bit trong byte
    XOR BX, BX      ; Reset BX la 0 de dem so bit
Dem:
    TEST AL, 1      ; Kiem tra bit thap nhat
    JNZ Tang        ; Neu bit thap nhat là 1, nhay den Tang
    SHR AL, 1       ; Dich phai 1 bit
    LOOP Dem        ; Lap lai cho các bit còn l?i
    JMP Dem_xong
Tang:
    INC BX          ; Tang BX lên 1 
    SHR AL, 1       ; Dich phai 1 bit
    LOOP Dem        ; Lap lai cho các bit con lai
Dem_xong:
    ; In so bit 1
    MOV AH, 9       ; ham hien chuoi ki tu
    LEA DX, TB3
    INT 21h         ; in ra TB3

    ; In so bit 1 trong BX
    MOV AH, 2       ; ham hien ki tu
    ADD BL, 30h     ; BL=BL+30h
    MOV DL, BL      ; dua BL và DL de in ra
    INT 21h         ; in ra DL

    ; Hoi nguoi dung co muon tiep tuc khong
    MOV AH, 9
    LEA DX, TieptucSTR
    INT 21h

    ; neu nhap 'C' thi tiep tuc, 'K' thi thoat
    MOV AH, 1
    INT 21h
    CMP AL, 'C'
    JE BEGIN
    CMP AL, 'K'
    JE THOAT

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trình
MAIN ENDP
END MAIN
