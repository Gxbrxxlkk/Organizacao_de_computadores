.section .data
buffer: .space 11

.section .text
    .globl _start
_start:
    
    # Inicializa o ponteiro gp
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

    ## define o numero (funciona para positivos)
    li s0, 1235412

    # Chama a função     
    mv a0, s0 # passa o numero
    la a1, buffer # passa o buffer
    jal conv_int2str
    mv t0, a0


    # Write da str
    li a7, 64       # syscall: write
    li a0, 1        # file descriptor: (1-> monitor)
    la a1, buffer      # pointer to message
    mv a2, t0       # Tamanho da string
    ecall           # chamada do sistema
    
    # Exit
    li a7, 93       # syscall: exit
    li a0, 0        # exit code 0
    ecall           # chamada do sistema



# implementa a função
# a0 -> numero inteiro
# a1 -> &buffer
conv_int2str:
    mv t0, a0
    li t1, 10
    
    # Contador
    addi t3, zero, 0 

    # empilha 0 \0 para indicar a terminação da string
    addi sp, sp, -1 # empilha o \0
    sb zero, 0(sp) # coloca o \0

    #teste caso t0 = 0, caso seja incrementar o contador e pular para o loop de desempilhar
    beq t0, zero, empilha_zero
    j loop
empilha_zero:
    addi t3, t3, 1 #contador++
    j done

loop:
    beq t0, zero, done
    # t2 = t0 % 10
    rem t2, t0, t1
    addi t2, t2, 48 # converte para ascii
    addi sp, sp, -1 
    sb t2, 0(sp) 

    # t0 = t0 / 10
    div t0, t0, t1
    addi t3, t3, 1 #contador++
    j loop

done:
    
    lbu t0, 0(sp)  # desempilha o primeiro caractere da pilha

loop2:
    beq t0, zero, fim
    sb t0, 0(a1)
    addi a1, a1, 1
    addi sp, sp, 1
    lbu t0, 0(sp)
    j loop2

fim:
    addi sp, sp, 1 # remove o \0 da pilha
    sb zero, 0(a1) # adiciona o \0 no final
    mv a0, t3 #retorno
    jr ra
.end
