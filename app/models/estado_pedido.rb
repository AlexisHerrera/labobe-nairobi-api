class EstadoPedido
  attr_accessor :estado

  def initialize(estado)
    @estado = estado
  end

  def cambiar_estado
    if @estado.zero?
      @estado = 1
    elsif @estado == 1
      @estado = 2
    end
  end
end
