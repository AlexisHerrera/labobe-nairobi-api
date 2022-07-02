Dado('que un repartidor repartió un menú Individual y fue calificado con calificación {string}') do |calificacion|
  puntaje = case calificacion
            when 'mala'
              1
            when 'Buena'
              3
            else
              5
            end

  id_menu = 1

  request = {'id_usuario' => '123', 'id_menu' => id_menu}.to_json
  @pedido = JSON.parse(Faraday.post(crear_pedido_url, request, header).body)

  request = {'id_pedido' => @pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)

  request = {'id_usuario' => '123', 'id_menu' => 2}.to_json
  pedido = JSON.parse(Faraday.post(crear_pedido_url, request, header).body)

  request = {'id_pedido' => pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)

  request = {'id_pedido' => @pedido['id_pedido'], 'id_usuario' => '123', 'calificacion' => puntaje}.to_json

  Faraday.patch(calificar_url, request, header)
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

Cuando('calculo su comisión') do
  params = { 'dni_repartidor' => '44455666' }
  @repartidor = Faraday.get(registrar_repartidor_url, params, header)
end

Entonces('esta será del {int}% del valor del pedido familiar') do |porcentaje|
  comision = JSON.parse(@repartidor.body)['comision']
  expect(comision).to eq(2500 * porcentaje * 0.01)
  expect(@repartidor.status).to eq(200)
end

Entonces('esta será del {int}% del valor del pedido individual') do |porcentaje|
  comision = JSON.parse(@repartidor.body)['comision']
  expect(comision).to eq(1000 * porcentaje * 0.01)
  expect(@repartidor.status).to eq(200)
end
