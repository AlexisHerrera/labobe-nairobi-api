class Encargado
  def initialize(pedido_repo, repartidor_repo)
    @pedido_repo = pedido_repo
    @repartidor_repo = repartidor_repo
  end

  def enviar(repartidor)
    # pedidos_repartidor = @pedido_repo.find_by_id_repartidor(repartidor.id)

    repartidor.salir
    pedidos = repartidor.pedidos
    pedidos.each do |pedido|
      @pedido_repo.save(pedido)
    end

    # pedidos_repartidor[0].siguiente_estado
    # @pedido_repo.save(pedidos_repartidor[0])
  end

  # rubocop:disable Metrics/AbcSize
  def asignar_pedido(pedido)
    # obtengo repartidor
    repartidores = @repartidor_repo.all
    repartidores.each do |repartidor|
      repartidor.pedidos = @pedido_repo.find_by_id_repartidor(repartidor.id)
    end
    repartidores.sort_by! { |repartidor| repartidor.pedidos.size }
    # asigno repartidor
    pedido.asignar_repartidor(repartidores[0])
    repartidores[0].asignar(pedido)
    # actualizo pedido
    @pedido_repo.save(pedido)

    # actualizo estado si mochila llena
    enviar(repartidores[0]) if repartidores[0].mochila_llena?
  end
  # rubocop:enable Metrics/AbcSize
end
