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

  def asignar_pedido(pedido)
    # obtengo repartidor
    repartidores = obtener_repartidores
    repartidor = self.class.elegir_repartidor(repartidores, pedido)
    # asigno repartidor
    pedido.asignar_repartidor(repartidor)
    repartidor.asignar(pedido)
    # actualizo pedido
    @pedido_repo.save(pedido)

    # actualizo estado si mochila llena
    enviar(repartidor) if repartidor.mochila_llena?
  end

  # Si bien puede ser un metodo privado, este debe ser testeado porque tiene logica de negocio
  def self.elegir_repartidor(repartidores, _pedido)
    repartidores.sort_by! { |repartidor| repartidor.pedidos.size }
    repartidores[0]
  end

  private

  def obtener_repartidores
    repartidores = @repartidor_repo.all
    repartidores.each do |repartidor|
      repartidor.pedidos = @pedido_repo.find_by_id_repartidor(repartidor.id)
    end
    repartidores
  end
end
