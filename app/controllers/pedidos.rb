LaBobe::App.controllers :pedidos, :provides => [:json] do
  post :create, :map => '/pedidos' do
    begin
      nuevo_pedido = CreadorDePedidos.new(pedido_repo).crear_pedido(pedido_params[:id_usuario], pedido_params[:id_menu])
      status 201
      logger.info "Nuevo pedido: Id pedido: #{nuevo_pedido.id}, Id_usuario: #{nuevo_pedido.id_usuario}, Id_menu: #{nuevo_pedido.id_menu}"
      pedido_to_json nuevo_pedido
    rescue ObjectNotFound => e
      status 500
      logger.info 'No se pudo crear el pedido porque no se encontro al cliente o al menu solicitado'
      {error: e.message}.to_json
    end
  end
end
