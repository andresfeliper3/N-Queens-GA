#enconding: utf-8
Dado(/que se necesita una población de cromosomas de tamaño (.+?), se crea un cromosoma/) do |chromosomeSize|
  @chromosome = Chromosome.new(chromosomeSize.to_i)
end

Cuando("se revisa el cromosoma") do
  @genesChromosome = @chromosome.genes
end

Entonces("no deben haber números repetidos") do 
  expect(@chromosome.checkGenes(@genesChromosome)).to eq true
end