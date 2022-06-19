class EstadoPedido
  attr_accessor :estado

  def initialize(estado)
    @estado = estado
  end

  def cambiar_estado
    @estado += 1 if @estado < 3
  end
end
