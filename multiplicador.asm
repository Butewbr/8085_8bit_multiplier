; bernardo_pandolfi_costa_multiplicador.asm
;
; Title: 8 bit multiplier for 8085
;
; Author: Bernardo Pandolfi Costa (19207646)
;
; Date: 21-Oct-2022
;
; Atividade:
;   Assuma que os números em hexadecimal são inteiros positivos (sem sinal).
;   Os números que serão multiplicados encontram-se nas *portas de entrada* 00H e 01H.
;   Os 8 LSB do resultado devem ser escritos na *porta de saída* 00H, enquanto os 8 MSB na porta de saída 01H.
;   Multiplicação por zero. Certifique-se que o programa funcione corretamente quando um dos números for igual a zero.


; Resumo dos passos:
;   1. Ler o valor localizado na porta de entrada 00H, passando para um registrador.
;   2. Passar o valor de entrada 01H a um registrador.
;   3. Verificar se um dos valores é igual a zero.
;       3.1. Se sim, atribuir os resultados como 0.
;   4. Verificar qual dos valores é menor para otimizar o loop.
;   5. Criar um loop que soma o valor do acumulador a ele mesmo pelo X vezes, sendo X o menor valor de entrada.
;   6. Registrar o resultado nos endereços de saída especificados.

        
.org 0000H              ; começar o programa em 0000H (para ser mais fácil de achar)

; Carregando os valores e passando para registradores (B e C, respectivamente):
        IN 00H          ; colocamos o valor da porta de entrada 00H no acumulador
        MOV B, A        ; colocamos o valor do acumulador no registrador B
        MVI A, 00H      ; zeramos o acumulador
        CMP B           ; checar se B tem o mesmo valor do acumulador (como o valor do acumulador é 0, checa se o valor em B é nulo):
        JNZ cont        ; se B = 0 não pula
        OUT 0000H       ; outputs iguais a 0
        OUT 0001H       ; outputs iguais a 0
        HLT             ; finaliza o programa

; Se o valor em 00H não for nulo, continua:
cont:   MVI D, 00H      ; D vai carregar os carrys
        IN 01H          ; colocamos o valor da porta de entrada 01H no acumulador
        MOV C, A        ; movemos o valor do acumulador no registrador C
        MVI A, 00H      ; zeramos o acumulador
        CMP C           ; checar se C tem o mesmo valor do acumulador (como o valor do acumulador é 0, checa se o valor em C é nulo):
        JNZ verif       ; se C = 0 não pula
        OUT 0000H       ; outputs iguais a 0
        OUT 0001H       ; outputs iguais a 0
        HLT             ; finaliza o programa

; verificamos qual dos valores é menor e colocamos o menor em C:
verif:  MOV A, C        ; botamos o valor de C no acumulador
        CMP B           ; faz C - A (o valor de C tá em A, então faz B - C)
        JNC zera2       ; vai pra 'zera2' quando TEM carry, isto é, quando B <= C
        JMP zera1       ; quando não tem carry na linha anterior, significa C < B, então pula pro 'zera1'

; Caminho se C < B:
zera1:  MVI A, 00H      ; zeramos o acumulador
loop2:  ADD B           ; adicionamos o valor em B ao acumulador
        JNC loop        ; verifica se tem carry
        INR D           ; guarda o carry no registrador D

loop:   DCR C           ; diminui um do C, porque já foi somado
        JNZ loop2       ; JNZ = jump if not zero (o valor da última linha), então vai skippar se C não for
                        ; zero. Quando C carregar um valor nulo, a multiplicação terá acabado
        OUT 0001H       ; guardamos o valor na porta de saída especificada
        MOV A, D        ; bota o valor do carry no acumulador
        OUT 0000H       ; guarda o valor do carry
        HLT             ; finaliza o programa

; Caminho se B <= C:
zera2:  MVI A, 00H      ; zeramos o acumulador
loop4:  ADD C           ; adicionamos o valor em B ao acumulador
        JNC loop3       ; verifica se tem carry
        INR D           ; guarda o carry no registrador D

loop3:  DCR B           ; diminui um do C, porque já foi somado
        JNZ loop4       ; JNZ = jump if not zero (o valor da última linha), então vai skippar se C não for
                        ; zero. Quando C carregar um valor nulo, a multiplicação terá acabado
        OUT 0001H       ; guardamos o valor na porta de saída especificada
        MOV A, D        ; bota o valor do carry no acumulador
        OUT 0000H       ; guarda o valor do carry
        HLT             ; finaliza o programa