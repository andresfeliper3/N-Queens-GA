class Chromosome
  
  def initialize(length)
    @length = length
    @genes = []
    @normalizedFitness = 0
    @maxNumberOfConflicts = (@genes.length*(@genes.length-1))/2
    #@genes = buildGenes()
  end
  
  attr_accessor :length, :genes #getters and setters
  
  def buildGenes()
    possibleGenes = (0...@length).to_a() #array from 0 to length-1
    @genes = possibleGenes.shuffle()
  end

  #Returns true if all genes are different and the size is correct
  def checkGenes(genesList)
   genesList == genesList.uniq and genesList.size == @length
  end  


  #Function returns the number of threats          
  def getThreat()
    threatInitial =0
    @genes.length.times do |i|
      @genes.length.times do |j|
        if (i != j)
          if (@genes[i]-@genes[j]).abs() == (i-j).abs()
            threatInitial +=1
          end
        end
      end
    end
    return threatInitial/2
  end


  #Returns an integer 
  def searchNumber(value)
    @genes.length.times do |i|
      if(@genes[i]==value)
        return i
      end
    end
  end

  #Returns child chromosome (Type Chromosome)
  def cross(fatherChromosome) 
    cutOffPoint = rand(@genes.length)
    motherValue = @genes[cutOffPoint]
    fatherPoint = fatherChromosome.searchNumber(motherValue)
    while cutOffPoint == fatherPoint do
      cutOffPoint = rand(@genes.length)
      motherValue = @genes[cutOffPoint]
      fatherPoint = fatherChromosome.searchNumber(motherValue)
    end
    sonChromosome = Chromosome.new(@genes.length)
    @genes.length.times do |i|
      if i==cutOffPoint
        sonChromosome.genes.push(motherValue) #put the value that the mother had at that cutoff point (taken from the random)
       else
        if i== fatherPoint 
          sonChromosome.genes.push(fatherChromosome.genes[cutOffPoint]) #put the value that the father had at that cutoff point (taken from the random)
         else
          sonChromosome.genes.push(fatherChromosome.genes[i])
        end
      end
    end
  return sonChromosome
  end


  #Returns the child chromosome (Type Chromosome)
  def mutation()
    cutOffPoint1 = rand(@genes.length)
    cutOffPoint2 = rand(@genes.length)
    while cutOffPoint1 == cutOffPoint2 do
      cutOffPoint2 = rand(@genes.length)
    end
    sonChromosome = Chromosome.new(@genes.length)
    @genes.length.times do |i|
      if i==cutOffPoint1
        sonChromosome.genes.push(@genes[cutOffPoint2])
       else
        if i == cutOffPoint2
          sonChromosome.genes.push(@genes[cutOffPoint1])
         else
          sonChromosome.genes.push(@genes[i])
        end
      end
    end
   return sonChromosome
  end
  
  #Returns an integer (the fitness of that chromosome)
  def fitness()
    value = @maxNumberOfConflicts - self.getThreat()
    value
  end

  #Returns a value between 0 and 1, from the lowest to the highest fitness level
  def normalizedFitness()
    @normalizedFitness = fitness()/@maxNumberOfConflicts
    @normalizedFitness
  end

  #Receives the sumatory of the fitness of all chromosomes
  #Returns the probability to be selected in a determined pool.
  def probabilityToBeSelected(sumOfFitness)
    @normalizedFitness/sumOfFitness
  end
  
end
