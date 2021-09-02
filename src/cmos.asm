assume cs:code
code segment
start:
    mov al, 8      ; address 8 for month, BCD code
    out 70h, al    ; 70 address port
    in al, 71h     ; 71 data port

    mov ah, al
    mov cl, 4
    shr ah, cl          ; high 4 bit: right shift by 4
    and al, 00001111b   ; lower 4 bit: mask

    add ah, 30h     ; BCD to ascii
    add al, 30h

    mov bx, 0b800h
    mov es, bx

    mov byte ptr es:[160*12 + 40 * 2], ah
    mov byte ptr es:[160*12 + 40 * 2 + 2], al

    mov ax, 4c00h
    int 21h

code ends
end start