.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10          ; xuong dong
    CR EQU 13          ; tro ve dau xong
    TieptucSTR DB LF, CR, "Ban co tiep tuc khong? (k/K): $" 
    Hello DB LF, CR, "XIN CHAO: $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BEGIN:
; Cac cau lenh cua chuong trinh
    ;if AX<BX  
    MOV AX, 3
    MOV BX, 4
    MOV CX, 5
    CMP AX, BX     ; AX < BX?
    JGE END_IF     ; Khong, thi thoat ra 
    ; then if BX<CX
    CMP BX, CX     ; BX < CX?
    JGE ELSE_      ; khong thi thuc hien else
    ; then
    MOV AX, 0
    JMP THOAT
ELSE_:
    MOV BX, 0
END_IF:

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN