.section .data
num: .word 26

.section .text
    .globl _start
_start:
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

    la t1, num
    lw t1, 0(t1)

    andi t2, t1, 1
    beq t2, zero, PAR
    addi t0, zero, 0
    j fim

PAR:
    addi t0, zero, 1

fim:
    addi t0, t0, 0
    j fim