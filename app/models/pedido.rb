class Pedido
  attr_reader :updated_on, :created_on

  attr_accessor :id, :usuario, :menu

  def initialize(id, usuario, menu)
    @id = id
    @usuario = usuario
    @menu = menu
  end
end
