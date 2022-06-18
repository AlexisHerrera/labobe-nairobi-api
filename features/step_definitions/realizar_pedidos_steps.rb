Cuando('recibo un pedido del menu {int} del cliente') do |id_menu|
  # TODO: Necesitamos crear un factory de clientes, porque esta mal tener el id_usuario
  # (el cual esta haciendo referencia al step Dado que el usuario ya esta registrado)
  @request = {id_usuario: '123', id_menu: id_menu}.to_json
  @response = Faraday.post(crear_pedido_url, @request, header)
end

Entonces('deberia aceptar su pedido') do
  expect(@response.status).to eq(201)
end

Entonces('devolverle el codigo del pedido') do
  pedido = JSON.parse(@response.body)
  expect(pedido['id_pedido'].nil?).to be(false)
end

Entonces('no deberia aceptar su pedido') do
  expect(@response.status).to eq(400)
end

Entonces('devolverle un error') do
  error = JSON.parse(@response.body)
  expect(error['error']).to eq('pedido-001')
end
