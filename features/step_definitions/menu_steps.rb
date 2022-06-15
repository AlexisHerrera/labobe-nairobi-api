Dado('que existe un menu') do
end

Cuando('un usuario consulta el menu') do
  @request = {}.to_json
  @response = Faraday.get(obtener_menu_url, @request, header)
end

Entonces('recibe el menu') do
  expect(@response.status).to eq(200)
  expect(@response.body).to eq([
                                 {
                                   'id' => 1,
                                   'descripcion' => 'Menu individual',
                                   'precio' => 1000
                                 },
                                 {
                                   'id' => 2,
                                   'descripcion' => 'Menu pareja',
                                   'precio' => 1500
                                 },
                                 {
                                   'id' => 3,
                                   'descripcion' => 'Menu familiar',
                                   'precio' => 2000
                                 }
                               ])
end
