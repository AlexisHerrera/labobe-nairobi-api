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

  # Aca hay que obtener el peso del pedido y sacar el + 1
  # MenuRepository.find(pedido.id_menu).peso es una posibilidad
  def puede_agregar(_pedido)
    capacidad_ocupada + 1 <= @capacidad
  end

  def ==(other)
    @repartidor.id == other.repartidor.id
  end

  protected

  attr_reader :capacidad

  def capacidad_ocupada
    total = 0
    @pedidos.each do |_pedido|
      total += 1
    end
    total
  end
end
