class CreadorDePedidos
  def initialize(pedidos_repo)
    @repo = pedidos_repo
  end

  def crear_pedido(id_usuario, id_menu)
    pedido_a_crear = Pedido.new(id_usuario, id_menu)
    @repo.save(pedido_a_crear)
  end
end
