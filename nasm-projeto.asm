%include "io.inc"

section .data

section.bss

section .text
global CMAIN

CMAIN:
    mov ebp, esp; for correct debugging
    call questao_1
    call questao_2
    call questao_3
    call questao_4
    call questao_5
    call questao_6
    call questao_7
    ret

questao_1:
    ret

questao_2:
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
