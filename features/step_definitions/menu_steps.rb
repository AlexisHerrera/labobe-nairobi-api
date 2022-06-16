Dado('que existe un menu') do
  @request1 = {id: 1, descripcion: 'Menu Individual', precio: 1000}.to_json
  @request2 = {id: 2, descripcion: 'Menu Pareja', precio: 1500}.to_json
  @request3 = {id: 3, descripcion: 'Menu Familiar', precio: 2000}.to_json

  Faraday.post(crear_menu_url, @request1, header)
  Faraday.post(crear_menu_url, @request2, header)
  Faraday.post(crear_menu_url, @request3, header)
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
