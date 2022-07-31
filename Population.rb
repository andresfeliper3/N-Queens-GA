require './Chromosome.rb'
class Population
  def initialize(lengthPopulation, lengthChromosome)
    @lengthPopulation = lengthPopulation
    @lengthChromosome = lengthChromosome
    @chromosomes = []
    @fitnessPopulation = []
    @sumOfFitness = 0
  end

  attr_accessor :lengthPopulation, :lengthChromosome, :chromosomes, :fitnessPopulation  #getters and setters

  def populationFitness()
    for i in 0...@chromosomes.length do
      @fitnessPopulation.append(@chromosomes[i].fitness())
    end
    @sumOfFitness = @fitnessPopulation.sum()
  end

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
    if(@chromosomes[chromosome1].fitness() >=  @chromosomes[chromosome2].fitness())
      return @chromosomes[chromosome1]
    else
      return @chromosomes[chromosome2]
    end
  end
  
  def roulette()
    probabilityPopulation = []
    cumulativeProbability = []
    
    populationFitness()
    totalFitness = @fitnessPopulation.sum #Get the total fitness from the population
    #Calculate both probability and cumulative probability for each Chromosome based on their   fitness
    for i in 0...@chromosomes.length do
      probabilityPopulation.append(@fitnessPopulation[i].to_f/totalFitness)
    end
    
    cumulativeProbability.append(probabilityPopulation[0])
    
    for i in 1...@chromosomes.length do
      cumulativeProbability.append(probabilityPopulation[i] + cumulativeProbability[i-1])
    end
    
    r = rand(0.0..1.0) 
    
    if(r < cumulativeProbability[0])
      return @chromosomes[0]
    else
      for i in 1...cumulativeProbability.length do
        if (cumulativeProbability[i-1] < r and r <= cumulativeProbability[i])
          return @chromosomes[i]
        end
      end
    end
end

  def universalRandomSampling()

    
  end
end

  
