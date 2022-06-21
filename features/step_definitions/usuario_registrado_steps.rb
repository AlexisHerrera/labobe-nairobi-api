Dado('que el usuario ya esta registrado') do
  @request_first_user = {nombre: 'Juan', telefono: '0123456789', direccion: 'Paseo Colon 850', id_telegram: '123'}.to_json
  @response_first_user = Faraday.post(crear_usuario_url, @request_first_user, header)
  expect(@response_first_user.status).to eq(201)
end

Cuando('recibo un pedido de registracion del mismo usuario registrado') do
  @request = {nombre: 'Juan', telefono: '1144449999', direccion: 'Paseo Colon 850', id_telegram: '123'}.to_json
  @response = Faraday.post(crear_usuario_url, @request, header)
end

Entonces('le respondo que el usuario ya esta registrado') do
  expect(@response.status).to eq(200)
  usuario = JSON.parse(@response.body)
  expect(usuario['error'].nil?).to eq(false)
end
