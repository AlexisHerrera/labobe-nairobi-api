class Mochila
  attr_reader :pedidos, :repartidor, :updated_on, :created_on

  def initialize(repartidor, pedidos)
    @repartidor = repartidor
    @pedidos = pedidos
    @capacidad = 3
  end

  def esta_vacia?
    @pedidos.empty?
  end

  def esta_llena?
    capacidad_ocupada == @capacidad
  end

  def puede_agregar(pedido)
    capacidad_ocupada + pedido.menu.peso <= @capacidad
  end

  def ==(other)
    @repartidor.id == other.repartidor.id
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
