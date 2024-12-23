jmp main

a db 0
b db 0 
c db 0
temp_b db b 
count db 0
ans db 0    

open_msg db 10,13,"               Welcome to the Quadratic formula calculator $ "
open2_msg db 10,13," Enter 3 numbers and we will do the calculation for you $"  ;open messeges
input1_msg db 10,13," Enter the First number a: $"
input2_msg db 10,13," Enter the Second number b: $"
input3_msg db 10,13," Enter the Third number c: $" ;input messeges
new_line db 10,13," $"
wrong_input_msg db 10,13, " wrong input ( enter number 1 - 9 )$"
one_answer db 10,13," there is one answer: $"
two_answers db 10,13," there are 2 answers: $"
zero_answers db 10,13, " there are no answers with the a,b,c given $"


PROC power2_temp_b; the function puts b to hte power of 2 b*b
    pusha
    mov al, [temp_b]
    mov ah,0 
    mul ax      
    mov [temp_b], al 
    popa
    ret
ENDP power2_temp_b
    
print_ax proc
cmp ax, 0
jne print_ax_r
    push ax
    mov al, '0'
    mov ah, 0eh
    int 10h
    pop ax
    ret 
print_ax_r:
    pusha
    mov dx, 0
    cmp ax, 0
    je pn_done
    mov bx, 10
    div bx    
    call print_ax_r
    mov ax, dx
    add al, 30h
    mov ah, 0eh
    int 10h    
    jmp pn_done
pn_done:
    popa  
    ret  
endp


PROC open_start; the function prints the start messeges  
    
    mov dx, offset open_msg
    mov ah, 9h
    int 21h 
    
    mov dx, offset open2_msg
    mov ah, 9h
    int 21h
    
    
    ret
ENDP open_start    

input PROC
    jmp first                                   
    start:
        mov dx, offset wrong_input_msg
        mov ah, 9h
        int 21h
    first:
    
        mov ah, 1        
        int 21h          
        cmp al, '0'      
        jb start
                 
        cmp al, '9'      
        ja start
                
        sub al, '0'      
    ret
input ENDP
              
PROC check_under_root

    call power2_temp_b
    
    
    
    
    
    
ret
ENDP check_under_root

main: 
    call open_start
    
    mov dx, offset input1_msg
    mov ah, 9h
    int 21h
    call input
    mov a,al
             
    mov dx, offset input2_msg
    mov ah, 9h
    int 21h
    call input
    mov b,al
             
    mov dx, offset input3_msg
    mov ah, 9h
    int 21h
    call input
    mov c,al
    
    
    
    
    
    
    
    

    end:
        mov ah, 4Ch
        int 21h                   
        



;             ax^2+bx+c
;   |-------------------------------|
;   |       -b +- sqrt(b^2 - 4*a*c) |
;   |X1,2=  ----------------------- |
;   |                 2a            |
;   |-------------------------------|
