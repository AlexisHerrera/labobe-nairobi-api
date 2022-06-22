LaBobe::App.controllers :menus, :provides => [:json] do
  get :show, :map => '/menus' do
    status 200
    menu_repo = Persistence::Repositories::MenuRepository.new
    logger.info "Se informa menu: #{menu_repo.all}"
    menus_to_json menu_repo.all
  end
end
