Dado('que un usuario se quiere registrar') do
end

Cuando('recibo un usuario con nombre {string}, teléfono {string} y dirección {string}') do |nombre, telefono, direccion|
  @request = {nombre: nombre, telefono: telefono, direccion: direccion}.to_json
  @response = Faraday.post(crear_usuario_url, @request, header)
end

Entonces('el usuario queda registrado con teléfono {string}') do |_telefono|
  expect(@response.status).to eq(201)

  # usuario = JSON.parse(@response.body)
  # telefono_esperado = usuario['telefono']
  # expect(telefono_esperado).to eq(telefono)
end
