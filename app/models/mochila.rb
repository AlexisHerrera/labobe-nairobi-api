class Mochila
  attr_reader :pedidos, :repartidor, :capacidad, :updated_on, :created_on

  def initialize(repartidor)
    @repartidor = repartidor
  end

  def ==(other)
    @repartidor.id == other.id
  end
end
