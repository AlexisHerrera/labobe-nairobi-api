class Pedido
  attr_reader :updated_on, :created_on

  attr_accessor :id, :id_usuario, :id_menu, :id_estado

  def initialize(id, id_usuario, id_menu, id_estado)
    @id = id # = numero de pedido
    @id_usuario = id_usuario
    @id_menu = id_menu
    @id_estado = id_estado
  end
end
