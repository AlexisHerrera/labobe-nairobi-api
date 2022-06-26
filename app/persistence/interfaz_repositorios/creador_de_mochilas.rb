class CreadorDeMochilas
  def initialize(entregas_repo, pedidos_repo, repartidores_repo)
    @entregas_repo = entregas_repo
    @pedidos_repo = pedidos_repo
    @repartidores_repo = repartidores_repo
  end

  def crear_mochila(id_repartidor)
    repartidor = @repartidores_repo.find(id_repartidor)
    entregas = @entregas_repo.find_by_repartidor(id_repartidor)
    pedidos = []

    entregas.each do |entrega|
      pedido = @pedidos_repo.find(entrega.pedido.id)
      pedidos.push(pedido)
    end

    Mochila.new(repartidor, pedidos)
  end
end
