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

  Escenario: Sin conflictos
    Cuando el cromosoma es [1,3,5,7,2,0,6,4]
    Entonces debe indicar que hay 0 conflictos

    Cuando el cromosoma es [1,3,4,7,2,0,6,5]
    Entonces debe indicar que hay 2 conflictos

  

  
