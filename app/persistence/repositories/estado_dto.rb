class EstadoDTO
  attr_reader :updated_on, :created_on

  attr_accessor :id, :descripcion

  def initialize(estado, descripcion)
    @id = estado
    @descripcion = descripcion
  end

  def ==(other)
    @id == other.id &&
      @descripcion == other.descripcion
  end
end
