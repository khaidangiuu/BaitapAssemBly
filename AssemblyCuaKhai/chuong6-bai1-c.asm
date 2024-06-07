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
    ;doc 1 ki tu
    MOV AH, 1       ; chuan bi doc
    INT 21H         ; ki tu vao AL
    ; if('A'<=DL) and (DL<='Z')
    CMP AL, 'A'     ; AL>A
    JL END_IF      ; dk khong dung thi thoat ra
    CMP AL, 'Z'     ; AL<=Z
    JG END_IF      ; dk khong dung thi thoat ra
    ; then hien thi ki tu
    MOV DL, AL      ; lay ki tu vao DL de hien thi
    MOV AH, 2       ; chuan bi hien thi
    INT 21h         ; hien thi ki tu
END_IF:

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN