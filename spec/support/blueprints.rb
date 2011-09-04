require 'machinist/active_record'

Machine.blueprint do
  name { Faker::Lorem.words.first }
end

Product.blueprint do
  name { Faker::Lorem.words.first }
  operation_times do
    return self.object.operation_times unless self.object.operation_times.blank?
    Array.new(3){ OperationTime.make!(:product => self.object) }
  end
  roadmaps do
    return self.object.roadmaps unless self.object.roadmaps.blank?
    Array.new(2){ Roadmap.make(:product => self.object, :machines => self.object.operation_times.map(&:machine) ) }
  end
end

Roadmap.blueprint do
  product
  machines(3)
end

OperationTime.blueprint do
  product
  machine
  time { rand(50) + 50 }
end

Schedule.blueprint do
  operations { Array.new(5){ ScheduleOperation.make(:schedule => self.object) } }
  training
  makespan { rand 99 }
end

ScheduleTraining.blueprint do
  products(2)
  length { 30 }
  max_generations { 100 }
  mutation_rate { 1 }
  crossover_rate { 75 }
end

ScheduleOperation.blueprint do
  schedule
  product
  machine

  start_at { rand(999) }
  end_at { rand(999) + 999 }
end

