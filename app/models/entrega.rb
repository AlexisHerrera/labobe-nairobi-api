class Entrega
  attr_reader :pedido, :repartidor, :updated_on, :created_on
  attr_accessor :id

  def initialize(id, pedido, repartidor)
    @id = id
    @pedido = pedido
    @repartidor = repartidor
  end

  def ==(other)
    # TODO: hacerlo como la gente
    @id == other.id &&
      @pedido.id == other.pedido.id &&
      @repartidor.id == other.repartidor.id
  end
end
