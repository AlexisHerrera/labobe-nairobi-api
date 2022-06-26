require_relative '../app/models/menu'
require_relative '../app/persistence/repositories/menu_repository'

# MenuRepository

menu_repository = Persistence::Repositories::MenuRepository.new

menu_repository.save(Menu.new(1, 'Menu individual', 1000))
menu_repository.save(Menu.new(2, 'Menu parejas', 1500))
menu_repository.save(Menu.new(3, 'Menu familiar', 2500))
