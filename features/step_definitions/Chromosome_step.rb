#enconding: utf-8
Dado(/que se necesita una población de cromosomas de tamaño (.+?), se crea un cromosoma/) do |chromosomeSize|
  @chromosomeSize = chromosomeSize
  @chromosome = Chromosome.new(@chromosomeSize.to_i)
  @chromosome.buildGenes()
end

Cuando("se revisa el cromosoma") do
  @genesChromosome = @chromosome.genes
end
  
Entonces("no deben haber números repetidos") do 
  expect(@chromosome.checkGenes(@genesChromosome)).to eq true
end

Y("la funcion de fitness normalizada debe ser {int}") do |int|
  expect(@chromosome.normalizedFitness()).to eq int
end

Dado(/cromosomas de tamaño (.+?), se hacen pruebas/) do |size|
  @chromosomeSize = size
  @chromosome = Chromosome.new(@chromosomeSize.to_i)
end
Cuando("el cromosoma es {}") do |array|
  list = []
  array.split(',').each{|entry| list.push(entry.to_i)}
  @chromosome.genes = list
end

Entonces("debe indicar que hay {int} conflictos") do |int|
  @numberOfThreats = @chromosome.getThreat()
  expect(@numberOfThreats).to eq int
end

Y("el cromosoma muta") do
  @chromosomeSon = @chromosome.mutation()
end

Entonces("debe indicar que hay {int} genes diferentes") do |int|
  diffCounter = 0
  for i in 0...@chromosome.genes.length do
    if(@chromosome.genes[i] != @chromosomeSon.genes[i])
        diffCounter = diffCounter + 1
    end
  end
  expect(diffCounter).to eq int
end

Cuando("el cromosoma padre es {} y el cromosoma madre es {}") do |father, mother|
  fatherList = []
  motherList = [] 
  father.split(',').each{|entry| fatherList.push(entry.to_i)}
  mother.split(',').each{|entry| motherList.push(entry.to_i)}
  @chromosome = Chromosome.new(@chromosomeSize.to_i)
  @chromosomeMother = Chromosome.new(@chromosomeSize.to_i)
  @chromosomeMother.genes = motherList
  @chromosome.genes = fatherList
end

Y("los cromosomas se cruzan") do
  @chromosomeSon = @chromosomeMother.cross(@chromosome)
  p "Show son #{@chromosomeSon.genes}"
end