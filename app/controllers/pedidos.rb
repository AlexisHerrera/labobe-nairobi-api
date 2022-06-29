LaBobe::App.controllers :pedidos, :provides => [:json] do
  post :create, :map => '/pedidos' do
    # TODO: Ver si vale la pena diferenciar el tipo de error
    # Se puede hacer catcheando desde el metodo de CreadorDe.. y raiseando el correcto
    begin
      pedido_repo = Persistence::Repositories::PedidoRepository.new
      nuevo_pedido = CreadorDePedidos.new(pedido_repo).crear(body_params[:id_usuario], body_params[:id_menu])
      status 201
      logger.info "Nuevo pedido: Id pedido: #{nuevo_pedido.id}, Id_usuario: #{nuevo_pedido.usuario.id}, Id_menu: #{nuevo_pedido.menu.id}"
      pedido_to_json nuevo_pedido
    rescue ObjectNotFound
      status 400
      logger.info "No se pudo crear el pedido : #{body_params}"
      {error: 'crear pedido'}.to_json
    end
  end

  get :show, :map => '/pedidos' do
    begin
      # Todo esto se puede meter en un una interfaz del repositorio (similar al creador_de), hay muchos repositorys
      id_pedido = params[:id_pedido]
      pedido = Persistence::Repositories::PedidoRepository.new.find(id_pedido)
      usuario = Persistence::Repositories::UsuarioRepository.new.find_by_telegram_id(params[:id_usuario])
      pedido.consultar(usuario.id_telegram)
      status 200
      logger.info "Se informa el estado del pedido: #{pedido.id}"
      pedido_to_json pedido
    rescue ObjectNotFound
      # Si se le indica un id_telegram inexistente, tambien cae aca
      status 404
      logger.info "No se pudo encontrar el pedido #{params[:id_pedido]}"
      {error: 'No se pudo encontrar el pedido.'}.to_json
    rescue UsuarioInvalido
      status 401
      logger.info "El usuario #{params[:id_usuario]} no es duenio del pedido #{params[:id_pedido]}"
      {error: 'El usuario no coincide con el duenio del pedido.'}.to_json
    end
  end

  patch :show, :map => '/pedidos' do
    begin
      pedido_repo = Persistence::Repositories::PedidoRepository.new
      id = body_params[:id_pedido].to_i
      pedido = pedido_repo.find(id)

      # Esto deberia ir a algun otro lado
      pedido_repo = Persistence::Repositories::PedidoRepository.new
      repartidor_repo = Persistence::Repositories::RepartidorRepository.new
      Encargado.new(pedido_repo, repartidor_repo).procesar_pedido(pedido)
      status 204
      logger.info "Se modifico el estado del pedido: #{pedido.id} "
    rescue NoHayRepartidores
      status 400
      logger.info 'No se pudo encontar repartidores.'
      {error: 'no hay repartidores'}.to_json
    rescue ObjectNotFound
      status 404
      logger.info 'No se pudo encontar el pedido.'
      {error: 'estado pedido'}.to_json
    end
  end

  patch :show, :map => '/pedidosCalificados' do
    begin
      pedido_repo = Persistence::Repositories::PedidoRepository.new
      id = body_params[:id_pedido].to_i
      pedido = pedido_repo.find(id)

      calificacion = CalificacionFactory.new.crear(body_params[:calificacion])
      pedido.calificar(calificacion)

      pedido_repo.save(pedido)
      status 200
      logger.info "Se califico con #{pedido.calificacion.descripcion} el pedido: #{pedido.id}"
    rescue CalificacionInvalida
      status 400
      logger.info "Calificacion invalida. La calificacion del pedido: #{pedido.id} es #{pedido.calificacion.descripcion}"
      {error: 'calificacion pedido'}.to_json
    rescue ObjectNotFound
      status 404
      logger.info 'No se pudo encontar el pedido.'
      {error: 'calificacion pedido'}.to_json
    end
  end
end
