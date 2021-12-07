/*
cima para baixo na definição
esquerda para a direita nas respostas
backtrack quando não encontra outra resposta

pairs(X,Y)
  - d(X), q(Y)
    - d(X)       X=2
        - q(Y)   Y=4    X=2, Y=4  ? ;
        - q(Y)   Y=16   X=2, Y=16 ? ;
        - não encontra outra resposta para q(X) -> backtrack
    - d(X)       X=4
        - q(X)   Y=4    X=4, Y=4  ? ;
        - q(Y)   Y=16   X=4, Y=16 ? ;
        - não encontra outra resposta para q(X) -> backtrack
    - não encontra outra resposta para d(X) -> backtrack
  - backtrack  
- exit

pairs(X,X)
  - u(X)         X=1 ? ;
  - não encontra outra resposta para u(X) -> backtrack
- exit
*/