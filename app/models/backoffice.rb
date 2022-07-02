class BackOffice
  def initialize
    @pedidos_repo = Persistence::Repositories::PedidoRepository.new
    @usuario_repo = Persistence::Repositories::UsuarioRepository.new
    @repartidor_repo = Persistence::Repositories::RepartidorRepository.new
    @encargado = Encargado.new(@pedidos_repo, @repartidor_repo)
    @menu_repo = Persistence::Repositories::MenuRepository.new
  end

  def crear_pedido(id_usuario, id_menu)
    CreadorDePedidos.new(@pedidos_repo).crear(id_usuario, id_menu)
  end

  def consultar_pedido(id_pedido, id_usuario)
    pedido = @pedidos_repo.find(id_pedido)
    usuario = @usuario_repo.find_by_telegram_id(id_usuario)
    pedido.verificar_propietario(usuario)
    pedido
  end

  def cambiar_estado_pedido(id_pedido)
    pedido = @pedidos_repo.find(id_pedido)
    @encargado.procesar_pedido(pedido)
  end

  def calificar_pedido(id_pedido, id_usuario, puntaje_calificacion)
    pedido = @pedidos_repo.find(id_pedido)
    usuario = @usuario_repo.find_by_telegram_id(id_usuario)
    calificacion = CalificacionFactory.new.crear(puntaje_calificacion)
    pedido.calificar(usuario, calificacion)
    @pedidos_repo.save(pedido)
  end

  def consultar_menus
    @menu_repo.all
  end
end
