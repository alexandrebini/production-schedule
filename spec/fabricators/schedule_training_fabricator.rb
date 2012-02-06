Fabricator(:schedule_training) do
  products!(:count => 2)
  length { 30 }
  max_generations { 100 }
  mutation_rate { 1 }
  crossover_rate { 75 }
end