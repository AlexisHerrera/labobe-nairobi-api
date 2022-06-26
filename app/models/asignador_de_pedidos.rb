class AsignadorDePedidos
  attr_reader :repo_de_mochilas

  def initialize
    @entregas_repo = Persistence::Repositories::EntregaRepository.new
    pedidos_repo = Persistence::Repositories::PedidoRepository.new
    repartidores_repo = Persistence::Repositories::RepartidorRepository.new

    @repo_de_mochilas = RepositorioDeMochilas.new(@entregas_repo, pedidos_repo, repartidores_repo)
  end

  def asignar(pedido)
    mochilas = @repo_de_mochilas.obtener_mochilas
    mochilas.each do |mochila|
      next unless mochila.puede_agregar(pedido)

      entrega = Entrega.new(nil, pedido, mochila.repartidor)
      @entregas_repo.save(entrega)
    end
  end
end
