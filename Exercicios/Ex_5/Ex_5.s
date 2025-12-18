# Escreva uma função para converter uma string para inteiro. O número deve ser
# positivo ou negativo. Para testar capture a string do teclado, usando a chamada de
# sistema read (número 63) e faça o tratamento apropriado

# ao debuggar, depois de inserir a string, está aparecendo o \n, então a verificação é achar o \n e substituir por \0 


.section .data
buffer: .space 20
numero: .space 20

.section .text
    .globl _start

_start:

    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

    li a7, 63       # chamada de sistema: leitura
    li a0, 0        # stdin
    la a1, buffer   # endereço de onde vai guardar
    li a2, 19       # qtd de bits a ser lidos
    ecall
    mv s0, a0       # salva a qtd de bits lidos
    add a0, a0, a1  # tamanho da string (sem o \0) + endereço do buffer = fim do buffer  
    sb zero, 0(a0)  # adiciona \0 no final

    la a0, buffer   # carrega o endereço da string para argumento da função
    la a1, numero   # carrega o endereço onde será guardado o numero
    jal func

    li a7, 93       # chamada de sistema: exit
    li a0, 0        # sucesso
    ecall

func:
    # a0 = endereço da string
    # a1 = endereço do numero
    # verificar se o primeiro caractere é "-"
    lb t0, 0(a0)        # carrega o primeiro caractere
    addi t1, zero, 45   # valor em ascii do '-'
    addi t2, zero, 10   # numero para multiplicar
    addi t3, zero, 0
    bne t0, t1, converte  # verifica se o primeiro digito é -, se for criar uma flag e pular o -? depois só multiplicar o numero por -1?
    addi a7, zero, 1      # flag
    addi a0, a0, 1        # incrementa o endereço

converte:

    lb t0, 0(a0)        # carrega o próximo caractere
    beq t0, zero, fim   # verifica se carregou o \0
    addi t0, t0, -48    # transforma o ascii em inteiro
    mul t3, t3, t2      # multiplica o digito por 10 (primeira: 0x10) + digito
    add t3, t3, t0     # soma o digito 
    addi a0, a0, 1      # incrementa o endereço da string
    j converte          # se não for o fim da string, continua a converter digito para numero


fim:
    bne a7, zero, fim_negativo
    sw t3, 0(a1)     # guarda o numero
    mv a0, a1        # endereço do numero p imprimi
    jr ra

fim_negativo:
    addi a6, zero, -1
    mul t3, t3, a6      # multiplica o numero
    sw t3, 0(a1)        # guarda no endereço 
    jr ra
