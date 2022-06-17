class Pedido
  attr_reader :updated_on, :created_on

  attr_accessor :id, :id_usuario, :id_menu

  def initialize(id_usuario, id_menu, id = nil)
    @id = id
    @id_usuario = id_usuario
    @id_menu = id_menu
  end
end
