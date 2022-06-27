require_relative 'estado_pedido'

class Pedido
  attr_reader :updated_on, :created_on

  attr_accessor :id, :id_usuario, :menu, :estado

  def initialize(id, id_usuario, menu, estado)
    @id = id # = numero de pedido
    @id_usuario = id_usuario
    @menu = menu
    @estado = EstadosFactory.new.crear(estado, self)
  end

  def consultar(id)
    raise UsuarioInvalido if id != @id_usuario
  end

  def siguiente_estado
    @estado = @estado.siguiente_estado
  end

  def esta_en_preparacion?
    @estado.esta_en_preparacion?
  end
end

class PedidoInexistente < Pedido
end
