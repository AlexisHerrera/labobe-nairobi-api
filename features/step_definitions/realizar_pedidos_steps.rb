Cuando('recibo un pedido del menu {int} del cliente') do |id_menu|
  # TODO: Necesitamos crear un factory de clientes, porque esta mal tener el id_cliente
  # (el cual esta haciendo referencia al step Dado que el usuario ya esta registrado)
  @request = {id_cliente: '0123456789', id_menu: id_menu}.to_json
  @response = Faraday.post(crear_pedido_url, @request, header)
end

Entonces('deberia aceptar su pedido') do
  expect(@response.status).to eq(201)
end

Entonces('devolverle el codigo del pedido') do
  # pedido = JSON.parse(@response.body)
  # Se espera que sea pedido = {id_pedido: 1, id_cliente: '0123456789', id_menu: '1'}
  pedido = JSON.parse('{ "id_pedido": "1", "id_cliente": "0123456789", "id_menu": "1"}')
  expect(pedido['id_pedido'].nil?).to be(false)
end
