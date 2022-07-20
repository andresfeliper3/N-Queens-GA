class Chromosome
  
  def initialize(length)
    @length = length
    @genes = buildGenes()
  end
  
  attr_accessor :length, :genes #getters and setters
  
  def buildGenes()
    possibleGenes = (0...@length).to_a() #array from 0 to length-1
    possibleGenes.shuffle()
  end
end
