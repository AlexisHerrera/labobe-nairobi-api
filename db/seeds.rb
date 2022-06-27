require_relative '../app/models/menu'
require_relative '../app/persistence/repositories/menu_repository'

# MenuRepository

menu_repository = Persistence::Repositories::MenuRepository.new

menu_factory = MenuFactory.new

menu_repository.save(menu_factory.crear(1, 'Menu individual', 1000, MenusPosibles::CHICO))
menu_repository.save(menu_factory.crear(2, 'Menu parejas', 1500, MenusPosibles::MEDIANO))
menu_repository.save(menu_factory.crear(3, 'Menu familiar', 2500, MenusPosibles::GRANDE))
