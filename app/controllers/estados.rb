LaBobe::App.controllers :estados, :provides => [:json] do
  get :show, :map => '/estado' do
    begin
      id = estado_params['id'].to_i
      pedido = pedido_repo.find(id)
      estado = estado_repo.find(pedido.id_estado)
      status 200
      logger.info "Se informa el estado de un pedido: #{estado}"
      estado_to_json estado
    rescue ObjectNotFound
      status 404
      logger.info 'No se pudo encontar el pedido.'
      {error: 'estado pedido',
       message: 'No se pudo encontrar el pedido.',
       detail: 'Asegurarse de ingresar un numero de pedido valido.'}.to_json
    end
  end
end
