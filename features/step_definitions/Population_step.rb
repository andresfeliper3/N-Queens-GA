# enconding: utf-8
Dado('que se necesita una población de tamaño {int} de cromosomas de tamaño {int}, se crea la población') do |populationSize, chromosomeSize|
  @population = Population.new(populationSize, chromosomeSize)
  @population.buildPopulation
end

Cuando('se revisa la población') do
  @populationSize = @population.chromosomes.length
end

Entonces('la población debe ser de tamaño {int}') do |int|
  expect(@populationSize).to eq int
end

Y('cada elemento debe ser un cromosoma válido') do
  allChromosomes = true
  @population.chromosomes.each do |x|
    allChromosomes = false unless x.instance_of? Chromosome
    expect(allChromosomes).to eq true
  end
end

Cuando('se seleccionan dos cromosomas para el torneo') do
  @candidatesIndex = @population.selectCompetitorsTournament
  @winnerTournament = @population.tournament(@candidatesIndex[0], @candidatesIndex[1])
end

Entonces('el cromosoma ganador debe ser más apto que el perdedor') do
  betterThanFirst = @winnerTournament.normalizedFitness() >= (@population.chromosomes[@candidatesIndex[0]]).normalizedFitness()
  betterThanSecond = @winnerTournament.normalizedFitness() >= (@population.chromosomes[@candidatesIndex[1]]).normalizedFitness()
  best = betterThanFirst and betterThanSecond
  expect(best).to eq true
  
end
