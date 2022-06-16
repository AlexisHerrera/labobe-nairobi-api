require_relative '../loggers/logger'

WebTemplate::App.controllers :menus, :provides => [:json] do
  get :show, :map => '/menus' do
    logger = Logger.new
    status 200
    logger.logger.info "Menu: #{menu_repo.all}"
    menus_to_json menu_repo.all
  end
end
