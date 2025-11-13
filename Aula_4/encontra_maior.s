.section .data
array: .word -5, 10, 15, 13, 27, 40, 37 #definindo o array global

.section .text
    .globl _start
_start:
    # Inicialização do registrador gp (global pointer)
    .option push
    .option norelax # é necessário, pq se não ele tenta otimizar a operação e faz errado
    la gp, __global_pointer$ 
    .option pop

    la t0, array #pseudo instruction, conjunto de instruções, carrega endereço de memória no label (no caso, o endereço base do array)
    lw s0, 0(t0) #carrega o primeiro elemento em s0, por que em s0 (registradores salvos/Ponteiro de frame)?

    addi t1, zero, 7 # tamanho do vetor
    addi t2, zero, 1 # contador (começa em 1 pq já considera o primeiro elemento como o maior)
    
loop: beq t1, t2, end_loop #verifica se o loop chegou ao fim
    slli t3, t1, 2 #pega a base do array, calcula o endereço do prox elemento (multiplica o indice pelo o tamanho do dado (x4))
    add t3, t3, t0 # Calcula o endereço do prox elemento (somando o elemento com o passo necessário para o próx elemento
    lw s1, 0(t3)
    
    bge s0, s1, nao_troca # se s0 for maior que s1, não troca
        mv s0, s1 #troca s0 com s1 (mv = move)
            
    nao_troca:
        addi t2, t2, 1      #incrementa o indice do contador
        j loop

end_loop:
    addi s0, s0, 0
    j end_loop
