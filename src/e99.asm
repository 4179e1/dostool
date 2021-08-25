assume cs:code,ds:data
 data segment
     db 'welcome to masm!'
     db 02h,24h,71h
 data ends
 code segment
 start:
         mov ax,0b872H
         mov es,ax
         
         mov ax,data
         mov ds,ax
         
         mov bx,0
         mov cx,16
         mov di,0
     s:  
         mov al,ds:[bx]
         mov ah,ds:[18]
         mov es:[di],ax
         inc bx
         add di,2
         loop s
 
         mov ax,4c00h
         int 21h
 code ends
 end start