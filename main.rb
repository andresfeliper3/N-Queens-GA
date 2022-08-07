require './Population.rb'


def writeResults(fileName, args, solutionList)
  file = File.new(fileName, "w")
  file.puts("Objective Function: #{args[0]} \n")
  file.puts("lengthPopulation: #{args[1]} \n")
  file.puts("lengthChromosome: #{args[2]} \n")
  file.puts("lengthMatingPool: #{args[3]} \n")
  file.puts("generations:  #{args[4]} \n")
  file.puts("------------------------------------ \n")
  file.puts("Selection Method: #{args[5]} \n")
  file.puts("Reproduction Method: #{args[6]} \n")
  file.puts("Replacement Selection Method: #{args[7]} \n\n")
  file.puts("Results: \n")
  args[8].each do |generation, values|
    if !values[1].empty?
      file.puts("Generation #{generation} (#{values[1].length}) (#{values[0]}) -> #{values[1]} \n")
    end
  end
  #Solutions without repetitions
  file.puts("------------------------------------ \n")
  file.puts("The #{solutionList.length} solutions found are: \n")
  file.puts(solutionList)
  
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

def getObjectiveFunctionMethodName(option)
  case option
    when 1
      "Attack"
    when 2
      "Diversity"
    when 3
      "Attack and diversity"
    else
      "No objective function has been selected"
  end
end

def main
  objectiveFunction = 3 #1 Attacks - 2 Diversity - 3 Attack and diversity
  lengthPopulation = 100
  lengthChromosome = 8
  lengthMatingPool = 80 # even
  generations = 200
  selectionMethod = 1  # 1 Tournament - 2 Roulette
  reproductionMethod = 2 # 1 Mutation - 2 Cross and mutation
  replacementSelection = 2 # 1 Random -  2 Weakest Replacement
  hash = {}
  argsForFile = [getObjectiveFunctionMethodName(objectiveFunction),lengthPopulation, lengthChromosome, lengthMatingPool, generations, getSelectionMethodName(selectionMethod), getReproductionMethodName(reproductionMethod),
  getReplacementSelectionMethodName(replacementSelection), hash]
   solutionList = nil
  
  population = Population.new(lengthPopulation, lengthChromosome)
  population.buildPopulation()
  population.showPopulation()
  
  (1..generations).each do |i|
    p "--------------GENERATION #{i}-------------------------"
    population.selectionMethod(objectiveFunction, selectionMethod, lengthMatingPool)
    p 'MATING POOL'
    population.showMatingPool
    population.reproduction(objectiveFunction, reproductionMethod)
   # p 'CHILDREN POPULATION'
    #population.showChildrenPopulation()
    p 'CURRENT POPULATION'
    population.replacementSelection(objectiveFunction, replacementSelection)
    fitChromosomes = population.showPopulation()
    
    #unique solutions
    solutionList = fitChromosomes.uniq
    p "There are a total of #{solutionList.length} unique solutions"
    #hash
    hash[i] = ["U.S: #{solutionList.length}", fitChromosomes]
    #clear
    population.clearCurrentGeneration()
  
    p "-------------END OF GENERATION #{i}------------------"
  
  end

  #remove repeated fit chromosomes in the solution list
  
  puts "Do you want to keep this results? (y/n)"
  keepResults = gets.chomp
  if keepResults.downcase() != "n"
    puts "Write down the path and file name (path/filename), path is optional"
    path = gets.chomp
    writeResults("out/#{path}", argsForFile, solutionList)
  end
end


main



