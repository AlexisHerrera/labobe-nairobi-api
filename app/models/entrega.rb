class Entrega
  attr_reader :pedido, :repartidor, :updated_on, :created_on
  attr_accessor :id

  def initialize(id, pedido, repartidor)
    @id = id
    @pedido = pedido
    @repartidor = repartidor
  end
end
