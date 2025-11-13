.section .data
array: .word 1, 2, 3, 4, 5, 6

.section .text
    .globl _start
_start:
    .option push
    .option norelax
    la gp, __global_pointer
    .option pop

    la t1, array
    lw t1, 0(t1)


    addi t2, zero, 6 # tamanho do vetor
    addi t3, zero, 0 # contador


for:
    addi 
    bgt t0, t1, target # if t0 > t1 then target
    