require './Population.rb'

def main
  lengthPopulation = 100
  lengthChromosome = 11
  lengthMatingPool = 98 # even
  generations = 10

  population = Population.new(lengthPopulation, lengthChromosome)
  population.buildPopulation

  (1..generations).each do |i|
    p "--------------GENERATION #{i}-------------------------"
    population.selectionMethod(1, lengthMatingPool)
    p 'MATING POOL'
    population.showMatingPool
    population.reproduction(2)
    p 'CHILDREN POPULATION'
    population.showChildrenPopulation
    p 'CURRENT POPULATION'
    population.replacementSelection(2)
    population.showPopulation
    population.clearCurrentGeneration
    p "-------------END OF GENERATION #{i}------------------"
  end
end

main
