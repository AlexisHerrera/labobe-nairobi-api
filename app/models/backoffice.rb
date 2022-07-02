class BackOffice
  def initialize
    @pedidos_repo = Persistence::Repositories::PedidoRepository.new
  end

  def crear_pedido(id_usuario, id_menu)
    CreadorDePedidos.new(@pedidos_repo).crear(id_usuario, id_menu)
  end
end
