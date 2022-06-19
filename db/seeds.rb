require_relative '../app/models/menu'
require_relative '../app/persistence/repositories/menu_repository'

# MenuRepository

menu_repository = Persistence::Repositories::MenuRepository.new

menu_repository.save(Menu.new(1, 'Menu individual', 1000))
menu_repository.save(Menu.new(2, 'Menu parejas', 1500))
menu_repository.save(Menu.new(3, 'Menu familiar', 2500))

# EstadoRepository

estados_repository = Persistence::Repositories::EstadoRepository.new

estados_repository.save(EstadoDTO.new(0, 'Recibido'))
estados_repository.save(EstadoDTO.new(1, 'En preparacion'))
estados_repository.save(EstadoDTO.new(2, 'En camino'))
estados_repository.save(EstadoDTO.new(3, 'Entregado'))
