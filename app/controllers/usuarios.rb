LaBobe::App.controllers :usuarios, :provides => [:json] do
  backoffice = BackOffice.new

  post :create, :map => '/usuarios' do
    begin
      nuevo_usuario = backoffice.crear_usuario(body_params[:nombre], body_params[:telefono], body_params[:direccion], body_params[:id_telegram])
      status 201
      logger.info "Usuario #{nuevo_usuario.telefono} creado exitosamente"
      usuario_to_json nuevo_usuario
    rescue TelefonoUtilizado
      status 409
      logger.info "Telefono ya esta en uso: #{body_params[:telefono]}"
      {error: 'Telefono en uso'}.to_json
    rescue UsuarioRegistrado
      status 200
      logger.info "Usuario ya esta registrado: #{body_params[:telefono]}"
      {error: 'Usuario ya registrado'}.to_json
    rescue UsuarioInvalido
      status 400
      logger.info "Usuario invalido: #{body_params}"
      {error: 'Error en parametros'}.to_json
    end
  end
end
