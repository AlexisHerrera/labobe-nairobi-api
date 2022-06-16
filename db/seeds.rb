require_relative '../app/models/menu'
require_relative '../app/persistence/repositories/menu_repository'

menu_repository = Persistence::Repositories::MenuRepository.new

# Se podria hacer que solo ejecute el seed cuando esta vacia,
menu_repository.save(Menu.new(1, 'Menu individual', 1000))
menu_repository.save(Menu.new(2, 'Menu parejas', 1500))
menu_repository.save(Menu.new(3, 'Menu familiar', 2500))
