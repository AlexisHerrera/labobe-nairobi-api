Dado('que hay un repartidor') do
  nombre = 'Ying Hu'
  dni = '44455666'
  telefono = '1234567887'
  @request = {nombre: nombre, dni: dni, telefono: telefono}.to_json
  @response = Faraday.post(registrar_repartidor_url, @request, header)
  @id_repartidor = JSON.parse(@response.body)['id']
  expect(@response.status).to eq(201)
end

Dado('hay otro repartidor') do
  nombre = 'Carlos Solari'
  dni = '14367888'
  telefono = '1234567999'
  request = {nombre: nombre, dni: dni, telefono: telefono}.to_json
  response = Faraday.post(registrar_repartidor_url, request, header)
  @id_otro_repartidor = JSON.parse(response.body)['id']
end

Dado('que no hay un repartidores') do
  # no hace nada
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

Dado('tiene dos pedidos con menu individual asignados') do
  id_menu = 1
  request = {id_usuario: '123', id_menu: id_menu}.to_json
  response_pedido1 = Faraday.post(crear_pedido_url, request, header)
  response_pedido2 = Faraday.post(crear_pedido_url, request, header)

  id_pedido1 = JSON.parse(response_pedido1.body)['id_pedido']
  request = {'id_pedido' => id_pedido1}.to_json

  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)

  id_pedido2 = JSON.parse(response_pedido2.body)['id_pedido']
  request = {'id_pedido' => id_pedido2}.to_json

  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)
end

Dado('tiene un pedido con menu individual asignado') do
  id_menu = 1
  request = {id_usuario: '123', id_menu: id_menu}.to_json
  response_pedido = Faraday.post(crear_pedido_url, request, header)

  id_pedido = JSON.parse(response_pedido.body)['id_pedido']
  request = {'id_pedido' => id_pedido}.to_json

  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)
end

Dado('tiene un pedido con menu pareja asignado') do
  id_menu = 2
  request = {id_usuario: '123', id_menu: id_menu}.to_json
  response_pedido = Faraday.post(crear_pedido_url, request, header)

  id_pedido = JSON.parse(response_pedido.body)['id_pedido']
  request = {'id_pedido' => id_pedido}.to_json

  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)
end

Dado('tiene un pedido con menu familiar asignado') do
  id_menu = 3
  request = {id_usuario: '123', id_menu: id_menu}.to_json
  response_pedido = Faraday.post(crear_pedido_url, request, header)

  id_pedido = JSON.parse(response_pedido.body)['id_pedido']
  request = {'id_pedido' => id_pedido}.to_json

  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)
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

Entonces('el pedido no sale') do
  params = { 'id_pedido' => @id_pedido, 'id_usuario' => 123 }
  @response = Faraday.get(crear_pedido_url, params, header)
  estado = JSON.parse(@response.body)['estado']
  expect(estado).to eq('En preparacion')
end

Entonces('se le asigna ese repartidor') do
  # Puedo hacer un get a la BDD directamente para ver si guardo el repartidor
  pedido = Persistence::Repositories::PedidoRepository.new.find(@id_pedido)
  repartidor = Persistence::Repositories::RepartidorRepository.new.find(@id_repartidor)
  expect(pedido.repartidor_asignado).to eq(repartidor)
end

Entonces('se le asigna al segundo repartidor') do
  pedido = Persistence::Repositories::PedidoRepository.new.find(@id_pedido)
  repartidor = Persistence::Repositories::RepartidorRepository.new.find(@id_otro_repartidor)
  expect(pedido.repartidor_asignado).to eq(repartidor)
end

Entonces('no se le asigna repartidor') do
  pedido = Persistence::Repositories::PedidoRepository.new.find(@id_pedido)
  expect(pedido.repartidor_asignado).to eq(Repartidor.no_repartidor)
end
