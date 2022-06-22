LaBobe::App.controllers :repartidores, :provides => [:json] do
  post :create, :map => '/repartidores' do
    repartidor_repo = Persistence::Repositories::RepartidorRepository.new
    nuevo_repartidor = CreadorDeRepartidores.new(repartidor_repo).crear_repartidor(body_params[:nombre], body_params[:dni], body_params[:telefono])
    status 201
    # TODO: cambiar este logger (usar algo como el repartidor_attributes)
    logger.info "Repartidor #{nuevo_repartidor.id} #{nuevo_repartidor.telefono} creado exitosamente"
    repartidor_to_json nuevo_repartidor
  end
end
