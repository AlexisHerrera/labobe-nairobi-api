class Entrega

  attr_reader :pedido, :repartidor

  def initialize(pedido, repartidor)
    @pedido = pedido
    @repartidor = repartidor
  end
end
