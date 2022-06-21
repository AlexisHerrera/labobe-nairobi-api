Dado('que tengo un pedido') do
  request = {'id_usuario' => '123', 'id_menu' => 1}.to_json
  response = Faraday.post(crear_pedido_url, request, header)
  @pedido = JSON.parse(response.body)
end

Y('yo estoy registrado con otra cuenta') do
  @request_first_user = {nombre: 'Pedro', telefono: '1123456799', direccion: 'Paseo Colon 851', id_telegram: '234'}.to_json
  @response_first_user = Faraday.post(crear_usuario_url, @request_first_user, header)
end

Y('esta En preparacion') do
  request = {'id_pedido' => @pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
end

Y('esta En camino') do
  request = {'id_pedido' => @pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)
end

Y('esta Entregado') do
  id_pedido = @pedido['id_pedido']
  request = {'id_pedido' => id_pedido}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)
end

Cuando('creo un pedido') do
  id_menu = 1
  request = {'id_usuario' => '123', 'id_menu' => id_menu}.to_json
  response = Faraday.post(crear_pedido_url, request, header)
  @pedido = JSON.parse(response.body)
end

Cuando('cambio el estado del pedido') do
  request = {'id_pedido' => @pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
end

Cuando('consulto el estado de un pedido inexistente') do
  params = { 'id_pedido' => 9999, 'id_usuario' => 123 }
  @response = Faraday.get(crear_pedido_url, params, header)
end

Entonces('el pedido esta {string}') do |estado|
  params = { 'id_pedido' => @pedido['id_pedido'].to_i, 'id_usuario' => 123 }
  response = Faraday.get(crear_pedido_url, params, header)
  expect(response.status).to eq(200)
  params = JSON.parse(response.body)
  expect(params['estado']).to eq estado
end

Entonces('recibo un codigo de error') do
  expect(@response.status).to eq(404)
end

Cuando('consulto el estado de ese pedido con otro usuario') do
  params = { 'id_pedido' => @pedido['id_pedido'].to_i, 'id_usuario' => 234 }
  @respuesta = Faraday.get(crear_pedido_url, params, header)
end

Entonces('recibo un mensaje con un error de pedido que no me pertenece') do
  expect(@respuesta.status).to eq(401)
end
