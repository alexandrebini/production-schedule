Fabricator(:transport) do
  on_init {
    init_with(
      :roadmap => Fabricate(:roadmap),
      :vehicle => Fabricate(:vehicle),
      :schema => Fabricate(:schema)
    )
  }
end