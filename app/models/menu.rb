class Menu
  attr_reader :updated_on, :created_on

  attr_accessor :id, :descripcion, :precio, :peso

  def initialize(id, descripcion, precio)
    validar(id, precio)

    @id = id
    @descripcion = descripcion
    @precio = precio
  end

  def validar(id, precio)
    raise MenuInvalido if !id.is_a?(Integer) || !precio.is_a?(Numeric) || precio.negative?
  end

  def tamanio
    MenusPosibles::INDEFINIDO
  end

  def ==(other)
    @id == other.id &&
      @descripcion == other.descripcion &&
      @precio == other.precio
  end
end

class MenusPosibles
  GRANDE = :grande
  MEDIANO = :mediano
  CHICO = :chico
  INDEFINIDO = :indefinido
end

class MenuFactory
  def crear(id, descripcion, precio, tamanio)
    case tamanio
    when MenusPosibles::GRANDE
      MenuGrande.new(id, descripcion, precio)
    when MenusPosibles::MEDIANO
      MenuMediano.new(id, descripcion, precio)
    when MenusPosibles::CHICO
      MenuChico.new(id, descripcion, precio)
    else
      raise MenuInvalido
    end
  end
end

class MenuGrande < Menu
  def initialize(id, descripcion, precio)
    @peso = 3
    super(id, descripcion, precio)
  end

  def tamanio
    MenusPosibles::GRANDE
  end
end

class MenuMediano < Menu
  def initialize(id, descripcion, precio)
    @peso = 2
    super(id, descripcion, precio)
  end

  def tamanio
    MenusPosibles::MEDIANO
  end
end

class MenuChico < Menu
  def initialize(id, descripcion, precio)
    @peso = 1
    super(id, descripcion, precio)
  end

  def tamanio
    MenusPosibles::CHICO
  end
end
