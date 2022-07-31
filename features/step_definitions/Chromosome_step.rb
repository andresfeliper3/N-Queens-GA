#enconding: utf-8
Dado(/que se necesita una población de cromosomas de tamaño (.+?), se crea un cromosoma/) do |chromosomeSize|
  @chromosomeSize = chromosomeSize
  @chromosome = Chromosome.new(chromosomeSize.to_i)
  @chromosome.buildGenes()
end

Cuando("se revisa el cromosoma") do
  @genesChromosome = @chromosome.genes
end

Entonces("no deben haber números repetidos") do 
  expect(@chromosome.checkGenes(@genesChromosome)).to eq true
end

Cuando(/el cromosoma es (.+?)/) do |genes|
  @chromosome = Chromosome.new(@chromosomeSize)
  @chromosome.genes = genes
  @numberOfThreats = @chromosome.getThreat()
end

Entonces("debe indicar que hay {int} conflictos") do |int|
   expect(@numberOfThreats).to eq int
end
