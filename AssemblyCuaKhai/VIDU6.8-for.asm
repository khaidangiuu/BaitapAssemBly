.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TieptucSTR DB LF, CR, "Ban co tiep tuc khong? (k/K): $" 
    Hello DB LF, CR, "XIN CHAO: $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh   
    MOV CX, 80     ; so cac sao duoc hien thi
    MOV AH, 2      ; ham hien thi ki tu
    MOV DL, '*'    ; ki tu hien thi
TOP:
    INT 21H        ; hien thi 1 dau sao
    LOOP TOP       ; lap lai 80 lan

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN