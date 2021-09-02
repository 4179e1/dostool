assume cs:code

code segment
start:
    ; ds:si -> src routinue
    mov ax, cs
    mov ds, ax
    mov si, offset sqr

    ; es:di -> dest 0000:0200h
    mov ax,0
    mov es,ax
    mov di,200h

    ; cs: length
    mov cx, offset sqrend - offset sqr
    cld

    rep movsb

    ; setup Interupt Vector Table
    ; Intr 7ch [0000:7ch * 4] -> 0000:0200
    mov ax, 0
    mov es, ax
    mov word ptr es:[7ch * 4], 200h     ; IP: 0200h
    mov word ptr es:[7ch * 4 + 2], 0    ; CS: 0000h


    ; test 2 * 3456 ^2
    mov ax, 3456
    int 7ch
    ; should get routinue result here
    add ax, ax
    adc dx, dx

    mov ax, 4c00h
    int 21h

sqr:
    mul ax
    iret
sqrend:
    nop


code ends
end start