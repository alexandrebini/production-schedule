Fabricator(:path) do
  origin!(:fabricator => :position)
  target!(:fabricator => :position)
  distance{ rand(99) + 1 }
end