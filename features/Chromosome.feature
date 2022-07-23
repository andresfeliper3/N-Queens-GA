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
  Dado que se necesita una población de cromosomas de tamaño 10, se crea un cromosoma

  Escenario: Verificar que no se repitan genes en el cromosoma
    Cuando se revisa el cromosoma
    Entonces no deben haber números repetidos

  
