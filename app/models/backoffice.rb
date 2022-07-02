class BackOffice
  def initialize
    @pedidos_repo = Persistence::Repositories::PedidoRepository.new
    @usuario_repo = Persistence::Repositories::UsuarioRepository.new
  end

  def crear_pedido(id_usuario, id_menu)
    CreadorDePedidos.new(@pedidos_repo).crear(id_usuario, id_menu)
  end

  def consultar_pedido(id_pedido, id_usuario)
    pedido = @pedidos_repo.find(id_pedido)
    usuario = @usuario_repo.find_by_telegram_id(id_usuario)
    pedido.consultar(usuario.id_telegram)
    pedido
  end
end
