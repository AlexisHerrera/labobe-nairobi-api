Dado('que hay un repartidor') do
  nombre = 'Ying Hu'
  dni = '44455666'
  telefono = '1234567887'

  @request = {nombre: nombre, dni: dni, telefono: telefono}.to_json
  @response = Faraday.post(registrar_repartidor_url, @request, header)
  expect(@response.status).to eq(201)
end

Dado('no tiene pedidos asignados') do
  true
end

Dado('hay un pedido con menu individual sin asignar') do
  id_menu = 1
  @request = {id_usuario: '123', id_menu: id_menu}.to_json
  @response_pedido = Faraday.post(crear_pedido_url, @request, header)
end

Dado('hay un pedido con menu pareja sin asignar') do
  id_menu = 2
  @request = {id_usuario: '123', id_menu: id_menu}.to_json
  @response_pedido = Faraday.post(crear_pedido_url, @request, header)
end

Dado('hay un pedido con menu familiar sin asignar') do
  id_menu = 3
  @request = {id_usuario: '123', id_menu: id_menu}.to_json
  @response_pedido = Faraday.post(crear_pedido_url, @request, header)
end

Cuando('el pedido pasa del estado {string} a {string}') do |_string, _string2|
  @id_pedido = JSON.parse(@response_pedido.body)['id_pedido']
  request = {'id_pedido' => @id_pedido}.to_json

  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)
end

Entonces('el repartidor sale') do
  params = { 'id_pedido' => @id_pedido, 'id_usuario' => 123 }
  @response = Faraday.get(crear_pedido_url, params, header)
  estado = JSON.parse(@response.body)['estado']
  expect(estado).to eq('Entregado')
end

Entonces('el repartidor no sale') do
  params = { 'id_pedido' => @id_pedido, 'id_usuario' => 123 }
  @response = Faraday.get(crear_pedido_url, params, header)
  estado = JSON.parse(@response.body)['estado']
  expect(estado).to eq('En camino')
end

Entonces('se le asigna ese repartidor') do
  params = {'id_pedido' => @id_pedido}
  response = Faraday.get(entregas_url, params, header)

  expect(response.status).to eq 200
  cuerpo = JSON.parse(response.body)
  expect(cuerpo['id_repartidor'].nil?).to eq(false)
end
