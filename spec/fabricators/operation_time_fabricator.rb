Fabricator(:operation_time) do
  machine!
  product!
  time { rand(50) + 50 }
end