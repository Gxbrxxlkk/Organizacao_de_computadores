# 
.section .data
M: .word 0        #para salvar a parte inteira da média
P: .word 0


.section .text
    .globl _start
_start:
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

    addi t0, zero, 68 # adicionando valor em t0
    addi t1, zero, 66 # adicionando valor em t1

    mv a0, t0 #passa o primeiro argumento
    mv a1, t1 # '' segundo argumento

    addi sp, sp, -8 #aloca duas palavras 

    sw t0, 4(sp)    # empilha t0
    sw t1, 0(sp)    # empilha t1


    jal calcula #chama a função

    lw t0, 4(sp) # restaura t0, pois a main não sabe se a função mudou o valor dele
    lw t1, 0(sp) #mesma coisa, pra t1
    addi sp, sp, 8 # desaloca memoria na pilha


    mul s0, t0, t1 #calcula a multiplicação 

    #salvar os resultados na mem
    la t0, M
    la t1, P
    sw a0, 0(t0) #salva a média
    sw s0, 0(t1) #salva a multiplicação

done:
    add t0, t0, zero
    j done

calcula:

    add t0, a0, a1 #pegando os argumentos
    srl t0, t0, 1 #divide por 2
    mv a0, t0     #copia o retorno

    jr ra #volta pra main       
