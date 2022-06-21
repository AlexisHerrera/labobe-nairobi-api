Dado('que quiero registrar un repartidor') do
  true
end

Cuando('intento registrar a {string} con dni {string} y numero de telefono {string}') do |nombre, dni, telefono|
  @request = {nombre: nombre, dni: dni, telefono: telefono}.to_json
  @response = Faraday.post(registrar_repartidor_url, @request, header)
end

Entonces('el repartidor esta registrado') do
  expect(@response.status).to eq(201)

  repartidor = JSON.parse(@response.body)
  expect(repartidor['id'].nil?).to eq(false)
  expect(repartidor['nombre'].nil?).to eq(false)
  expect(repartidor['dni'].nil?).to eq(false)
  expect(repartidor['telefono'].nil?).to eq(false)
end

Entonces('el repartidor no se registra') do
  expect(@response.status).to eq(400)

  repartidor = JSON.parse(@response.body)
  expect(repartidor['id'].nil?).to eq(true)
  expect(repartidor['nombre'].nil?).to eq(true)
  expect(repartidor['dni'].nil?).to eq(true)
  expect(repartidor['telefono'].nil?).to eq(true)
end

Entonces('recibo el mensaje de error') do
  error = JSON.parse(@response.body)['error']
  expect(error.nil?).to eq false
end

Dado('hay un repartidor con dni {string} registrado') do |dni|
  @request = {nombre: 'Juan', dni: dni, telefono: '1122334455'}.to_json
  Faraday.post(registrar_repartidor_url, @request, header)
end
