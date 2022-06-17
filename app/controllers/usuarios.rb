LaBobe::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    # TODO: Mejorar mensajes de error que se mandan en json
    begin
      nuevo_usuario = CreadorDeUsuarios.new(user_repo).crear_usuario(user_params[:nombre], user_params[:telefono], user_params[:direccion], user_params[:id_telegram])
      status 201
      logger.info "Usuario #{nuevo_usuario.telefono} creado exitosamente"
      user_to_json nuevo_usuario
    rescue TelefonoUtilizado => e
      status 409
      logger.info 'Telefono ya esta en uso'
      {error: e.message}.to_json
    rescue UsuarioRegistrado => e
      status 200
      logger.info 'Usuario ya esta registrado'
      {error: e.message}.to_json
    rescue UsuarioInvalido => e
      status 400
      logger.info 'Usuario invalido'
      {error: e.message}.to_json
    end
  end
end
