## Inertion sort

Para ordenar una lista de largo n se necesitan n^2 pasos 

El orden de una lista se puede medir por sus k inversiones o por sus "pares cambiados" (i < j y A[i] > A[j])

Complejidad de insertion sort es O(n + k), donde k en el peor caso es n(n-1)/ 2

#

### ¿Cual es el caso promedio de inserciones que debo hacer?

cantidad de formas de ordenar los n elementos de una lista es n! (permutaciones)

-  K(A): número de pares invertidos
-  H(A): número de pares no invertidos
- P(A): número de permutaciones de A

E[K(A)] = 1 / |P(A)| Sum k(a) con a in P(A)

E[K(A)] = E[H(A)] porque para cada valor de K(A) hay un contrario que es H(A), (se pueden dar vuelta por lo tanto son iguales)

E[K(A)] = 1 / |P(A)| Sum K(a) con a in P(A)
E[H(A)] = 1 / |P(A)| Sum H(a) con a in P(A)

si las sumo:

2 * E(K(A)) = 1 / |P(A)| Sum [K(a) + H(A)] con a in P(A)

Como [K(a) + H(A)] = n(n-1) / 2, ya que son todos los casos 

2 * E[K(A)] = 1 / |P(A)| Sum [n(n-1) / 2 ] con a in P(A)

2 * E[K(A)] = 1 / |P(A)| *  |P(A)| * [n(n-1) / 2 ] con a in P(A)

E[K(A)] = n(n-1) / 4 lo que es de orden =O(n^2)

\frac{1}{2}

