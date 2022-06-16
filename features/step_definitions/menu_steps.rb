Dado('que existe un menu') do
  # Lo hace la seed
end

Cuando('un usuario consulta el menu') do
  @response = Faraday.get(obtener_menu_url)
end

Entonces('recibe el menu') do
  expect(@response.status).to eq(200)
  expect(@response.body).to eq([
    {
      'id' => 1,
      'descripcion' => 'Menu Individual',
      'precio' => 1000.0
    },
    {
      'id' => 2,
      'descripcion' => 'Menu Pareja',
      'precio' => 1500.0
    },
    {
      'id' => 3,
      'descripcion' => 'Menu Familiar',
      'precio' => 2000.0
    }
  ].to_json)
end
