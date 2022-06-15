require_relative '../loggers/logger'

WebTemplate::App.controllers :menus, :provides => [:json] do
  get :create, :map => '/menu' do
    status 200
    menus_to_json menu_repo.all

    Logger.new.logger.info "Menu: #{menu_repo.all}"
  end
end
