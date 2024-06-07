.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TBao1 DB "Neu ban nhap A $" 
    TBao2 DB "Neu ban nhap B $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh   
    ; doc 1 ky tu
    MOV AH, 01H     ; ham nhap 1 ky tu
    INT 21H         ; nhap 1 ky tu tu ban phim 
    ;case AX
    CMP AL, 'A'     ; so sanh voi A
    JE A_           ; neu bang A => chuyen den A_:
    CMP AL, 'B'     ; so sanh voi B
    JE B_           ; neu dung chuyen den B_:
    JMP THOAT       ; neu sai thi thoat
A_:
    MOV AH, 02H     ; Ham hien thi 1 ki tu
    MOV DL, CR
    INT 21H         ; Ve dau dong 
    
    MOV AH, 09H     ; Ham hien thi 1 chuoi ki tu
    LEA DX, TBao1
    INT 21H         ; Hien thi Tbao1
    JMP THOAT       ; Thoat ra khoi BIOS
B_:
    MOV AH, 02H     ; Ham hien thi 1 ki tu
    MOV DL, LF
    INT 21H         ; xuong dong  
    
    MOV AH, 09H     ; Ham hien thi chuoi ki tu
    LEA DX, TBao2
    INT 21H         ; In thong bao cua TBao2
    

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN