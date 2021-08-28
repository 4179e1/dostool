assume cs:code
code segment
start:
        mov ax,0b800H
        mov ds,ax
        
        mov ds:[160 * 1 + 0], 0230h ;  160 * 1 for line 1,  0230h: 30 for '0', 02 for attribute
        mov ds:[160 * 1 + 2], 2430h
        mov ds:[160 * 1 + 4], 7130h

        mov ax,4c00h
        int 21h
code ends
end start