# language: es
# encoding: utf-8
# Archivo: Chromosome.feature
# Autor: Andrés Felipe Rincón
# Fecha creación: 2022-07-20
# Fecha última modificación: 2022-07-20
# Versión: 0.2
# Licencia: GPL

Característica: Crear un cromosoma y funcionamiento de sus cualidades básicas.

  Antecedentes: Crear un cromosoma
  Dado que se necesita una población de cromosomas de tamaño 8, se crea un cromosoma

  Escenario: Verificar que no se repitan genes en el cromosoma
    Cuando se revisa el cromosoma
    Entonces no deben haber números repetidos

  Dado cromosomas de tamaño 8, se hacen pruebas 

  Escenario: Sin conflictos
    Cuando el cromosoma es 1,3,5,7,2,0,6,4
    Entonces debe indicar que hay 0 conflictos
    Y la funcion de fitness normalizada debe ser 1

    Cuando el cromosoma es 2,4,1,7,0,6,3,5  
    Entonces debe indicar que hay 0 conflictos
    Y la funcion de fitness normalizada debe ser 1

    Cuando el cromosoma es 1,4,6,0,2,7,5,3  
    Entonces debe indicar que hay 0 conflictos
    Y la funcion de fitness normalizada debe ser 1

    Cuando el cromosoma es 3,0,4,7,1,6,2,5
    Entonces debe indicar que hay 0 conflictos
    Y la funcion de fitness normalizada debe ser 1

    Cuando el cromosoma es 4,6,1,3,7,0,2,5 
    Entonces debe indicar que hay 0 conflictos
    Y la funcion de fitness normalizada debe ser 1

    Cuando el cromosoma es 3,7,4,2,0,6,1,5
    Entonces debe indicar que hay 0 conflictos
    Y la funcion de fitness normalizada debe ser 1
   
  Escenario: Algunos conflictos
    Cuando el cromosoma es 1,3,4,7,2,0,6,5
    Entonces debe indicar que hay 4 conflictos

    Cuando el cromosoma es 6,4,7,1,2,5,0,3
    Entonces debe indicar que hay 5 conflictos

  Escenario: mutaciones
    Cuando el cromosoma es 4,7,1,0,2,3,5,6
    Y el cromosoma muta
    Entonces debe indicar que hay 2 genes diferentes

    Cuando el cromosoma es 1,3,5,7,2,0,6,4
    Y el cromosoma muta
    Entonces debe indicar que hay 2 genes diferentes

    Cuando el cromosoma es 2,4,1,7,0,6,3,5  
    Y el cromosoma muta
    Entonces debe indicar que hay 2 genes diferentes

   Cuando el cromosoma es 3,0,4,7,1,6,2,5
    Y el cromosoma muta
    Entonces debe indicar que hay 2 genes diferentes

   Cuando el cromosoma es 4,7,1,0,2,6,3,5
    Y el cromosoma muta
    Entonces debe indicar que hay 2 genes diferentes

  Escenario: cruzamiento respecto al padre
    Cuando el cromosoma padre es 1,3,5,7,2,0,6,4 y el cromosoma madre es 2,4,1,7,0,6,3,5
    Y los cromosomas se cruzan
    Entonces debe indicar que hay 2 genes diferentes

    Cuando el cromosoma padre es 4,7,1,0,2,3,5,6 y el cromosoma madre es 1,3,5,7,2,0,6,4
    Y los cromosomas se cruzan
    Entonces debe indicar que hay 2 genes diferentes

    Cuando el cromosoma padre es 6,4,7,1,2,5,0,3 y el cromosoma madre es 2,4,1,7,0,6,3,5
    Y los cromosomas se cruzan
    Entonces debe indicar que hay 2 genes diferentes

    Cuando el cromosoma padre es 3,0,4,7,1,6,2,5 y el cromosoma madre es 3,7,4,2,0,6,1,5
    Y los cromosomas se cruzan
    Entonces debe indicar que hay 2 genes diferentes
    
    


  


  

  
