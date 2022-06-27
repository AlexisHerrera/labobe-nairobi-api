require_relative 'estado_pedido'

class Pedido
  attr_reader :updated_on, :created_on

  attr_accessor :id, :usuario, :menu, :estado

  def initialize(id, usuario, menu, estado)
    @id = id # = numero de pedido
    @usuario = usuario
    @menu = menu
    @estado = EstadosFactory.new.crear(estado, self)
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
end

class PedidoInexistente < Pedido
end
