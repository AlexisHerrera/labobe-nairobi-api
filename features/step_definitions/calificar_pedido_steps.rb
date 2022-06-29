Dado('que un pedido del cliente esta entregado') do
  @id_pedido = @id_pedido_primer_menu_individual
end

Dado('que un pedido que no es del cliente esta entregado') do
  @id_pedido = @id_pedido_primer_menu_individual
end

Cuando('quiero calificar un pedido como excelente') do
  request = {'id_pedido' => @id_pedido, 'id_usuario' => @id_telegram_usuario, :calificacion => 5}.to_json

  @response = Faraday.patch(calificar_url, request, header)
end

Entonces('la calificacion queda registrada') do
  expect(@response.status).to eq(200)
end

Cuando('califico un pedido inexistente') do
  request = {'id_pedido' => '321', 'id_usuario' => @id_telegram_usuario, :calificacion => 5}.to_json

  @response = Faraday.patch(calificar_url, request, header)
end

Entonces('la calificacion no queda registrada porque no existe el cliente') do
  expect(@response.status).to eq(404)
end

Entonces('la calificacion no queda registrada porque no es su pedido') do
  expect(@response.status).to eq(409)
end

Cuando('quiero calificar un pedido con un valor que excede el rango') do
  request = {'id_pedido' => @id_pedido, 'id_usuario' => @id_telegram_usuario, :calificacion => 10}.to_json

  @response = Faraday.patch(calificar_url, request, header)
end

Cuando('quiero calificar un pedido con un valor que es inferior al rango') do
  request = {'id_pedido' => @id_pedido, 'id_usuario' => @id_telegram_usuario, :calificacion => 0}.to_json

  @response = Faraday.patch(calificar_url, request, header)
end

Cuando('quiero calificar un pedido con un valor no numerico') do
  request = {'id_pedido' => @id_pedido, 'id_usuario' => @id_telegram_usuario, :calificacion => 'Mala'}.to_json

  @response = Faraday.patch(calificar_url, request, header)
end

Dado('que un pedido que no es del cliente esta en preparacion') do
  request = {'id_usuario' => '123', 'id_menu' => 3}.to_json
  response_pedido = Faraday.post(crear_pedido_url, request, header)

  @id_pedido = JSON.parse(response_pedido.body)['id_pedido']
end

Cuando('quiero calificar un pedido que no es del cliente como excelente') do
  request_other_user = {nombre: 'Juan', telefono: '1123456789', direccion: 'Paseo Colon 850', id_telegram: '456'}.to_json
  Faraday.post(crear_usuario_url, request_other_user, header)
  id_telegram_otro_usuario = '456'

  request = {'id_pedido' => @id_pedido, 'id_usuario' => id_telegram_otro_usuario, :calificacion => 1}.to_json

  @response = Faraday.patch(calificar_url, request, header)
end

Entonces('la calificacion no queda registrada') do
  expect(@response.status).to eq(400)
end
