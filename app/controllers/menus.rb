LaBobe::App.controllers :menus, :provides => [:json] do
  get :show, :map => '/menus' do
    status 200
    logger.debug "Menu: #{menu_repo.all}"
    menus_to_json menu_repo.all
  end
end
