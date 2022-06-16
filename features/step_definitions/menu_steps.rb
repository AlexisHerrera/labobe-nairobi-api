Dado('que existe un menu') do
end

Cuando('un usuario consulta el menu') do
  @response = Faraday.get(obtener_menu_url)
end

Entonces('recibe el menu') do
  expect(@response.status).to eq(200)
  expect(@response.body).to eq([
    {
      'id' => 1,
      'descripcion' => 'Menu individual',
      'precio' => 1000.0
    },
    {
      'id' => 2,
      'descripcion' => 'Menu parejas',
      'precio' => 1500.0
    },
    {
      'id' => 3,
      'descripcion' => 'Menu familiar',
      'precio' => 2500.0
    }
  ].to_json)
end
