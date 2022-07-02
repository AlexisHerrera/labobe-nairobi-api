LaBobe::App.controllers :pedidos, :provides => [:json] do
  backoffice = BackOffice.new

  post :create, :map => '/pedidos' do
    # TODO: Ver si vale la pena diferenciar el tipo de error
    # Se puede hacer catcheando desde el metodo de CreadorDe.. y raiseando el correcto
    begin
      nuevo_pedido = backoffice.crear_pedido(body_params[:id_usuario], body_params[:id_menu])
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
      id_usuario = params[:id_usuario]
      pedido = backoffice.consultar_pedido(id_pedido, id_usuario)
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

  # rubocop: disable Metrics/BlockLength
  patch :show, :map => '/pedidosCalificados' do
    begin
      pedido_repo = Persistence::Repositories::PedidoRepository.new
      pedido = pedido_repo.find(body_params[:id_pedido].to_i)

      usuario_repo = Persistence::Repositories::UsuarioRepository.new
      usuario = usuario_repo.find_by_telegram_id(body_params[:id_usuario])

      calificacion = CalificacionFactory.new.crear(body_params[:calificacion])

      pedido.calificar(usuario, calificacion)
      pedido_repo.save(pedido)

      status 200
      logger.info "Se califico con #{pedido.calificacion.descripcion} el pedido: #{pedido.id}"
    rescue UsuarioInvalido
      status 409
      logger.info "Usuario no puede calificar el pedido. La calificacion del pedido: #{pedido.id} es #{pedido.calificacion.descripcion}"
      {error: 'calificacion pedido'}.to_json
    rescue CalificacionInvalida
      status 400
      logger.info "Calificacion invalida. La calificacion del pedido: #{pedido.id} es #{pedido.calificacion.descripcion}"
      {error: 'calificacion pedido'}.to_json
    rescue EstadoInvalido
      status 403
      logger.info "Estado de pedido invalido, no puede calificar el pedido. La calificacion del pedido: #{pedido.id} es #{pedido.calificacion.descripcion}"
      {error: 'calificacion pedido'}.to_json
    rescue ObjectNotFound
      status 404
      logger.info 'No se pudo encontar el pedido o el usuario.'
      {error: 'calificacion pedido'}.to_json
    end
  end
  # rubocop: enable Metrics/BlockLength
end
