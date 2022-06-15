class Menu
  attr_reader :updated_on, :created_on

  attr_accessor :id, :descripcion, :precio

  def initialize(id, descripcion, precio)
    @id = id
    @descripcion = descripcion
    @precio = precio
  end
end
