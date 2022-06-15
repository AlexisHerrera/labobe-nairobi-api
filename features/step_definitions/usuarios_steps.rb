Dado('que un usuario se quiere registrar') do
end

Cuando('recibo un usuario con nombre {string}, teléfono {string} y dirección {string}') do |nombre, telefono, direccion|
  @request = {nombre: nombre, telefono: telefono, direccion: direccion, id_telegram: '123'}.to_json
  @response = Faraday.post(crear_usuario_url, @request, header)
end

Cuando('recibo un usuario con numero de un usuario registrado') do
  @request = {nombre: 'Juan', telefono: '0123456789', direccion: 'Paseo Colon 850', id_telegram: '123'}.to_json
  @response_first_user = Faraday.post(crear_usuario_url, @request, header)
  @response = Faraday.post(crear_usuario_url, @request, header)
end

Entonces('el usuario queda registrado con teléfono {string}') do |telefono|
  expect(@response.status).to eq(201)

  usuario = JSON.parse(@response.body)
  telefono_esperado = usuario['telefono']
  expect(telefono_esperado).to eq(telefono)
end

Entonces('el usuario no queda registrado') do
  expect(@response.status).to eq(400)
  usuario = JSON.parse(@response.body)
  expect(usuario).to eq({'error' => 'UsuarioInvalido'})
end

Entonces('el usuario no queda registrado porque esta repetido') do
  expect(@response.status).to eq(409)
  usuario = JSON.parse(@response.body)
  expect(usuario).to eq({'error' => 'UsuarioRepetido'})
end
