class Mochila
  attr_reader :pedidos, :repartidor, :updated_on, :created_on

  def initialize(repartidor)
    @repartidor = repartidor
    @pedidos = []
    @capacidad = 3
  end

  def esta_vacia?
    @pedidos.empty?
  end

  def esta_llena?
    capacidad_ocupada == @capacidad
  end

  def ==(other)
    @repartidor.id == other.id
  end

  protected

  attr_reader :capacidad

  def capacidad_ocupada
    total = 0
    @pedidos.each do |pedido|
      total += pedido.menu.peso
    end
  end
end
