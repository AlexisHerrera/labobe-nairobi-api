LaBobe::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    begin
      nuevo_usuario = CreadorDeUsuarios.new(user_repo).crear_usuario(usuario_params[:nombre], usuario_params[:telefono], usuario_params[:direccion], usuario_params[:id_telegram])
      status 201
      logger.info "Usuario #{nuevo_usuario.telefono} creado exitosamente"
      usuario_to_json nuevo_usuario
    rescue TelefonoUtilizado
      status 409
      logger.info "Telefono ya esta en uso: #{usuario_params[:telefono]}"
      {error: 'Telefono en uso'}.to_json
    rescue UsuarioRegistrado
      status 200
      logger.info "Usuario ya esta registrado: #{usuario_params[:telefono]}"
      {error: 'Usuario ya registrado'}.to_json
    rescue UsuarioInvalido
      status 400
      logger.info "Usuario invalido: #{usuario_params}"
      {error: 'Error en parametros'}.to_json
    end
  end
end
