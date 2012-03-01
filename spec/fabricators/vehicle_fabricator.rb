Fabricator(:vehicle) do
  name { Faker::Lorem.words.first }
  distance{ rand(9) + 1 }
end