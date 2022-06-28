class Encargado
  def initialize(pedido_repo, repartidor_repo)
    @pedido_repo = pedido_repo
    @repartidor_repo = repartidor_repo
  end

  def asignar_pedido(pedido)
    repartidor = @repartidor_repo.all[0]
    pedido.asignar_repartidor(repartidor)
    @pedido_repo.save(pedido)
  end
end
