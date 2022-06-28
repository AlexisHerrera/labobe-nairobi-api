require_relative 'estado_pedido'

class Pedido
  attr_reader :updated_on, :created_on, :repartidor_asignado

  attr_accessor :id, :usuario, :menu, :estado

  # TODO: SACAR nil como id, pasarlo a ultimo parametro como opcional o setter
  def initialize(id, usuario, menu, estado)
    @id = id # = numero de pedido
    @usuario = usuario
    @menu = menu
    @estado = EstadosFactory.new.crear(estado, self)
    @repartidor_asignado = RepartidorInexistente
  end

  def consultar(id_telegram)
    raise UsuarioInvalido if id_telegram != @usuario.id_telegram
  end

  def siguiente_estado
    @estado = @estado.siguiente_estado
  end

  def esta_en_preparacion?
    @estado.esta_en_preparacion?
  end

  def asignar_repartidor(repartidor)
    @repartidor_asignado = repartidor
  end
end

class PedidoInexistente < Pedido
end
