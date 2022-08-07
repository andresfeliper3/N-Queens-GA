require './Chromosome.rb'
class Population
  def initialize(lengthPopulation, lengthChromosome)
    @lengthPopulation = lengthPopulation
    @lengthChromosome = lengthChromosome
    @chromosomes = []
    @matingPool = []
    @fitnessPopulation = [] # fitness for attack object function
    @threats = []
    @timesThreat = []
    @fitnessDiversity = [] # fitness for diversity object function
    @generalFitness = [] # fitness for both diversity and attack object functions.
    @childrenPopulation = []
    @sumOfFitness = 0
    @sumOfFitnessDiversity = 0
  end

  # getters and setters
  attr_accessor :lengthPopulation, :lengthChromosome, :chromosomes, :fitnessPopulation, :matingPool, :childrenPopulation, :sumOfFitness, :fitnessDiversity, :timesThreat, :threats, :generalFitness

  # This method fills the fitnessPopulation array with the normal fitness of every chromosome
  def populationFitness
    (0...@chromosomes.length).each do |i|
      @fitnessPopulation.push(@chromosomes[i].normalizedFitness)
    end
    @sumOfFitness = @fitnessPopulation.sum
    p "population fitness sum #{@sumOfFitness}"
  end

  # This method fills the fitnessPopulation array with the diversity-based fitness of every chromosome
  def populationFitness2
    getDiversityFitness
    populationFitness
  end

  def populationFitness3
    populationFitness
    (0...@chromosomes.length / 2).each do |i|
      @generalFitness.push(@chromosomes[i].normalizedFitness)
    end

    getDiversityFitness
    (@chromosomes.length / 2...@chromosomes.length).each do |i|
      @generalFitness.push(@fitnessDiversity[i])
    end
  end

  # This methods fills the threats array with the amount of threats that each chromosome has
  def getThreats
    (0...@chromosomes.length).each do |i|
      @threats.push(@chromosomes[i].getThreat)
    end
  end

  # getTimes: number, array -> number
  # This methods receives the number of threats of a chromosome and the list of amount of threats in the population.
  # It counts how many chromosomes have the same number of threats as the current chromosome and returns this value
  def getTimes(numberOfThreats, threatsList)
    acum = 0
    (0...threatsList.length).each do |i|
      acum += 1 if numberOfThreats == threatsList[i]
    end
    acum
  end

  # This method fills the timesThreat array with the amounts of chromosomes that have the same number of threats.
  # timesThreat[i] contains the amount of chromosomes that have the same number of threats as chromosome i in chromosomes[i]
  def getTimesThreat
    getThreats
    (0...@chromosomes.length).each do |i|
      @timesThreat.push(getTimes(@chromosomes[i].getThreat, @threats))
    end
  end

  # This method fills the fitnessDiversity array with the diversity-based fitness of every chromosome
  def getDiversityFitness
    getTimesThreat
    (0...@chromosomes.length).each do |i|
      @fitnessDiversity.push(@chromosomes[i].fitness2(@timesThreat[i]))
    end
    @sumOfFitnessDiversity = @fitnessDiversity.sum
  end

  def showMatingPool
    (0...@matingPool.length).each do |i|
      # p @matingPool[i].genes
    end
  end

  def showPopulation
    fitChromosomes = []
    (0...@chromosomes.length).each do |i|
      if @chromosomes[i].normalizedFitness == 1.0
        p "#{@chromosomes[i].genes} - fitness #{@chromosomes[i].normalizedFitness} , diversity fitness #{@chromosomes[i].normalizedDiversityFitness}, threats: #{@chromosomes[i].getThreat}"
        fitChromosomes.push(@chromosomes[i].genes)
      end
    end
    fitChromosomes
  end

  def showChildrenPopulation
    (0...@childrenPopulation.length).each do |i|
      # p @childrenPopulation[i].genes
    end
  end

  # Sets the initial
  def buildPopulation
    # The following code is only for showing the chromosomes
    (0...@lengthPopulation).each do |_i|
      newChromosome = Chromosome.new(@lengthChromosome)
      newChromosome.buildGenes
      @chromosomes.push(newChromosome)
      # @chromosomes.push(Chromosome.new(@lengthChromosome))
    end
  end

  def selectCompetitorsTournament
    chromosome1 = rand(@lengthPopulation)
    chromosome2 = rand(@lengthPopulation)
    [chromosome1, chromosome2]
  end

  # Returns the best chromosome (Type Chromosome)
  def tournament(chromosome1, chromosome2)
    # The chromosomes cannot be the same
    chromosome2 =  rand(@lengthPopulation) while chromosome2 == chromosome1
    if @chromosomes[chromosome1].normalizedFitness >= @chromosomes[chromosome2].normalizedFitness
      @chromosomes[chromosome1]
    else
      @chromosomes[chromosome2]
    end
  end

  def tournament2(chromosome1, chromosome2)
    # The chromosomes cannot be the same
    chromosome2 = rand(@lengthPopulation) while chromosome2 == chromosome1
    '''if(@chromosomes[chromosome1].normalizedFitness2(@fitnessDiversity.index(@fitnessDiversity.max()),@fitnessDiversity[chromosome1]) >=  @chromosomes[chromosome2].normalizedFitness2(@fitnessDiversity.index(@fitnessDiversity.max()),@fitnessDiversity[chromosome2]))'''
    if @chromosomes[chromosome1].normalizedDiversityFitness >= @chromosomes[chromosome2].normalizedDiversityFitness

      @chromosomes[chromosome1]
    else
      @chromosomes[chromosome2]
    end
  end

  def roulette
    probabilityPopulation = []
    cumulativeProbability = []
    # Calculate both probability and cumulative probability for each Chromosome based on their   fitness
    (0...@chromosomes.length).each do |i|
      probabilityPopulation.append(@fitnessPopulation[i].to_f / @sumOfFitness)
    end

    cumulativeProbability.append(probabilityPopulation[0])

    (1...@chromosomes.length).each do |i|
      cumulativeProbability.append(probabilityPopulation[i] + cumulativeProbability[i - 1])
    end
    r = rand(0.0..1.0)
    if r < cumulativeProbability[0]
      @chromosomes[0]
    else
      (1...cumulativeProbability.length).each do |i|
        return @chromosomes[i] if (cumulativeProbability[i - 1] < r) && (r <= cumulativeProbability[i])
      end
    end
  end

  def roulette2
    probabilityPopulation = []
    cumulativeProbability = []
    # Calculate both probability and cumulative probability for each Chromosome based on their   fitness
    (0...@chromosomes.length).each do |i|
      probabilityPopulation.append(@fitnessDiversity[i].to_f / @sumOfFitnessDiversity)
    end

    cumulativeProbability.append(probabilityPopulation[0])

    (1...@chromosomes.length).each do |i|
      cumulativeProbability.append(probabilityPopulation[i] + cumulativeProbability[i - 1])
    end
    r = rand(0.0..1.0)
    if r < cumulativeProbability[0]
      @chromosomes[0]
    else
      (1...cumulativeProbability.length).each do |i|
        return @chromosomes[i] if (cumulativeProbability[i - 1] < r) && (r <= cumulativeProbability[i])
      end
    end
  end

  # This function chooses the Selection Method and fills up the mating pool
  def selectionMethod(objectiveFunction, option, k)
    if objectiveFunction == 1
      populationFitness # ATAQUE
      if option == 1 # Tournament
        (0...k).each do |_i|
          selectedChromosomes = selectCompetitorsTournament
          @matingPool.push(tournament(selectedChromosomes[0], selectedChromosomes[1]))
        end
      else # Roulette - option 2
        (0...k).each do |_i|
          @matingPool.push(roulette)
        end
      end
    elsif objectiveFunction == 2
      populationFitness2 # DIVERSIDAD
      if option == 1 # Tournament
        (0...k).each do |_i|
          selectedChromosomes = selectCompetitorsTournament
          @matingPool.push(tournament2(selectedChromosomes[0], selectedChromosomes[1]))
        end
      else # Roulette - option 2
        (0...k).each do |_i|
          @matingPool.push(roulette2)
        end
      end
    else # objectiveFunction:  Diversity and attack
      populationFitness3()
      (0...k / 2).each do |_i|
        if option == 1 # tournament
          selectedChromosomes = selectCompetitorsTournament
          @matingPool.push(tournament(selectedChromosomes[0], selectedChromosomes[1]))
        else
          @matingPool.push(roulette)
        end
      end
      (k / 2...k).each do |_i|
        if option == 1
          selectedChromosomes = selectCompetitorsTournament
          @matingPool.push(tournament2(selectedChromosomes[0], selectedChromosomes[1]))
        else
          @matingPool.push(roulette2)
        end
      end
    end

    # This methods reproduces the chromosomes that are in the mating pool
    def reproduction(objectiveFunction, option)
      if objectiveFunction == 1 # Attack
        i = 0
        if option == 1 # mutation
          while i < @matingPool.length
            chromosome1 = @matingPool[i]
            @childrenPopulation.push(chromosome1.mutation)
            i += 1
          end
        else # cross and mutation
          while i < @matingPool.length
            chromosome1 = @matingPool[i]
            chromosome2 = @matingPool[i + 1]
            if chromosome1.normalizedFitness >= chromosome2.normalizedFitness
              @childrenPopulation.push(chromosome2.cross(chromosome1))
            else
              @childrenPopulation.push(chromosome1.cross(chromosome2))
            end
            i += 2
          end
          i = 0
          while i < (@matingPool.length * 0.5).floor # 50% VARIABLE
            @childrenPopulation[i] = @childrenPopulation[i].mutation
            i += 1
          end
        end
      elsif objectiveFunction == 2 # Objective Function: Diversity
        i = 0
        if option == 1 # mutation
          while i < @matingPool.length
            chromosome1 = @matingPool[i]
            @childrenPopulation.push(chromosome1.mutation)

            i += 1
          end
        else # cross and mutation
          while i < @matingPool.length
            chromosome1 = @matingPool[i]
            chromosome2 = @matingPool[i + 1]
            if chromosome1.normalizedDiversityFitness >= chromosome2.normalizedDiversityFitness
              @childrenPopulation.push(chromosome2.cross(chromosome1))
            else
              @childrenPopulation.push(chromosome1.cross(chromosome2))
            end
            i += 2
          end
          i = 0
          while i < (@matingPool.length * 0.5).floor # 50% VARIABLE
            @childrenPopulation[i] = @childrenPopulation[i].mutation
            i += 1
          end
        end
      else # Diversity and attack
        i = 0
        if option == 1 # mutation
          while i < @matingPool.length / 2
            chromosome1 = @matingPool[i]
            @childrenPopulation.push(chromosome1.mutation)
            i += 1
          end
        else # cross and mutation
          while i < @matingPool.length
            chromosome1 = @matingPool[i]
            chromosome2 = @matingPool[i + 1]
            @childrenPopulation.push(chromosome2.cross(chromosome1))
            i += 2
          end
          i = 0
          while i < (@matingPool.length * 0.5).floor # 50% VARIABLE
            @childrenPopulation[i] = @childrenPopulation[i].mutation
            i += 1
          end
        end
      end
    end

    # Replaces the population with the new children randomly
    def randomReplacement
      n = @childrenPopulation.length
      (0...n).each do |_i|
        index = rand(0...@chromosomes.length)
        @chromosomes[index] = @childrenPopulation.pop
      end
    end

    # Replaces the population by weakest fitness. The weakest chromosomes get deleted
    def weakestReplacement
      n = @childrenPopulation.length

      while @childrenPopulation.length > 0
        currentIndex = @fitnessPopulation.index(@fitnessPopulation.min)
        @chromosomes[currentIndex] = @childrenPopulation.pop
      end
    end

    # Replaces the population by weakest fitness. The weakest chromosomes get deleted
    def weakestReplacement2
      n = @childrenPopulation.length

      while @childrenPopulation.length > 0
        currentIndex = @fitnessDiversity.index(@fitnessDiversity.min)
        @chromosomes[currentIndex] = @childrenPopulation.pop
      end
    end

    # This method chooses the method of replacement in the population
    def replacementSelection(objectiveFunction, option)
      if option == 1 # random
        randomReplacement
      elsif option == 2 # weakest
        if objectiveFunction == 1
          weakestReplacement
        else # Diversity
          weakestReplacement2
        end
      else # Diversity and attack
        randomReplacement
      end
    end

    if (objectiveFunction == 2) || (objectiveFunction == 3)
      @threats.clear
      @fitnessDiversity.clear
      @timesThreat.clear
      getDiversityFitness
    end
  end

  # Clears data of the current generation except for the resulting population
  def clearCurrentGeneration
    @matingPool.clear
    @childrenPopulation.clear
    @fitnessPopulation.clear
    @threats.clear
    @timesThreat.clear
    @fitnessDiversity.clear
  end
end
