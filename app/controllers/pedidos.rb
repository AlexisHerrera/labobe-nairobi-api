LaBobe::App.controllers :pedidos, :provides => [:json] do
  restaurante = Restaurante.new

  post :create, :map => '/pedidos' do
    begin
      nuevo_pedido = restaurante.crear_pedido(body_params[:id_usuario], body_params[:id_menu])
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
      id_pedido = params[:id_pedido]
      id_usuario = params[:id_usuario]
      pedido = restaurante.consultar_pedido(id_pedido, id_usuario)
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
      id = body_params[:id_pedido].to_i
      pedido = restaurante.cambiar_estado_pedido(id)
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
    # TODO: Ver si vale la pena diferenciar el tipo de error
    # Se puede hacer catcheando desde el metodo de CreadorDe.. y raiseando el correcto
    begin
      id_pedido = body_params[:id_pedido].to_i
      id_usuario = body_params[:id_usuario]
      calificacion = body_params[:calificacion]

      restaurante.calificar_pedido(id_pedido, id_usuario, calificacion)
      status 200
      logger.info "Se califico con #{calificacion} el pedido: #{id_pedido}"
    rescue UsuarioInvalido
      status 409
      logger.info "Usuario no puede calificar el pedido. La calificacion del pedido: #{id_pedido} es #{calificacion}"
      {error: 'calificacion pedido'}.to_json
    rescue CalificacionInvalida
      status 400
      logger.info "Calificacion invalida. La calificacion del pedido: #{id_pedido} es #{calificacion}"
      {error: 'calificacion pedido'}.to_json
    rescue EstadoInvalido
      status 403
      logger.info "Estado de pedido invalido, no puede calificar el pedido. La calificacion del pedido: #{id_pedido} es #{calificacion}"
      {error: 'calificacion pedido'}.to_json
    rescue ObjectNotFound
      status 404
      logger.info 'No se pudo encontar el pedido o el usuario.'
      {error: 'calificacion pedido'}.to_json
    end
  end
end
