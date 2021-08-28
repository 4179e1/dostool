assume cs:code

code segment

start:
    ; ds:si -> src cs:do0
    mov ax,cs
    mov ds,ax
    mov si, offset do0 

    ; es:di -> dest 0000:0200h
    mov ax,0
    mov es, ax
    mov di,200h        

    ; length of transfer
    mov cx, offset do0end - offset do0 

    cld                ; set transfer direction
    rep movsb          ; s: moveb
                       ;    loop s

    ; set Interrupt Vector Table
    ; 0000:0000 -> 0000:0200h
    mov ax, 0
    mov es, ax
    mov word ptr es:[0*4], 200h   ; IP
    mov word ptr es:[0*4 + 2], 0   ; CS


    ; raise an interrupt
    mov ax, 1000h
    mov bh, 0
    div bh

    mov ax, 4c00h
    int 21h

    ; Notice: do0 got copy, and reside in memory
    ; the first 'jmp short' will have address 0000:0200
    ; and 'db "overflow!' will have address 0000:0202
do0:
    jmp short do0start  ; 0000:0200h
    db "overflow!"      ; 0000:0202h

do0start:
    mov ax,0b800H
    mov ds,ax
    
    mov ds:[1a0h], 0230h ;  a0h for 160, the second line, since the first line get wiped out,  0230h: 30 for '0', 02 for attribute
    mov ds:[1a2h], 2430h
    mov ds:[1a4h], 7130h

;    ; ds:si -> src stri
;    mov ax, cs
;    mov ds, ax
;    mov si, 202h   ; hmm?
;
;    ; es:di -> middle of the screenng
;    mov ax, 0b800h
;    mov es, ax
;    mov di, 12*160 + 36*2   
;
;    mov cx, 9 ; string length
;s:
;    mov al,[si]
;    mov es:[di],al
;    inc di
;    mov byte ptr es:[di], 24h;
;    inc di
;    inc si
;    loop s

    mov ax, 4c00h
    int 21h
do0end:
    nop

code ends

end start