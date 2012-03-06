Fabricator(:vehicle) do
  name { Faker::Lorem.words.first }
  speed { rand(9) + 1 }
end