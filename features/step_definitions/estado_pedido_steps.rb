Cuando('creo un pedido') do
  id_menu = 1
  request = {id_usuario: '123', id_menu: id_menu}.to_json
  response = Faraday.post(crear_pedido_url, request, header)
  @pedido = JSON.parse(response.body)
end

Entonces('el pedido esta {string}') do |estado|
  id_pedido = @pedido['id_pedido'].to_i
  response = Faraday.get(consultar_estado_pedido_url, {id: id_pedido}, header)
  expect(response.status).to eq(200)
  params = JSON.parse(response.body)
  expect(params['estado']).to eq estado
end
