require 'machinist/active_record'

Machine.blueprint do
  name { Faker::Lorem.words.first }
end

Product.blueprint do
  name { Faker::Lorem.words.first }
  roadmaps { Array.new(5){ Roadmap.make(:product => self.object) } }
end

Roadmap.blueprint do
  product
  machines(5)
end

OperationTime.blueprint do
  product
  machine
  time { rand 9999 }
end

# GA lib
GARuby::Models::Product.blueprint {}

