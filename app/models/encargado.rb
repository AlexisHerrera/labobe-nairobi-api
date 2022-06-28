class Encargado
  def initialize(pedido_repo, repartidor_repo)
    @pedido_repo = pedido_repo
    @repartidor_repo = repartidor_repo
  end

  def enviar(repartidor)
    pedidos_repartidor = @pedido_repo.find_by_id_repartidor(repartidor.id)

    pedidos_repartidor[0].siguiente_estado
    @pedido_repo.save(pedidos_repartidor[0])
  end

  def asignar_pedido(pedido)
    # obtengo repartidor
    repartidor = @repartidor_repo.all[0]
    # asigno repartidor
    pedido.asignar_repartidor(repartidor)
    repartidor.asignar(pedido)
    # actualizo pedido
    @pedido_repo.save(pedido)

    # actualizo estado si mochila llena
    enviar(repartidor) if repartidor.mochila_llena?
  end
end
