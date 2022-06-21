require_relative 'estado_pedido'

class Pedido
  attr_reader :updated_on, :created_on

  attr_accessor :id, :id_usuario, :id_menu, :estado

  def initialize(id, id_usuario, id_menu, id_estado)
    @id = id # = numero de pedido
    @id_usuario = id_usuario
    @id_menu = id_menu
    @estado = EstadoPedido.new(id_estado)
  end

  def consultar(id)
    raise UsuarioInvalido if id != @id_usuario
  end

  def cambiar_estado
    estado.cambiar_estado
  end
end
