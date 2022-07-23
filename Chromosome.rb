class Chromosome
  
  def initialize(length)
    @length = length
    @genes = []
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

  #Returns an array (the genes of the child chromosome)
  def cross(fatherChromosome)
    cutOffPoint = rand(@genes.length)
    motherValue = @genes[cutOffPoint]
    fatherPoint = fatherChromosome.searchNumber(motherValue)
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
  return sonChromosome.genes
  end


  #Returns an array (the genes of the child chromosome)
  def mutation()
    cutOffPoint1 = rand(@genes.length)
    cutOffPoint2 = rand(@genes.length)
    sonChromosome = Chromosome.new(@genes.length)
    @genes.length.times do |i|
      if i==cutOffPoint1
        sonChromosome.genes.push(@genes[cutOffPoint2])
       else
        if i== cutOffPoint2
          sonChromosome.genes.push(@genes[cutOffPoint1])
         else
          sonChromosome.genes.push(@genes[i])
        end
      end
    end
   return sonChromosome.genes 
  end

  #Returns an integer (the fitness of that chromosome)
  def fitness
    value = (@genes.length*(@genes.length-1))/2 - self.getThreat()
    return value
  end

  
end
