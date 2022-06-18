class CreadorDePedidos
  def initialize(pedidos_repo)
    @repo = pedidos_repo
  end

  def crear_pedido(id_usuario, id_menu)
    usuario = Persistence::Repositories::UserRepository.new.find_by_telegram_id(id_usuario.to_s)
    menu = Persistence::Repositories::MenuRepository.new.find(id_menu.to_i)
    pedido_a_crear = Pedido.new(usuario.id, menu.id)
    @repo.save(pedido_a_crear)
  end
end
