require_relative '../loggers/logger'

WebTemplate::App.controllers :menus, :provides => [:json] do
  get :create, :map => '/menus' do
    logger = Logger.new
    status 200
    logger.logger.info "Menu: #{menu_repo.all}"
    menus_to_json menu_repo.all
  end

  post :create, :map => '/menu' do
    logger = Logger.new
    begin
      nuevo_menu = CreadorDeMenus.new(menu_repo).crear_menu(menu_params[:id], menu_params[:descripcion], menu_params[:precio])
      status 201
      logger.logger.info "Menu #{nuevo_menu.id}: #{nuevo_menu.descripcion} creado exitosamente"
      menu_to_json nuevo_menu
    rescue MenuInvalido => e
      status 400
      logger.logger.info 'Menu invalido'
      {error: e.message}.to_json
    end
  end
end
