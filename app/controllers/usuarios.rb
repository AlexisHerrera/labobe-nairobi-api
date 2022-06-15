require_relative '../loggers/logger'

WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    logger = Logger.new

    begin
      nuevo_usuario = CreadorDeUsuarios.new(user_repo).crear_usuario(user_params[:nombre], user_params[:telefono], user_params[:direccion], user_params[:id_telegram])
      status 201
      logger.logger.info "Usuario #{nuevo_usuario.telefono} creado exitosamente"
      user_to_json nuevo_usuario
    rescue UsuarioRepetido => e
      status 409
      logger.logger.info 'Usuario repetido'
      {error: e.message}.to_json
    rescue UsuarioInvalido => e
      status 400
      logger.logger.info 'Usuario invalido'
      {error: e.message}.to_json
    end
  end
end
