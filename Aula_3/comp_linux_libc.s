#verificar qual o maior de dois valores

.section .data

num1: .word 10 
num2: .word 5

.section .text
    .globl main
main:
    #lê o endereço das variaveis globais
    la t1, num1
    la t2, num2

    #le o conteudo das variaveis
    lw t3, 0(t1)
    lw t4, 0(t2)

    # testa qual das duas é maior
    bgt t3, t4, t3_maior # if t3 > t4 then t3_maior
    addi t0, t4, 0 #mv t0, t4 é equivalente?


t3_maior:
    addi t0, t3, 0


fim:
    addi t0, t0, 0
    j fim
