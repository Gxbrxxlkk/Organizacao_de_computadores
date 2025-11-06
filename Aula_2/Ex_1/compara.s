.section .data
num1: .word 10
num2: .word 5

.section .text
    .globl _start
_start:
    la t1, num1                         # carrega o endereço de num1 em t0
    la t2, num2

    lw t1, 0(t1)                        # carrega t1 com a palavra na memoria no endereco t1
    lw t2, 0(t2)

    bgt t1, t2, num1_maior              # desvia se t1 > t2
    add t0, t2, zero
    j fim

num1_maior:
    add t0, t1, zero

fim:
    add s0, zero, zero                  # Para o programa parar aqui para debuggar
