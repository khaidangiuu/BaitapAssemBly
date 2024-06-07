.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    TieptucSTR DB LF, CR, "Ban co tiep tuc khong? (k/K): $" 
    Hello DB LF, CR, "XIN CHAO: $" 
    char DB 0  
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh  
    
    
    MOV CX, 80     ; so lan ky tu duoc hien thi
    MOV AH, 01H    ; ham nhap 1 ki tu
    INT 21H        ; nhap ky tu tu ban phim
    MOV AH, 02H    ; ham hien 1 ki tu
    MOV DL, AL     ; lay ki tu vua nhap
    ;INT 21H
    
LOOP_: 
    INT 21H        ; hien thi ky tu vua nhap
    LOOP LOOP_     ; lap lai 80 lan
    

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN