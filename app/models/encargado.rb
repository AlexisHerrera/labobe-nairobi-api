class Encargado
  def initialize(pedido_repo, repartidor_repo)
    @pedido_repo = pedido_repo
    @repartidor_repo = repartidor_repo
  end

  def procesar_pedido(pedido)
    if pedido.esta_en_preparacion?
      repartidores = obtener_repartidores
      repartidor = self.class.elegir_repartidor(repartidores, pedido)
      repartidor.asignar(pedido)
      enviar(repartidor) if repartidor.mochila_llena?
    end
    pedido.siguiente_estado if pedido.estado == EstadosFactory.new.crear(EstadosPosibles::ACEPTADO)
    @pedido_repo.save(pedido)
  end

  def self.elegir_repartidor(repartidores, pedido)
    repartidores = repartidores.sort
    repartidores = repartidores.select { |repartidor| repartidor.entra_pedido?(pedido) }
    repartidores[0]
  end

  def self.calcular_comision(_dni_repartidor)
    50
  end

  private

  def obtener_repartidores
    repartidores = @repartidor_repo.all
    raise NoHayRepartidores if repartidores.length.zero?

    repartidores.each do |repartidor|
      pedidos_repartidor = @pedido_repo.find_by_id_repartidor(repartidor.id)

      pedidos_actuales = pedidos_repartidor.select { |pedido| pedido.estado == EstadosFactory.new.crear(EstadosPosibles::CAMINO) }
      repartidor.pedidos = pedidos_actuales
      pedidos_realizados = pedidos_repartidor.select { |pedido| pedido.estado == EstadosFactory.new.crear(EstadosPosibles::ENTREGADO) }
      repartidor.pedidos_realizados = pedidos_realizados.size
    end
    repartidores
  end

  def enviar(repartidor)
    repartidor.salir
    pedidos = repartidor.pedidos
    pedidos.each do |pedido|
      @pedido_repo.save(pedido)
    end
  end
end
