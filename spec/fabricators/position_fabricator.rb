Fabricator(:position) do
  name { Faker::Lorem.words.first }
  schema!
  machine!
end