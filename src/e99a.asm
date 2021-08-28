assume cs:code
code segment
start:
        mov ax,0b800H
        mov ds,ax
        
        mov ds:[9a0h], 0230h ;  a0h for 160, the second line, since the first line get wiped out,  0230h: 30 for '0', 02 for attribute
        mov ds:[9a2h], 2430h
        mov ds:[9a4h], 7130h

        mov ax,4c00h
        int 21h
code ends
end start