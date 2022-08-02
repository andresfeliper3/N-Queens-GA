# language: es
# encoding: utf-8
# Archivo: Population.feature
# Autor: Andrés Felipe Rincón
# Fecha creación: 2022-08-02
# Fecha última modificación: 2022-08-02
# Versión: 0.2
# Licencia: GPL

Característica: Crear una población y evaluación del funcionamiento de sus cualidades básicas.

  Antecedentes: Crear una población de cromosomas
  Dado que se necesita una población de tamaño 100 de cromosomas de tamaño 8, se crea la población

  Escenario: Verificar la población inicial
    Cuando se revisa la población 
    Entonces la población debe ser de tamaño 100
    Y cada elemento debe ser un cromosoma válido

  Escenario: Revisar el método de selección Torneo
    Cuando se seleccionan dos cromosomas para el torneo
    Entonces el cromosoma ganador debe ser más apto que el perdedor

  
  

    
    


  


  

  
