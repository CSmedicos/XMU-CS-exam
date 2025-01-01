
data segment
    count dw 1
    hour dw 59d
    minute dw 59d
data ends
code segment
main proc far
assume cs:code,ds:data,es:data
start:
    push ds
    sub ax,ax
    push ax
    mov ax,data
    mov ds,ax
    mov es,ax
    mov al,1ch
    mov ah,35h
    int 21h
    push es
    push bx
    push ds

    mov dx,offset cal
    mov ax,seg cal
    mov ds,ax
    mov al,1ch
    mov ah,25h
    int 21h
    pop ds

    sti

    mov di,20000
dec1:
    mov si,30000
dec2:
    dec si
    jnz dec2
    dec di
    jnz dec1

    pop dx
    pop ds
    mov al,1ch
    mov ah,25h
    int 21h
    ret

main endp
cal proc near
    push dx
    push bx
    push cx
    push ax

    dec count
    jnz exit

    sti

    ; mov ah,02h
    ; mov bh,00h
    ; mov dh,00h
    ; mov dl,00h
    ; int 10h

    mov bx,hour
    call display
    mov dl,':'
    mov ah,02h
    int 21h
    mov bx,minute
    call display
    mov bx,minute
    cmp bx,0
    jz jiewei
    dec minute
    jmp exit2
jiewei:
    mov bx,hour
    cmp bx,0
    jz newbegin
    dec hour
    mov bx,59d
    mov minute,bx
    jmp exit2
newbegin:
    mov bx,59d
    mov hour,bx
    mov minute,bx  

exit2:
    mov count,18d
exit:
    cli
    pop ax
    pop cx
    pop bx
    pop dx
    iret
cal endp
display proc near
    mov cx,10d
    call dec_div
    mov cx,1d
    call dec_div
    ret
display endp
dec_div proc near
    mov ax,bx
    mov dx,0
    div cx
    mov bx,dx
    mov dl,al
    mov ah,02h
    add dl,30h
    int 21h
    ret
dec_div endp
code ends
end start