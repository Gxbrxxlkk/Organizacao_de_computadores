# Implemente uma função recursiva que some os elementos de um array de inteiro. A
# função deve receber com parâmetro o endereço base do array e o número de
# elementos.

.section .data
array: .word 1,2,3,4,5,6,7,8,9,10

.section .text
    .globl _start
_start:

    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

    la a0, array    # carrega o endereço do array
    li a1, 10       # tamanho do vetor
    jal empilha_array       # chama a função

    li a7, 93       # chamada do exit
    li a0, 0        # sucesso
    ecall

    # a0 = endereço do array
    # a1 = tamanho do array
    # recursão vai ser +/- assim: t0 = a0 + funct(a0+4, a1 - 1) até a1 == 0
    # primeiro empilhar todos os numeros do array na pilha, depois desempilhar somando (usar o contador também)
    # incrementar o endereço do array

empilha_array:
    beq a1, zero, base  # se o contador estiver em 0, vai para o caso base
    lw t0, 0(a0)        # carrega o numero
    addi sp, sp, -8     # aloca espaço para o numero, endereço do próximo elemento, contador e ra
    sw ra, 4(sp)        # guarda o ra
    sw t0, 0(sp)        # guarda o numero
    addi a0, a0, 4      # endereço do próximo elemento do array
    addi a1, a1, -1     # decrementa o contador
    jal empilha_array

    #depois de retornar do caso base, vou estar com as info do ultimo elemento do array
    # vai estar empilhado nessa ordem numero -> endereço p um elemento q n existe -> contador em 0, ra da chamada chamada atual?

    lw t0, 0(sp)
    lw ra, 4(sp)
    add a0, a0, t0     # soma o ultimo elemento, n tô somando endereço com valor? resposta: ñ
    addi sp, sp, 8      # desempilha
    jr ra               # volta para a chamada recursiva anterior, até voltar da função

base:
    li a0, 0
    ret                 # retorna da recursão

# empilha_array:
#     # Caso Base: se tamanho (a1) == 0, retorna 0
#     beq a1, zero, base  

#     # Prologo: Salva o número atual e o endereço de retorno
#     addi sp, sp, -8     
#     sw ra, 4(sp)        
#     lw t0, 0(a0)        # Carrega o elemento atual
#     sw t0, 0(sp)        # Guarda o elemento para somar depois da volta

#     # Prepara chamada recursiva
#     addi a0, a0, 4      # Próximo endereço
#     addi a1, a1, -1     # Decrementa contador
#     jal empilha_array   # Chamada recursiva -> o retorno (soma) virá em a0

#     # Epílogo: Soma o valor salvo com o resultado que veio da recursão
#     lw t1, 0(sp)        # Recupera o número que salvamos antes de "descer"
#     add a0, a0, t1      # Soma o número atual ao acumulado (a0)
#     lw ra, 4(sp)        # Recupera o endereço de retorno
#     addi sp, sp, 8      # Libera a pilha
#     jr ra               

# base:
#     li a0, 0            # Retorna 0 como base da soma
#     ret