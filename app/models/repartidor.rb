class Repartidor
  attr_reader :nombre, :dni, :telefono, :updated_on, :created_on
  attr_accessor :id, :pedidos_en_camino, :pedidos_entregados

  ESPACIO_TOTAL = 3

  # TODO: SACAR nil como id, pasarlo a ultimo parametro como opcional o setter
  def initialize(id, nombre, dni, telefono)
    validar_nombre(nombre)
    validar_telefono(telefono)
    @id = id
    @nombre = nombre
    @dni = dni
    @telefono = telefono
    @pedidos_entregados = []
    @pedidos_en_camino = []
  end

  def ==(other)
    @id == other.id &&
      @nombre == other.nombre &&
      @telefono == other.telefono &&
      @dni == other.dni
  end

  def <=>(other)
    if espacio_restante == other.espacio_restante
      return @nombre <=> other.nombre if @pedidos_entregados.size == other.pedidos_entregados.size

      return @pedidos_entregados.size <=> other.pedidos_entregados.size
    end
    espacio_restante <=> other.espacio_restante
  end

  def validar_nombre(nombre)
    largo_nombre = nombre.delete(' ').length
    raise RepartidorInvalido if largo_nombre < 5 || largo_nombre > 20
  end

  # En este caso telefono es un string
  def validar_telefono(telefono)
    raise RepartidorInvalido if telefono.to_i.to_s != telefono

    raise RepartidorInvalido if telefono.length != 10
  end

  def comision
    comision = 0
    @pedidos_entregados.each do |pedido|
      comision += pedido.comision
    end
    comision
  end

  def asignar(pedido)
    pedido.asignar_repartidor(self)
    pedido.siguiente_estado
    @pedidos_en_camino.push(pedido)
  end

  def tiene_pedidos?
    @pedidos_en_camino.size.zero?
  end

  def mochila_llena?
    espacio_restante.zero?
  end

  def entra_pedido?(pedido)
    pedido.menu.peso <= espacio_restante
  end

  def espacio_restante
    peso = 0
    @pedidos_en_camino.each do |pedido|
      peso += pedido.menu.peso
    end
    ESPACIO_TOTAL - peso
  end

  def salir
    @pedidos_en_camino.each(&:siguiente_estado)
  end

  # Ver ejercicio 4 - clase Aula (entrega de la catedra)
  class << self
    attr_reader :no_repartidor # rubocop:disable: Style/TrivialAccessors:
  end

  @no_repartidor = new(nil, 'No name', '10000000', '1123456789')
end
