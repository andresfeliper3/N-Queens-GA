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

Cuando("el cromosoma es {int},{int},{int},{int},{int},{int},{int},{int}") do |int1,int2,int3,int4,int5,int6,int7, int8|
  @chromosome = Chromosome.new(@chromosomeSize.to_i)
  list =[int1,int2,int3,int4,int5,int6,int7, int8]
  @chromosome.genes = list
  @numberOfThreats = @chromosome.getThreat()
  p "number of threads above #{@numberOfThreats}"
end

Entonces("debe indicar que hay {int} conflictos") do |int|
  p "number of threads below #{@numberOfThreats}"
  expect(@numberOfThreats).to eq int
end
