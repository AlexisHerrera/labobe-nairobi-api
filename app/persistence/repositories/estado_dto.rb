class EstadoDTO
  attr_reader :updated_on, :created_on

  attr_accessor :id, :descripcion

  def initialize(estado, descripcion)
    @id = estado
    @descripcion = descripcion
  end
end
