Dado('que un usuario se quiere registrar') do
end

Cuando('recibo un usuario con nombre {string}, teléfono {string} y dirección {string}') do |nombre, telefono, direccion|
  @request = {nombre: nombre, telefono: telefono, direccion: direccion, id_telegram: '123'}.to_json
  @response = Faraday.post(crear_usuario_url, @request, header)
end

Cuando('recibo un usuario con numero de un usuario registrado') do
  @request_first_user = {nombre: 'Juan', telefono: '1144449999', direccion: 'Paseo Colon 850', id_telegram: '123'}.to_json
  @response_first_user = Faraday.post(crear_usuario_url, @request_first_user, header)

  @request = {nombre: 'Juan', telefono: '1144449999', direccion: 'Paseo Colon 850', id_telegram: '456'}.to_json
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
  expect(usuario['error'].nil?).to eq(false)
end

Entonces('el usuario no queda registrado porque esta utilizando un numero ya registrado') do
  expect(@response.status).to eq(409)
  usuario = JSON.parse(@response.body)
  expect(usuario['error'].nil?).to eq(false)
end
