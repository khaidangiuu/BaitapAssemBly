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
    ; doc 1 ki tu
    MOV AH, 1       ; chuan bi doc
    INT 21h         ; ky tu trong AL
    ; if(ky_tu='y')or(ky_tu='Y')
    CMP AL, 'y'     ; ky_tu=y
    JE THEN         ; dung, chuyen den hien thi ki tu
    CMP AL, 'Y'     ; ky_tu='Y'
    JE THEN         ; dung, chuyen den hien thi ki tu
    JMP ELSE_       ; sai, ket thuc chuong trinh
THEN:
    MOV AH, 2       ; chuan bi hien thi
    MOV DL, AL      ; lay ki tu
    INT 21H         ; Hien thi no
    JMP END_IF      ; va thoat ra
ELSE_:
    MOV AH, 4CH
    INT 21H         ; tro ve DOS
END_IF:

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN