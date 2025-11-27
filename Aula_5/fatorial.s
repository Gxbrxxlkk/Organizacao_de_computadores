.section .text
    .globl _start
_start:
    #.option push
    #.option norelax
    #la gp, __global_pointer$
    #.option pop

    li a0, 5 # passa n para fat
    #addi t1, zero, 5
    jal fat # chama fat passando n=5
    #mv s0, a0
    #add s0, t1, a0 #copia o retorno para s0

loop: 
    add s0, s0, zero
    j loop

fat: 
    addi sp, sp, -8 #aloca duas palavras
    sw a0, 4(sp) #empilha a0
    sw ra, 0(sp) #colocando ra no topo (empilha)

    #testar se é folha ou ñ

    addi t1, zero, 1
    bgt a0, t1, else
    addi sp, sp, 8 #desaloca a pilha
    add a0, zero, 1
    jr ra

else: # n x fat(n - 1)
    addi a0, a0, -1
    jal fat         #retorna em a0
    lw t1, 4(sp)    # pega o a0 (n) empilhado  
    lw ra, 4(sp)
    mul a0, t1, a0
    addi sp, sp, 8
    jr ra
