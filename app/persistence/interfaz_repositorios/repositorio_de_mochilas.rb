class RepositorioDeMochilas
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

  def obtener_mochilas
    repartidores = @repartidores_repo.all

    mochilas = []

    repartidores.each do |repartidor|
      mochilas.push(crear_mochila(repartidor.id))
    end
    mochilas
  end

  # def actualiar_mochila(mochila): To Do: insert...
end
