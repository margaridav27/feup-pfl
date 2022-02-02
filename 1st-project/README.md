# Fibonacci - Integer vs BigNumber

Para analisar o maior número que cada função aceita como argumento, foi estabelecido um _timeout_ de 1 minuto.

|           | Recursão | Programação dinâmica | Lista Infinita |
| --------- | -------- | -------------------- | -------------- |
| Integer   | 36       | 62303                | 1000000        |
| BigNumber | 32       | 2275                 | 20000          |

Um Integer pode representar um número inteiro arbitrariamente grande, dependendo da capacidade de armazenamento da máquina.

Um Int apenas consegue representar inteiros representáveis por 32 ou 64 bits, dependendo do sistema operativo.

Não foram mostrados quaisquer resultados para o maior número que cada função aceita como argumento usando tipo Int, dado que esse argumento corresponderia ao índice do maior número da sequência de Fibonnaci representável por um valor desse tipo (de notar, no entanto, que, considerando o _timeout_, esse número poderia não ser obtido em tempo útil).

No entanto, as operações realizadas usando tipo Integer sofrem de uma maior latência relativamente às realizadas usando tipo Int. Portanto, dado que os testes foram realizados considerando um _timeout_, é provável que os resultados obtidos não correspondam ao maior número representável por esse tipo de dados, mas sim ao maior número calculável em tempo útil.

Em relação aos testes realizados usando tipo BigNumber, era previsível que o resultado fosse menor, dado que as operações poderão ser mais lentas.

Para além disso, considerando o mesmo tipo de dados, há que realçar a diferença na eficiência das diferentes implementações, com as listas infinitas ofericadas pela linguagem _Haskell_ a ganhar indubitavelmente, e por uma margem significativa, em termos de eficiência.

# BigNumber - casos de teste

## somaBN

```haskell
output (somaBN (scanner "123") (scanner "-123"))
> "0"

output (somaBN (scanner "0") (scanner "12"))
> "12"

output (somaBN (scanner "9") (scanner "9"))
> "18"

output (somaBN (scanner "99") (scanner "1"))
> "100"

output (somaBN (scanner "10000") (scanner "20"))
> "10020"

output (somaBN (scanner "-10000") (scanner "20"))
> "-9980"

output (somaBN (scanner "-10") (scanner "15"))
> "5"
```

## subBN

```haskell
output (subBN (scanner "0") (scanner "-12"))
> "12"

output (subBN (scanner "1") (scanner "1"))
> "0"

output (subBN (scanner "17") (scanner "200"))
> "-183"

output (subBN (scanner "1340") (scanner "290"))
> "1050"

output (subBN (scanner "-75") (scanner "29"))
> "-104"

output (subBN (scanner "-36") (scanner "-78"))
> "42"

output (subBN (scanner "-36570") (scanner "-13082"))
> "-23488"
```

## mulBN

```haskell
output (mulBN (scanner "45") (scanner "7"))
> "315"

output (mulBN (scanner "25") (scanner "0"))
> "0"

output (mulBN (scanner "-12") (scanner "67"))
> "-804"

output (mulBN (scanner "1200") (scanner "-78"))
> "-93600"

output (mulBN (scanner "-14") (scanner "-42"))
> "588"

output (mulBN (scanner "-1") (scanner "4"))
> "-4"
```

## divBN

```haskell
(quociente, resto) = divBN (scanner "0") (scanner "193")
output quociente
> "0"
output resto
> "0"

(quociente, resto) = divBN (scanner "20") (scanner "1")
output quociente
> "20"
output resto
> "0"

(quociente, resto) = divBN (scanner "123") (scanner "49")
output quociente
> "2"
output resto
> "25"

(quociente, resto) = divBN (scanner "1000") (scanner "10")
output quociente
> "100"
output resto
> "0"

(quociente, resto) = divBN (scanner "29") (scanner "93")
output quociente
> "0"
output resto
> "29"

(quociente, resto) = divBN (scanner "34") (scanner "34")
output quociente
> "1"
output resto
> "0"

(quociente, resto) = divBN (scanner "18905622") (scanner "19724")
output quociente
> "958"
output resto
> "10030"
```

## safeDivBN

```haskell
safeDivBN (scanner "18905622") (scanner "19724")
> Just ((True, [9,5,8]),(True, [1,0,0,3,0]))

safeDivBN (scanner "18905622") (scanner "0")
> Nothing
```


> ### Nota
> Não foram feitas quaisquer descrições do funcionamento das funções implementadas neste trabalho prático, uma vez que consideramos que estas se encontram devidamente  documentadas e explicadas nos respetivos documentos.
