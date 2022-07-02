LaBobe::App.controllers :repartidores, :provides => [:json] do
  post :create, :map => '/repartidores' do
    begin
      repartidor_repo = Persistence::Repositories::RepartidorRepository.new
      nuevo_repartidor = CreadorDeRepartidores.new(repartidor_repo).crear_repartidor(body_params[:nombre], body_params[:dni], body_params[:telefono])
      status 201
      logger.info "Repartidor #{repartidor_to_hash(nuevo_repartidor)} creado exitosamente"
      repartidor_to_json nuevo_repartidor
    rescue DniEnUso
      status 409
      logger.info "Error al crear repartidor, DNI repetido: #{body_params[:dni]}"
      {error: 'DNI en uso'}.to_json
    rescue RepartidorInvalido
      status 400
      logger.info "Error al crear repartidor, argumentos invalidos: #{body_params}"
      {error: 'Argumentos invalidos al crear repartidor'}.to_json
    end
  end

  get :show, :map => '/repartidores' do
    dni_repartidor = params[:dni_repartidor]

    pedido_repo = Persistence::Repositories::PedidoRepository.new
    repartidor_repo = Persistence::Repositories::RepartidorRepository.new
    encargado = Encargado.new(pedido_repo, repartidor_repo)
    comision = encargado.calcular_comision(dni_repartidor)
    status 200
    {'comision' => comision}.to_json
  end
end
