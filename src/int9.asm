assume cs:code

stack segment
    db 128 dup(0)
stack ends

data segment
    dw 0, 0
data ends
code segment
start:
    mov ax, stack
    mov ss, ax
    mov sp, 128

    ; save the int 9 routine into data segment
    mov ax, data
    mov ds, ax
    mov ax, 0
    mov es, ax
    push es:[9 * 4]
    pop ds:[0]
    push es:[9 * 4 + 2]
    pop ds:[2]

    ; set a new int 9 routine
    mov word ptr es:[9 * 4], offset int9 ; IP
    mov es:[9 * 4 + 2], cs               ; CS

    mov ax, 0b800h
    mov es, ax
    mov ah, 'a'
s: 
    mov es:[160 * 12 + 40 *2], ah
    call delay
    inc ah
    cmp ah, 'z'
    jna s

    ; restore int 9 routine
    mov ax, 0
    mov es, ax
    push ds:[0]
    pop es:[9 * 4]
    push ds:[2]
    pop es:[9 * 4 + 2]

    mov ax, 4c00h
    int 21h

delay:
    push ax
    push dx
    mov dx, 20h
    mov ax, 0
s1:
    sub ax, 1
    sbb dx, 0
    cmp ax, 0
    jne s1
    cmp dx, 0
    jne s1

    pop dx
    pop ax
    ret


int9:
    push ax
    push bx
    push es
    
    in al, 60h

    ; simulate call old int 9 routine
    pushf
    ; clear TF & IF
    pushf
    pop bx
    and bh, 11111100b ; 0 for TF & IF
    push bx
    popf
    ; call old int 9 routine
    call dword ptr ds:[0]

    ; if it's ESC, change the  color
    cmp al, 1
    jne int9ret

    mov ax, 0b800h
    mov es, ax
    inc byte ptr es:[160 * 12 + 40 * 2 + 1]

int9ret:
    pop es
    pop bx
    pop ax
    iret

code ends
end start