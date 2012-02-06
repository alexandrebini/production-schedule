Fabricator(:roadmap) do
  product!
  machines!(:count => 3)
end