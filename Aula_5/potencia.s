.section .text
    .globl _start

_start:
    li a0, 2
    li a1, 3

    jal pot

loop:
    j loop



pot:
    addi sp, sp, -12 #aloca duas palavras
    sw a0, 8(sp) #empilha a0
    sw a1, 4(sp) #empilha a1
    sw ra, 0(sp) #colocando ra no topo (empilha)

    #testar se é folha ou ñ

    addi t1, zero, 1
    bgt a1, t1, else
    addi sp, sp, 12 #desaloca a pilha
    add a0, zero, 1
    jr ra

else:
    addi a1, a1, -1
    jal fat         #retorna em a0
    lw t1, 0(sp)    # pega o a0 (n) empilhado  
    lw ra, 8(sp)
    mul a0, a0, a0
    addi sp, sp, 12  #+12?
    jr ra

