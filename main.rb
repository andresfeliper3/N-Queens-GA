
 require './Population.rb'

# Parameteres
lengthPopulation = 100
lengthChromosome = 10 


initialPopulation = Population.new(lengthPopulation, lengthChromosome)
initialPopulation.buildPopulation()

p "CROMOSOMA #{initialPopulation.roulette()}"




