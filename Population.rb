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


  #la idea es que torneo se haga varias veces(en un for) y otra funcion vaya agregando    los que escogio (Para recordar)
  #Returns the best chromosome (Type Chromosome)
  def tournament()
    chromosome1 = rand(@lengthPopulation)
    chromosome2 = rand(@lengthPopulation)
    while chromosome2 == chromosome1 do
        chromosome2 =  rand(@lengthPopulation)
    end
    if(@chromosomes[chromosome1].fitness >=  @chromosomes[chromosome2].fitness)
      return @chromosomes[chromosome1]
    else
      return @chromosomes[chromosome2]
    end
  end 
  
  
end