LaBobe::App.controllers :pedidos, :provides => [:json] do
  post :create, :map => '/pedidos' do
    # TODO: Dividir en mas casos el tipo de error. ie : MenuInvalido, UsuarioNoRegistrado
    begin
      nuevo_pedido = CreadorDePedidos.new(pedido_repo).crear_pedido(pedido_params[:id_usuario], pedido_params[:id_menu])
      status 201
      logger.info "Nuevo pedido: Id pedido: #{nuevo_pedido.id}, Id_usuario: #{nuevo_pedido.id_usuario}, Id_menu: #{nuevo_pedido.id_menu}"
      pedido_to_json nuevo_pedido
    rescue ObjectNotFound
      status 400
      logger.info "No se pudo crear el pedido : #{pedido_params}"
      {error: 'crear pedido'}.to_json
    end
  end

  get :show, :map => '/pedidos', :with => %i[id_pedido id_usuario] do
    begin
      id_pedido = params[:id_pedido]
      pedido = pedido_repo.find(id_pedido)
      estado = estado_repo.find(pedido.estado.estado)
      usuario = Persistence::Repositories::UserRepository.new.find_by_telegram_id(params[:id_usuario])
      pedido.consultar(usuario.id)
      status 200
      logger.info "Se informa el estado del pedido: #{pedido.id} con estado #{estado.descripcion}"
      estado_to_json estado
    rescue ObjectNotFound
      status 404
      logger.info "No se pudo encontar el pedido #{params[:id_pedido]}"
      {error: 'No se pudo encontrar el pedido.'}.to_json
    rescue UsuarioInvalido
      status 401
      logger.info "El usuario #{params[:id_usuario]} no es duenio del pedido #{params[:id_pedido]}"
      {error: 'El usuario no coincide con el duenio del pedido.'}.to_json
    end
  end

  patch :show, :map => '/pedidos' do
    begin
      id = pedido_params[:id_pedido].to_i
      pedido = pedido_repo.find(id)
      pedido.cambiar_estado
      pedido_repo.save(pedido)
      status 204
      logger.info "Se modifico el estado del pedido: #{pedido.id} "
    rescue ObjectNotFound
      status 404
      logger.info 'No se pudo encontar el pedido.'
      {error: 'estado pedido'}.to_json
    end
  end
end
