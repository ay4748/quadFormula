jmp main

a db 0
b db 0 
c db 0
temp_b  db 0 
count db 0
ans dw 0    
four_ac dw 0
temp db 0
basis db 0
underSquare db 0  
ans1 db 0
ans2 db 0
 

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
a_pretty db " a =  $"
b_pretty db " b =  $"
c_pretty db " c =  $"

           
PROC print_abc_pretty
    
    
    ret
 
ENDP print_abc_pretty


PROC square_root
    mov al, basis    
    mov bl, 1        
    mov cl, 0      

	square_loop:
		mov ah, 0        
		mov al, bl    
		mov dl, 2
	again:
		mul bl
		dec dl 
		cmp dl, 1
		ja  again
		
	
    cmp al, basis      
	ja square_done  
    mov cl, bl     
    inc bl         
    jmp square_loop  

	square_done:
		mov al, cl
		mov underSquare,al
		ret
ENDP square_root


PROC power2_temp_b
    pusha                  
    mov al, [b]            
    mov [temp_b], al      
    mov al, [temp_b]       
    mul al                
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
    mov al, [temp_b]     
    mov ah,0           
    mov [ans], ax                   

    pusha                            

    mov ax, 4                        
    mul [a]                          
    mul [c]                          

    mov [four_ac], ax
    
    mov ax, [ans]                   
    sub ax, [four_ac]
    js none
    jz one_ans
    cmp ax,0
    ja two_anwers            
    mov [ans], ax                    
    
    none:
        mov dx, offset zero_answers                                     
        mov ah, 9h
        int 21h
        
        jmp end_Proj
        
    one_ans:
       mov dx, offset one_answer
       mov ah, 9h
       int 21h
       pusha
       
       mov cl, a       ; Load a into cl
       add cl, cl      ; Compute 2 * a

       mov al, b       ; Load b into al
       mov ah, 0       ; Clear high byte of ax for division

       div cl          
       
       mov temp,al
       
               
       mov dl,'-'
       mov ah,2
       int 21h
       
       
       
       mov ah,0
       mov al,temp
       call print_ax  
       popa
       
       jmp end_func
       
    
   two_anwers:
       mov dx, offset two_answers
       mov ah, 9h
       int 21h
       
       
       
       call square_root
       mov ah,0
       mov ans,ax
       
       mov cl,b
       
       
       mov temp_b,cl
       neg temp_b
       
       mov cl,temp_b
       
       mov ans1,cl
       mov ans2,cl
       
       
       
       ;add ans1,ans     
       
       
       
       
       
  ;             ax^2+bx+c
;   |-------------------------------|
;   |       -b +- sqrt(b^2 - 4*a*c) |
;   |X1,2=  ----------------------- |
;   |                 2a            |
;   |-------------------------------|
     
        
              
              
              
      
       
           
   ;x = (x + n / x) / 2;     
    
                 
   
    end_func:
        popa                             
        ret

ENDP check_under_root

main: 
    call open_start
   
    mov dx, offset input1_msg
    mov ah, 9h
    int 21h
    call input
    mov a,al
    
    
    cmp al,0
    jne cont
    
    mov dx, offset zero_answers
    mov ah, 9h
    int 21h
    jmp end_Proj
    
    
    cont:          
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
        
        
        call check_under_root
        
    
    
    
    

    end_proj: 
    
        mov ah,1
        int 21h
        mov ah, 4Ch
        int 21h
        ret                   
        



