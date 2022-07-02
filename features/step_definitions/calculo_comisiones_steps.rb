Dado('que un repartidor repartió un menú Individual y fue calificado con calificación {string}') do |calificacion|
	if calificacion == "Mala"
		puntaje = 1
	elsif calificacion == "Buena"
		puntaje = 3
	else
		puntaje = 5
	end

	id_menu = 1

  request = {'id_usuario' => '123', 'id_menu' => id_menu}.to_json
  @pedido = Faraday.post(crear_pedido_url, request, header)
  
	request = {'id_pedido' => @pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)

	request = {'id_usuario' => '123', 'id_menu' => 2}.to_json
  pedido = Faraday.post(crear_pedido_url, request, header)
  
	request = {'id_pedido' => pedido['id_pedido']}.to_json
  Faraday.patch(crear_pedido_url, request, header)
  Faraday.patch(crear_pedido_url, request, header)


  request = {'id_pedido' => @pedido['id_pedido'], 'id_usuario' => '123', 'calificacion' => puntaje}.to_json

  Faraday.patch(calificar_url, request, header)
end

Cuando('calculo su comisión') do
  params = { 'dni_repartidor' => '44455666' }
	@repartidor = Faraday.get(registrar_repartidor_url, params, header)
end

Entonces('esta será del {int}% del valor del pedido') do |int|
  comision = JSON.parse(@repartidor.body)['comision']
	expect(comision).to eq(1000*0.05)
	expect(@repartidor.status).to eq(200)
end
  