.section data
msg: .asciz "Hello, World!\n"

.section .text
    .globl _start
_start:
    .option push
    .option norelax
    la gp, __global_pointer$  # Set up the global pointer
    .option pop

    li a7, 64       # syscall: write
    li a0, 1        # file descriptor: (1-> monitor)
    la a1, msg      # pointer to message
    li a2, 14       # message length
    ecall           # make syscall

    mv t0, a0       # exit code 0

    #exit
    li a0, 0        # exit code 0
    li a7, 93       # syscall: exit
    ecall           # make syscall
.end