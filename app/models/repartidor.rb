class Repartidor
  attr_reader :nombre, :dni, :telefono, :updated_on, :created_on
  attr_accessor :id, :pedidos

  # TODO: SACAR nil como id, pasarlo a ultimo parametro como opcional o setter
  def initialize(id, nombre, dni, telefono)
    validar_nombre(nombre)
    validar_telefono(telefono)
    @id = id
    @nombre = nombre
    @dni = dni
    @telefono = telefono
    @pedidos = []
  end

  def ==(other)
    @id == other.id &&
      @nombre == other.nombre &&
      @telefono == other.telefono &&
      @dni == other.dni
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

  def asignar(pedido)
    @pedidos.push(pedido)
  end

  def tiene_pedidos?
    @pedidos.size.zero?
  end

  def mochila_llena?
    peso = 0
    pedidos.each do |pedido|
      peso += pedido.menu.peso
    end
    peso == 3
  end

  # Ver ejercicio 4 - clase Aula (entrega de la catedra)
  class << self
    attr_reader :no_repartidor # rubocop:disable: Style/TrivialAccessors:
  end

  @no_repartidor = new(nil, 'No name', '10000000', '1123456789')
end
