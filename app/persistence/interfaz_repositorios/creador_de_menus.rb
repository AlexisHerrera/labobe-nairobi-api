class CreadorDeMenus
  # TODO: Es necesario tener una clase para crear menus? No es demasiado?
  def initialize(menu_repo)
    @repo = menu_repo
  end

  def crear_menu(id, descripcion, precio)
    menu_a_crear = Menu.new(id, descripcion, precio)
    @repo.save(menu_a_crear)
  end
end