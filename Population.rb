require './Chromosome.rb'
class Population
  def initialize(lengthPopulation, lengthChromosome)
    @lengthPopulation = lengthPopulation
    @lengthChromosome = lengthChromosome
    @chromosomes = []
  end

  attr_accessor :lengthPopulation, :lengthChromosome, :chromosomes  #getters and setters

  def buildPopulation()
    #The following code is only for showing the chromosomes 
    for i in 0...@lengthPopulation do
      newChromosome = Chromosome.new(@lengthChromosome)
      newChromosome.buildGenes()
      @chromosomes.push(newChromosome)
      #@chromosomes.push(Chromosome.new(@lengthChromosome))
      p @chromosomes[i].genes
    end
  end

  def buildPool()
    
  end
  
end