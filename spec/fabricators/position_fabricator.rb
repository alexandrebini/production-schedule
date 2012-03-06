Fabricator(:position) do
  name {
    sequence(:name) { |i| Faker::Lorem.words.first + i.to_s }
  }
  schema!
  machine!
end