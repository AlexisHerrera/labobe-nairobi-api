class CreadorDePedidos
  def initialize(pedidos_repo)
    @repo = pedidos_repo
  end

  def crear(id_usuario, id_menu)
    usuario = Persistence::Repositories::UsuarioRepository.new.find_by_telegram_id(id_usuario.to_s)
    menu = Persistence::Repositories::MenuRepository.new.find(id_menu.to_i)
    pedido_a_crear = Pedido.new(nil, usuario.id, menu, EstadosPosibles::ACEPTADO)
    @repo.save(pedido_a_crear)
  end
end
