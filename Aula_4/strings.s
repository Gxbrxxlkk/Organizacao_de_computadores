.section .data
texto: .asciz "gabriel"

.section .text
    .globl _start

_start:
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

la t0, texto #le o endereço da base da string
lb t1, 0(t0) #le o primeiro caracter

loop: beq t1, zero, end_loop
    addi t1, t1, -32 #deixando o caractere maiusculo
    sb t0, 0(t0) #guardando de volta na memória 
    addi t0, t0, 1
    lb t1, 0(t0)
    j loop

end_loop:
    add t0, t0, zero
    j end_loop
