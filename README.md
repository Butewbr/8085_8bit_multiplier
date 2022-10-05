# 8 Bit Multiplier for 8085
Multiplicador de 8 bits em Assembly do 8085

Este programa foi feito para uma tarefa da disciplina Organização e Arquitetura de Computadores I. Segue a tarefa:

## Tarefa 1
1) Assuma que os números (em hexadecimal) são inteiros positivos (sem sinal).
   * Em decimal, isso quer dizer que os números estão na faixa entre 0 e 255.
2) Os números que serão multiplicados encontram-se nas <ins>portas de entrada</ins> 00H e 01H.
3) Os 8 LSB do resultado devem ser escritos na <ins>porta de saída</ins> 00H, enquanto os 8 MSB na <ins>porta de saída</ins> 01H.
4) Multiplicação por *zero*. Certifique-se que o programa funcione corretamente quando um dos números for igual a zero.

## Passos da resolução:
1. Ler o valor localizado na porta de entrada 00H, passando para um registrador.
2. Passar o valor de entrada 01H a um registrador.
3. Verificar se um dos valores é igual a zero.<br>
      3.1. Se sim, atribuir os resultados como 0.
4. Verificar qual dos valores é menor para otimizar o loop.
5. Criar um loop que soma o valor do acumulador a ele mesmo pelo X vezes, sendo X o menor valor de entrada.
6. Registrar o resultado nos endereços de saída especificados.
