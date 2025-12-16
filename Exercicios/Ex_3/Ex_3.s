.section .data
string: .asciz "Gabriel"    # contar o \0

.section .text
    .globl _start
_start:
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop


    la a0, string            # li a0, 0(string) #isso aqui funciona? resposta: ñ tem q usar a pseudo instr guardar o endereço da string no a0
    addi a1, zero, 8         # Tamanho da string
    jal inverso_string

    li a7, 64                # chamando write
    li a0, 1                 # monitor
    la a1, string            # inicio da string
    li a2, 8                 # tamanho da string 
    ecall

    li a7, 93                # chamando exit
    li a0, 0                 # codigo de saida 0 (sucesso)
    ecall

inverso_string:

    addi t0, zero, 0        # caractere \0 
    mv t1, a0               # cria uma cópia do endereço original
loop:
    addi sp, sp, -1          # aloca espaço
    sb t0, 0(sp)            # empilha o caractere
    lb t0, 0(t1)            # pega o caractere
    addi t1, t1, 1          # incrementa o endereço
    beq t0, zero, salva_string  # if t0 == zero then fim_loop
    j loop

salva_string:

    addi a1, a1, -1         # decrementa o contador
    lb t0, 0(sp)            # pega o ultimo caractere
    sb t0, 0(a0)            # guarda no string original
    addi a0, a0, 1          # incrementa o endereço
    addi sp, sp, 1          # desaloca memória na pilha
    bne a1, zero, salva_string 
    jr ra                   # volta para onde foi chamado

# inverso_string:

#     lb t0, 0(a0)            # guarda o que está no endereço da string
#     addi sp, sp, -4         # alocando espaço na pilha para armazenar os caracteres e o contador, lembrando q char ocupa 1 espaço correção: fodase espaço, 4 bytes é padrão e confunde muito menos
#     sb t0, 0(sp)            # guarda o byte do caractere atual (1 byte com o char, o resto não importa)
#     bne t0, zero, else      # caso for o \0, continua #correção: o certo é bne
#                             # O \0 está guardado na pilha, só desalocar e retornar da chamada
#     addi t1, zero, 0        # inicializando contador
#     addi sp, sp, 4          # desaloca o caractere \0
#     jr ra                   # caso base, volta da recursão
# else:
#     addi sp, sp, -4         # alocando espaço para o endereço de retorno da função
#     sw ra, 0(sp)            # guarda o endereço de retorno da função 
#     addi a0, a0, 1          # passa p o endereço do proximo char
#     jal inverso_string
#     addi sp, sp, 4          # alocar espaço para o contador
#     lw t0, -1(a0)           # guarda o caractere, talvez eu esteja no endereço errado
#     la t2, string           # guarda o endereço da string
#     sw t0, t1(t2)           # guarda o caractere no endereço da string (provavelmente também não funciona)
#     addi t1, t1, 1          # incrementa o contador
#     sw t1, 0(sp)            # guarda o contador atual
#                             # Tem q mexer no offset agora (caso o esquema com t1 não dê certo)
#     jr ra 
#                             # tem q desalocar a memória da pilha agora

.end
