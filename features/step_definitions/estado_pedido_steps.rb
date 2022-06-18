Cuando('creo un pedido') do
  id_menu = 1
  @request = {id_usuario: '123', id_menu: id_menu}.to_json
  @response = Faraday.post(crear_pedido_url, @request, header)
end

Entonces('el pedido esta {string}') do |estado|
  pedido = JSON.parse(@response.body)
  id_pedido = pedido['id']
  @response_pedido = Faraday.get(crear_pedido_url, {id: id_pedido}, header)
  expect(@response_pedido.status).to eq(200)
  pedido = JSON.parse(@response_pedido.body)
  expect(pedido['estado']).to eq estado
end
