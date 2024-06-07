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
    ;case AX
    CMP AX, 0    ; kiem tra AX
    JL NEGATIVE  ; AX<0
    JE ZERO      ; AX=0
    JG POSITIVE  ; AX>0
NEGATIVE:
    MOV BX, -1   ; nhap -1 vao BX
    JMP THOAT    ; roi thoat ra
ZERO:
    MOV BX, 0    ; nhap 0 vao BX
    JMP THOAT    ; roi thoat ra
POSITIVE:
    MOV BX, 1   ; nhap 1 vao BX

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN