require './Chromosome.rb'
N = 10
poblationSize = 50
#Initial poblation of chromosomes
poblation = []
#The following code is only for showing the chromosomes 
for i in 0...poblationSize do
  poblation.push(Chromosome.new(N))
  puts "----------"
  puts poblation[i].genes()
end


