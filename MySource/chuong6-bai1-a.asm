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
    ; if AX<0
    ; Vi du cho AX la so am
    MOV AX, 5       ; AX=5
    NEG AX          ; bu 2 cua 5
    CMP AX, 0       ; AX<0?
    JNL THOAT       ; neu khong thi thoat ra
    ; then
    MOV BX, -1      ; neu nho hon 0 thi BX=-1
    ; ket qua chuong trinh BX=FFFF(-1)

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh tro ve DOS
MAIN ENDP
END MAIN