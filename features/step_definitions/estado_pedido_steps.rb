Dado('que tengo un pedido') do
  request = {id_usuario: '123', id_menu: 1}.to_json
  response = Faraday.post(crear_pedido_url, request, header)
  @pedido = JSON.parse(response.body)
end

Y('esta En preparacion') do
  debugger
  request = {id_pedido: @pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
end

Y('esta En camino') do
  request = {id_pedido: @pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)
end

Y('esta Entregado') do
  request = {id_pedido: @pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)
end

Cuando('creo un pedido') do
  id_menu = 1
  request = {id_usuario: '123', id_menu: id_menu}.to_json
  response = Faraday.post(crear_pedido_url, request, header)
  @pedido = JSON.parse(response.body)
end

Cuando('cambio el estado del pedido') do
  debugger
  request = {id_pedido: @pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
end

Entonces('el pedido esta {string}') do |estado|
  id_pedido = @pedido['id_pedido'].to_i
  response = Faraday.get(consultar_estado_pedido_url(id_pedido))
  expect(response.status).to eq(200)
  params = JSON.parse(response.body)
  expect(params['estado']).to eq estado
end
