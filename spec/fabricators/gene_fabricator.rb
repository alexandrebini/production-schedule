Fabricator(:gene) do
  on_init {
    product = Fabricate(:product)
    init_with(
      :product => product,
      :roadmap => Fabricate(:roadmap, :product => product)
    )
  }
end