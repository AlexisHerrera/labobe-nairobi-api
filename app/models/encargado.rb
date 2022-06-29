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
    if pedido.esta_en_preparacion?
      # obtengo repartidor
      repartidores = obtener_repartidores
      repartidor = self.class.elegir_repartidor(repartidores, pedido)
      # asigno repartidor
      repartidor.asignar(pedido)
      enviar(repartidor) if repartidor.mochila_llena?
    end
    pedido.siguiente_estado if pedido.estado == EstadosFactory.new.crear(EstadosPosibles::ACEPTADO)
    # actualizo pedido
    @pedido_repo.save(pedido)

    # actualizo estado si mochila llena
  end

  # Si bien puede ser un metodo privado, este debe ser testeado porque tiene logica de negocio
  def self.elegir_repartidor(repartidores, _pedido)
    repartidores.sort_by! { |repartidor| repartidor.pedidos.size }
    repartidores[0]
  end

  private

  def obtener_repartidores
    repartidores = @repartidor_repo.all
    raise NoHayRepartidores if repartidores.length.zero?

    repartidores.each do |repartidor|
      pedidos_asignados = @pedido_repo.find_by_id_repartidor(repartidor.id)
      pedidos_asignados = pedidos_asignados.select { |pedido| pedido.estado == EstadosFactory.new.crear(EstadosPosibles::CAMINO) }
      repartidor.pedidos = pedidos_asignados
    end
    repartidores
  end
end
