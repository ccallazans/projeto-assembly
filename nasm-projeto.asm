
%include "io.inc"

section .data
    string1 db "Qual e a importancia da escola na democratizacao da sociedade", 0;
    len_string1 equ $- string1
    
    msg_a db "a -> ", 0
    msg_m db "m -> ", 0

section .bss
    buffer_string1: resb len_string1
    buffer_string2: resb len_string1
    buffer_string3: resb len_string1
    buffer_string4: resb len_string1
    vetor: resb 36

section .text
global CMAIN

CMAIN:
    mov ebp, esp    ; for correct debugging
    xor eax, ebx
    
    call questao_1
    call questao_2
    call questao_3
    call questao_4
    call questao_5
    call questao_6
    call questao_7
    ret

questao_1:
    mov ecx, 41             ; Posição da string para parar o loop
    mov esi, string1 + 7    ; Mover a "string1" deslocado de 7 bytes para recortar o "Qual e "
    mov edi, buffer_string1 ; Mover o "buff_string1" para receber os bytes de "string1"
    cld                     ; Setar zf=0 para incrementar as posições de esi e edi
    rep movsb               ; Repetir a operação até ecx=0, "move string byte"
    
    PRINT_STRING buffer_string1
    NEWLINE
    ret
                    

questao_2:
    mov ecx, 41 ; Tamanho da string
    mov bl, 0   ; Zerar bl para contar 'm'
    mov bh, 0   ; Zerar bh para contar 'a'
    
    loop2:
        contar_m:
            cmp byte [buffer_string1 + ecx], 'm'    ; Se o último caractere é igual a 'm'
            jne contar_a    ; Caso contrário, pular para "contar_a"
            
            inc bl          ; Incrementar valor encontrado
            jmp atualizar   ; Pular para "atualizar"
            
        contar_a:
            cmp byte [buffer_string1 + ecx], 'a'    ; Se o último caractere é igual a 'a'
            jne atualizar   ; Caso contrário, pular para "atualizar"
            
            inc bh          ; Incrementar valor encontrado
            
        atualizar:    
            dec ecx     ; Decrementar eax, já que estamos lendo do final da string até o começo
            cmp ecx, 0  ; Se ecx é igual a 0
            jne loop2   ; Caso contrário, pular para "loop2"
        
    PRINT_STRING msg_m
    PRINT_DEC 2, bl
    NEWLINE  
   
    PRINT_STRING msg_a
    PRINT_DEC 2, bh
    NEWLINE  
        
    ret


questao_3:
    mov ecx, 41 ; Tamanho da string
    mov esi, buffer_string1 
    mov edi, buffer_string2
    
    loop3:
        cld         ; Setar zf=0 para incrementar as posições de esi e edi
        lodsb       ; Load string byte -> mover cada caractere do esi para ax
        push ax     ; mover o caractere de ax para a pilha
        
        dec ecx     ; decrementar ecx
        cmp ecx, 0  ; Se ecx é igual a 0
        jne loop3   ; Caso contrário, pular para "loop3"
        
    loop3_2:
        pop ax      ; Retirar o caractere do topo da pilha para ax
        cld         ; Setar zf=0 para incrementar as posições de esi e edi
        stosb       ; Mover o caractere de ax para a posição em edi
        
        inc ecx     ; Incrementar ecx
        cmp ecx, 41 ; Se ecx é igual a 41
        jne loop3_2 ; Caso contrário, pular para "loop3_2"
           
        
    PRINT_STRING buffer_string2   
    NEWLINE
    ret


questao_4:
    mov ecx, 41 ; Tamanho da string
    mov esi, buffer_string1 
    mov edi, buffer_string3
    
    loop4:
        cld         ; Setar zf=0 para incrementar as posições de esi e edi
        lodsb       ; Load string byte -> mover cada caractere do esi para ax
        cmp al, " " ; Se ax é igual a " "
        je pass     ; Caso igual, pular para "pass"
        adicionar:
            stosb    ; Mover o caractere de ax para a posição em edi
            
        pass:
        
        
        dec ecx     ; decrementar ecx
        cmp ecx, 0  ; Se ecx é igual a 0
        jne loop4   ; Caso contrário, pular para "loop4"
        
    PRINT_STRING buffer_string3  
    NEWLINE 
    ret
        

questao_5:
    mov ebx, buffer_string1 ;ebx é um ponteiro para string1
    mov edx, 2
   
    loop5:
        mov al,[ebx]        ;movendo um caractere para al
        cmp al,0            ;se for o caractere null
        je done             ;pular para done
       
        cmp al," "          ;se al é um espaço
        je space            ; se é igual pula para space
    
        cmp edx,0           ;se edx é 0
        jg atualiza5       ;se não é zero pula para atualiza5
        jle pass5            ;se é 0 pula para pass5
        
    atualiza5:
        add al,'A'-'a'      ;converter para maiúsculas
        PRINT_CHAR al       ;Imprime a letra
        inc ebx             ;Incrementa o ebx
        dec edx             ;decrementa o edx
  
        cmp al,0            ;se chegou ao fim da string1
        jne loop5           ;se não chegou ao fim pula para loop5
 
    pass5:
       PRINT_CHAR al        ;imprime as letras minusculas
       dec edx
       inc ebx              ; incrementa ebx
       
       cmp edx, -3            ;se eax é 0   
       jne loop5            ;se é maior pela para pass5
       je zera              ;se é zero pela para zera
        
    zera:
        ;mov eax,3          
        mov edx,2           ;mov 2 para edx para recomeçar 
        jmp loop5           ;voltar para loop5
             
    space:
        PRINT_CHAR al      ;imprimir a letra em al
        inc ebx            ;pula para a proxima posição da string
        cmp al,0           ; se al é 0
        jne loop5          ; se não é zero volta para o loop5
    done:
        NEWLINE            ;nova linha, fim da execução

    ret

questao_6:
    mov ecx, 41 ; Tamanho da string
    mov esi, buffer_string1 
    mov ebx,0
      
    loop6:  
        cmp ecx, 0 ; Verificar se o contador é igual a 0
        je fim6 ; Caso verdadeiro, pular para "fim6"
    
        cld         ; Setar zf=0 para incrementar as posições de esi e edi
        lodsb       ; Load string byte -> mover cada caractere do esi para al
        cmp al, " " ; Comparar al com espaço
        je vazio6 ; Caso verdadeiro, pular para "vazio6"

        PRINT_CHAR al 
        PRINT_STRING " -> "
        sub al, 96 ; Na tabela ascii as letras estão deslocadas em 96 posições em relação a posição no alfabeto, ex: ASCII a=97, ALF a=1, por isso subtraimos 96
        PRINT_DEC 2, al
        
        mov [vetor+ebx],al
        ADD ebx,2
        
        NEWLINE 

        dec ecx ; decrementar ecx
        jmp loop6   ; pular para loop6
        
    vazio6:
        dec ecx ; decrementar ecx
        jmp loop6 ; pular para loop6
        
    fim6:
    ret


questao_7:
    mov edx,70                       ;tamanho do vetor

    loop7_1:
        mov ecx, 70              ;movendo o tamanho do vetor
        lea esi, vetor           ;movendo o vetor

        loop7_2:
                mov al, [esi]     ;movendo numero para al
                MOV bl,[esi+2]    ;movendo numero para bl  
                cmp al, bl        ;comparando al e bl
                jg atualiza7      ;se maior pula para atualiza7      
                xchg al, [esi+2]  ;troncando os valores de al e [esi+2]
                mov [esi], al     ;movendo al para [esi] 
        atualiza7:
                add esi,2
                sub ecx,2
                cmp ecx,0         ;se ecx é zero
                jg loop7_2        ;se maior pular para  loop7_2

    sub edx,2
    jnz loop7_1                       ;voltar para o loop7_1
  
  
  mov edx,72      ;tamanho do loop
  mov eax,vetor   ;movendo o vetor para eax
  mov cx,0 
  mov bx,0 
        
  imprimir:
    
    mov cx,[eax]      ;movendo um numero para cx
    add bx,cx         ;somando
    PRINT_DEC 2,cx    ;imprimindo 
    NEWLINE
    
    add eax,2
    sub edx,2
    
    cmp edx,0         ;se edx é zero
    je media          ; se é zero pular para media
    jg imprimir       ;se maior continuar em imprimir
      
  media:
  
   mov ax,bx        ;movendo o valor de bx para ax para dividir
   mov bh,36        ;tamanho do vetor
   div bh           ;dividindo o valor de ax por bh
   NEWLINE
   PRINT_DEC 2,al   ;imprimindo a media
   ret
