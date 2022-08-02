require './Population.rb'

def writeResults(fileName, args)
  file = File.new(fileName, "w")
  file.puts("lengthPopulation: #{args[0]} \n")
  file.puts("lengthChromosome: #{args[1]} \n")
  file.puts("lengthMatingPool: #{args[2]} \n")
  file.puts("generations:  #{args[3]} \n")
  file.puts("------------------------------------ \n")
  file.puts("Selection Method: #{args[4]} \n")
  file.puts("Reproduction Method: #{args[5]} \n")
  file.puts("Replacement Selection Method: #{args[6]} \n\n")
  file.puts("Results: \n")
  args[7].each do |generation, chromosomes|
    if !chromosomes.empty?
      file.puts("Generation #{generation} -> #{chromosomes}")
    end
  end
  
  #for i in 0...genes.length do
   # file.puts("Chromosome " + (i + 1) + ": " chromosomes[i].genes.join(", ") + "\n")
  #end
  
  #file.puts(array.join(", ") + "\n")
  #file.puts("Siguiente línea")
  
end

def getSelectionMethodName(option)
  case option
    when 1
      "Tournament"
    when 2 
      "Roulette"
    else
      "Selection method has not been specified"
  end
end

def getReproductionMethodName(option)
  case option
    when 1
      "Mutation"
    when 2 
      "Cross and mutation"
    else
      "Reproduction method has not been specified"
  end
end

def getReplacementSelectionMethodName(option)
  case option
    when 1
      "Random"
    when 2 
      "Weakest Replacement"
    else
      "Replacement method has not been specified"
  end
end

def main
  lengthPopulation = 100
  lengthChromosome = 8
  lengthMatingPool = 60 # even
  generations = 40
  selectionMethod = 1
  reproductionMethod = 1
  replacementSelection = 2
  hash = {}
  argsForFile = [lengthPopulation, lengthChromosome, lengthMatingPool, generations, getSelectionMethodName(selectionMethod), getReproductionMethodName(reproductionMethod),
  getReplacementSelectionMethodName(replacementSelection), hash]
   
  
  population = Population.new(lengthPopulation, lengthChromosome)
  population.buildPopulation

  (1..generations).each do |i|
    p "--------------GENERATION #{i}-------------------------"
    population.selectionMethod(selectionMethod, lengthMatingPool)
    p 'MATING POOL'
    population.showMatingPool
    population.reproduction(reproductionMethod)
    p 'CHILDREN POPULATION'
    population.showChildrenPopulation()
    p 'CURRENT POPULATION'
    population.replacementSelection(replacementSelection)
    fitChromosomes = population.showPopulation()
    hash[i] = fitChromosomes
    population.clearCurrentGeneration
    p "-------------END OF GENERATION #{i}------------------"
  end

  puts "Do you want to keep this results? (y/n)"
  keepResults = gets.chomp
  if keepResults.downcase() != "n"
    puts "Write down the path and file name (path/filename), path is optional"
    path = gets.chomp
    writeResults("out/#{path}", argsForFile)
  end
end


main


