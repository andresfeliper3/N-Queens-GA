require './Chromosome.rb'
class Population
  def initialize(lengthPopulation, lengthChromosome)
    @lengthPopulation = lengthPopulation
    @lengthChromosome = lengthChromosome
    @chromosomes = []
    @matingPool = []
    @fitnessPopulation = []
    @threats = []
    @timesThreat = []
    @fitnessDiversity = []
    @childrenPopulation = []
    @sumOfFitness = 0
  end
  
#getters and setters
  attr_accessor :lengthPopulation, :lengthChromosome, :chromosomes, :fitnessPopulation, :matingPool, :childrenPopulation, :sumOfFitness  

  def populationFitness()
    for i in 0...@chromosomes.length do
      @fitnessPopulation.push(@chromosomes[i].normalizedFitness())
    end
    @sumOfFitness = @fitnessPopulation.sum()
    p "population fitness sum #{@sumOfFitness}"
  end
  

  def populationFitness2()
    for i in 0...@chromosomes.length do
      
@fitnessPopulation.push(@chromosomes[i].normalizedFitness2(@fitnessDiversity.index(@fitnessDiversity.max()),@fitnessDiversity[i]))
    end
    @sumOfFitness = @fitnessPopulation.sum()
    p "population fitness sum #{@sumOfFitness}"
  end

  def getThreats()
    for i in 0...@chromosomese.length do
      @threats.push(@chromsomes[i].getThreat())
    end
  end

  def getTimes(number,threats)
    acum =0
    for i in 0...threats.length do
      if number == threats[i]
        acum = acum +1
      end
    end
    return acum
  end

  def getTimesThreat()
    getThreats()
    for i in 0...@chromosome.length do
      @timesThreat.push(getTimes(@chromosmes[i].getThreat(),@threats))
    end
  end

  def getFitness()
    for i in 0...@chromosome.length do
      @fitnessDiversity.push(@chromosmes[i].fitness2(@timesThreat[i]))
    end
  end

  def showMatingPool()
    for i in 0...@matingPool.length do
     # p @matingPool[i].genes
    end
  end

  def showPopulation()
    fitChromosomes = []
    for i in 0...@chromosomes.length do
      if @chromosomes[i].normalizedFitness() == 1.0
        p "#{@chromosomes[i].genes} - fitness #{@chromosomes[i].normalizedFitness()}"
        fitChromosomes.push(@chromosomes[i].genes)
      end
    end
    fitChromosomes
  end

  def showChildrenPopulation()
    for i in 0...@childrenPopulation.length do
      #p @childrenPopulation[i].genes
    end
  end

  #Sets the initial 
  def buildPopulation()
    #The following code is only for showing the chromosomes 
    for i in 0...@lengthPopulation do
      newChromosome = Chromosome.new(@lengthChromosome)
      newChromosome.buildGenes()
      @chromosomes.push(newChromosome)
      #@chromosomes.push(Chromosome.new(@lengthChromosome))
    #  p @chromosomes[i].genes
    end
  end


  def selectCompetitorsTournament()
    chromosome1 = rand(@lengthPopulation)
    chromosome2 = rand(@lengthPopulation)
    [chromosome1, chromosome2]
  end

  #Returns the best chromosome (Type Chromosome)
  def tournament(chromosome1, chromosome2) 
    # The chromosomes cannot be the same
    while chromosome2 == chromosome1 do
        chromosome2 =  rand(@lengthPopulation)
    end
    if(@chromosomes[chromosome1].normalizedFitness() >=  @chromosomes[chromosome2].normalizedFitness())
      return @chromosomes[chromosome1]
    else
      return @chromosomes[chromosome2]
    end
  end
  
    def tournament2(chromosome1, chromosome2) 
    # The chromosomes cannot be the same
    while chromosome2 == chromosome1 do
        chromosome2 =  rand(@lengthPopulation)
    end
    if(@chromosomes[chromosome1].normalizedFitness2(@fitnessDiversity.index(@fitnessDiversity.max()),@fitnessDiversity[chromosome1]) >=  @chromosomes[chromosome2].normalizedFitness2(@fitnessDiversity.index(@fitnessDiversity.max()),@fitnessDiversity[chromosome2]))
      return @chromosomes[chromosome1]
    else
      return @chromosomes[chromosome2]
    end
  end
  
  def roulette()
    probabilityPopulation = []
    cumulativeProbability = []
    #Calculate both probability and cumulative probability for each Chromosome based on their   fitness
    for i in 0...@chromosomes.length() do
      probabilityPopulation.append(@fitnessPopulation[i].to_f/@sumOfFitness)
    end
    
    cumulativeProbability.append(probabilityPopulation[0])
    
    for i in 1...@chromosomes.length() do
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



  #This function chooses the Selection Method and fills up the mating pool
  def selectionMethod(option,k)
    self.populationFitness() #ATAQUE
    #self.populationFitness2() DIVERSIDAD
    if (option==1) #Tournament
      for i in 0...k do 
        selectedChromosomes = self.selectCompetitorsTournament()
        @matingPool.push(self.tournament(selectedChromosomes[0], selectedChromosomes[1]))
      end
   elsif (option ==2) #Roulette
      for i in 0...k do
        @matingPool.push(self.roulette())
      end
    elsif (option == 3) 
      universalRandomSampling(k)
      p "mating pool size #{@matingPool.length}"
    end
  end

  #This methods reproduces the chromosomes that are in the mating pool
  def reproduction(option)
   i = 0
   if (option ==1) #mutation
      while i < @matingPool.length() do
        chromosome1 = @matingPool[i]
        @childrenPopulation.push(chromosome1.mutation())
        i = i + 1
      end
    elsif (option == 2) #cross and mutation
      while i < @matingPool.length() do
        chromosome1 = @matingPool[i]
        chromosome2 = @matingPool[i+1]
        if chromosome1.normalizedFitness() >= chromosome2.normalizedFitness()
         @childrenPopulation.push(chromosome2.cross(chromosome1)) 
        else
         @childrenPopulation.push(chromosome1.cross(chromosome2))  
        end 
        i = i + 2
      end
     i = 0
      while i < (@matingPool.length()*0.5).floor() do  #50% VARIABLE
        @childrenPopulation[i] = @childrenPopulation[i].mutation()
        i = i + 1
      end
    end
  end

  #No terminado
  def reproduction2(option)
   i = 0
   if (option ==1) #mutation
      while i < @matingPool.length() do
        chromosome1 = @matingPool[i]
        @childrenPopulation.push(chromosome1.mutation())
        i = i + 1
      end
    elsif (option == 2) #cross and mutation
      while i < @matingPool.length() do
        chromosome1 = @matingPool[i]
        chromosome2 = @matingPool[i+1]
        if chromosome1.normalizedFitness2() >= chromosome2.normalizedFitness2()
         @childrenPopulation.push(chromosome2.cross(chromosome1)) 
        else
         @childrenPopulation.push(chromosome1.cross(chromosome2))  
        end 
        i = i + 2
      end
     i = 0
      while i < (@matingPool.length()*0.5).floor() do  #50% VARIABLE
        @childrenPopulation[i] = @childrenPopulation[i].mutation()
        i = i + 1
      end
    end
  end


#Replaces the population with the new children randomly
  def randomReplacement()
    n = @childrenPopulation.length
    for i in 0...n do
      index = rand(0...@chromosomes.length)
      @chromosomes[index] = @childrenPopulation.pop()
    end
  end

#Replaces the population by weakest fitness. The weakest chromosomes get deleted
  def weakestReplacement()
    n = @childrenPopulation.length
  
    while @childrenPopulation.length > 0
      currentIndex = @fitnessPopulation.index(@fitnessPopulation.min())
      #p "Fitness #{fitnessPop}"
      #p "###############"
      #p "Fitness min #{@fitnessPopulation.min}"
      #p "Index min #{currentIndex}" 
      #p "Chromosome min #{@chromosomes[currentIndex].genes}"
      #p "Last child #{@childrenPopulation[@childrenPopulation.length - 1].genes}"
      
      @chromosomes[currentIndex] = @childrenPopulation.pop()
     
      p# "New chromosome #{@chromosomes[currentIndex].genes}"
    end
  end

  #This method chooses the method of replacement in the population
  def replacementSelection(option)
    if(option==1) #random
      randomReplacement()
     elsif (option ==2) #weakest
      weakestReplacement()
    end
  end

  #Clears data of the current generation except for the resulting population
  def clearCurrentGeneration()
    @matingPool.clear()
    @childrenPopulation.clear()
    @fitnessPopulation.clear()
  end
  
end

  
