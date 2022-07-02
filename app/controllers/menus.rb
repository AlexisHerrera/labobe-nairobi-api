LaBobe::App.controllers :menus, :provides => [:json] do
  restaurante = Restaurante.new

  get :show, :map => '/menus' do
    menus = restaurante.consultar_menus
    status 200
    logger.info "Se informa menu: #{menus}"
    menus_to_json menus
  end
end
