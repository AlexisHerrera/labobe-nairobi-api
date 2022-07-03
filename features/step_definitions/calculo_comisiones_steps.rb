Dado('que un repartidor repartió un menú Individual y fue calificado con calificación {string}') do |calificacion|
  puntaje = case calificacion
            when 'mala'
              1
            when 'buena'
              3
            when 'excelente'
              5
            end

  usuario = Persistence::Repositories::UsuarioRepository.new.find_by_telegram_id('123')
  pedido = Pedido.new(usuario, MenuChico.new(1, 'descripcion', 1000), EstadosPosibles::ENTREGADO)
  repartidor = Persistence::Repositories::RepartidorRepository.new.find_by_dni('44455666')
  pedido.asignar_repartidor(repartidor)
  pedido.calificar(usuario, CalificacionFactory.new.crear(puntaje))
  Persistence::Repositories::PedidoRepository.new.save(pedido)
end

Dado('que un repartidor repartió un menú Pareja y fue calificado con calificación {string}') do |calificacion|
  puntaje = case calificacion
            when 'mala'
              1
            when 'buena'
              3
            when 'excelente'
              5
            end

  usuario = Persistence::Repositories::UsuarioRepository.new.find_by_telegram_id('123')
  pedido = Pedido.new(usuario, MenuMediano.new(2, 'descripcion', 1500), EstadosPosibles::ENTREGADO)
  repartidor = Persistence::Repositories::RepartidorRepository.new.find_by_dni('44455666')
  pedido.asignar_repartidor(repartidor)
  pedido.calificar(usuario, CalificacionFactory.new.crear(puntaje))
  Persistence::Repositories::PedidoRepository.new.save(pedido)
end

Dado('que un repartidor repartió un menú Familiar y fue calificado con calificación {string}') do |calificacion|
  puntaje = case calificacion
            when 'mala'
              1
            when 'buena'
              3
            when 'excelente'
              5
            end
  id_menu = 3

  request = {'id_usuario' => '123', 'id_menu' => id_menu}.to_json
  @pedido = JSON.parse(Faraday.post(crear_pedido_url, request, header).body)

  request = {'id_pedido' => @pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)

  request = {'id_pedido' => @pedido['id_pedido'], 'id_usuario' => '123', 'calificacion' => puntaje}.to_json

  Faraday.patch(calificar_url, request, header)
end

Dado('que un repartidor repartió 3 menus individuales calificados') do
  id_menu = 1

  request = {'id_usuario' => '123', 'id_menu' => id_menu}.to_json
  pedido1 = JSON.parse(Faraday.post(crear_pedido_url, request, header).body)
  request = {'id_pedido' => pedido1['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)

  request = {'id_usuario' => '123', 'id_menu' => id_menu}.to_json
  pedido2 = JSON.parse(Faraday.post(crear_pedido_url, request, header).body)
  request = {'id_pedido' => pedido2['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)

  request = {'id_usuario' => '123', 'id_menu' => id_menu}.to_json
  pedido3 = JSON.parse(Faraday.post(crear_pedido_url, request, header).body)
  request = {'id_pedido' => pedido3['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)

  request = {'id_pedido' => pedido1['id_pedido'], 'id_usuario' => '123', 'calificacion' => 1}.to_json
  Faraday.patch(calificar_url, request, header)

  request = {'id_pedido' => pedido2['id_pedido'], 'id_usuario' => '123', 'calificacion' => 3}.to_json
  Faraday.patch(calificar_url, request, header)

  request = {'id_pedido' => pedido3['id_pedido'], 'id_usuario' => '123', 'calificacion' => 5}.to_json
  Faraday.patch(calificar_url, request, header)
end

Dado('llovió durante la entrega del pedido') do
  # @fecha_lluvia = DateTime.new(2022, 7, 2)
  # Timecop.freeze(@fecha_lluvia)
  true
end

Dado('que configuro el sistema para que crea que esta lloviendo') do
  @request = {'clima' => 'lluvia'}.to_json
  @response = Faraday.post(mock_clima_url, @request, header)
  expect(@response.status).to eq(200)
end

Dado('que no llueve') do
  @request = {'clima' => 'sin_lluvia'}.to_json
  @response = Faraday.post(mock_clima_url, @request, header)
  expect(@response.status).to eq(200)
end

Dado('que llueve') do
  @request = {'clima' => 'lluvia'}.to_json
  @response = Faraday.post(mock_clima_url, @request, header)
  expect(@response.status).to eq(200)
end
Cuando('consulto el clima') do
  @clima = Faraday.get(obtener_clima_url)
end

Entonces('el sistema cree que esta lloviendo') do
  estado_clima = JSON.parse(@clima.body)['estado']
  expect(estado_clima).to eq 'Lluvia'
end

Cuando('calculo su comisión') do
  params = { 'dni_repartidor' => '44455666' }
  @repartidor = Faraday.get(comision_url, params, header)
end

Cuando('calculo la comisión de un repartidor inexistente') do
  params = { 'dni_repartidor' => '99999999' }
  @repartidor = Faraday.get(comision_url, params, header)
end

Entonces('no tendra comision y lanzara error') do
  expect(@repartidor.status).to eq(404)
end

Entonces('esta será del del valor {int}') do |total|
  comision = JSON.parse(@repartidor.body)['comision']
  expect(comision).to eq total
  expect(@repartidor.status).to eq(200)
end

Entonces('esta será del {int}% del valor del pedido familiar') do |porcentaje|
  comision = JSON.parse(@repartidor.body)['comision']
  expect(comision).to eq(2500 * porcentaje * 0.01)
  expect(@repartidor.status).to eq(200)
end

Entonces('esta será del {int}% del valor del pedido pareja') do |porcentaje|
  comision = JSON.parse(@repartidor.body)['comision']
  expect(comision).to eq(1500 * porcentaje * 0.01)
  expect(@repartidor.status).to eq(200)
end

Entonces('esta será del {int}% del valor del pedido individual') do |porcentaje|
  comision = JSON.parse(@repartidor.body)['comision']
  expect(comision).to eq(1000 * porcentaje * 0.01)
  expect(@repartidor.status).to eq(200)
end
