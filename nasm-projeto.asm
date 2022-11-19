%include "io.inc"

section .data
    string1 db "Qual e a importancia da escola na democratizacao da sociedade", 0;
    len_string1 equ $- string1
    
    msg_a db "a -> ", 0
    msg_m db "m -> ", 0

section .bss
    buffer_string1: resb len_string1

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
                    
teste:
    PRINT_DEC 2, ecx
    PRINT_STRING 'x'

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
    ret

questao_4:
    ret

questao_5:
    ret

questao_6:
    ret

questao_7:
    ret
