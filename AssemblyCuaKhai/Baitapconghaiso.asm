.MODEL Small
.STACK 100h
.DATA
;khai bao bien va hang
    LF EQU 10
    CR EQU 13
    Tong DB  "Tong cua x va y la z$"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX ; khoi tao DS
BATDAU:
; Cac cau lenh cua chuong trinh   
    MOV AH, 02H     ; Ham 02 hien thi 1 ki tu
    mov dl, '?'
    int 21h         ; Hien thi dau '?'
    
    mov ah, 01h     ; Ham 01 nhap 1 ki tu
    int 21h         ; Nhap so thu 1
    lea bx, Tong    ; Lay dia chi bien tong
    mov [bx]+9, al  ; Luu so vua nhap vao vi tri x
    INT 21H         ; Nhap so thu 2
    mov [bx]+14, al ; Luu vao vi tri y 
    
    sub al, 30h     ; AL-48
    mov ah, [bx]+9
    sub ah, 30h     ; AL+48     
    
    add al, ah
    add al, 30h
    mov [bx]+19, al
    
    ;add al, [bx]+9  ; Tinh tong AL = y+x
    ;mov [bx]+19, al ; Luu vao z
    
    mov ah, 02h     ; Hien 1 ki tu
    mov dl, lf      
    int 21h         ; Xuong dong
    mov dl, cr
    int 21h         ; Ve dau dong
    
    mov ah, 09h     ; Ham hien 1 xau ki tu
    lea dx, Tong
    int 21h         ; Hien thi Tong

THOAT:
    MOV AH, 4Ch
    INT 21H ;Ket thuc chuong trinh
MAIN ENDP
END MAIN