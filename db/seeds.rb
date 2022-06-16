require_relative '../app/models/menu'
require_relative '../app/persistence/repositories/menu_repository'

menu_repository = Persistence::Repositories::MenuRepository.new
unless menu_repository.all.count.positive?
  menu_repository.save(Menu.new(1, 'Menu individual', 1000))
  menu_repository.save(Menu.new(2, 'Menu pareja', 1500))
  menu_repository.save(Menu.new(3, 'Menu familiar', 2500))
end
