class Calificacion
  attr_reader :puntaje

  def initialize(puntaje)
    validar_puntaje(puntaje)

    @puntaje = puntaje
  end

  def ==(other)
    self.class == other.class &&
      @puntaje == other.puntaje
  end

  def descripcion
    @puntaje.to_s
  end

  protected

  def validar_puntaje(puntaje)
    raise CalificacionInvalida if puntaje > 5 || puntaje < 1
    raise CalificacionInvalida unless puntaje.is_a?(Integer)
  end
end

class CalificacionFactory
  def crear(puntaje)
    case puntaje
    when 'sin calificacion'
      CalificacionInexistente.new
    when '1'
      CalificacionMala.new
    when '3'
      CalificacionBuena.new
    when '5'
      CalificacionExcelente.new
    else
      Calificacion.new(puntaje.to_i)
    end
  end
end

class CalificacionInexistente < Calificacion
  def initialize(_puntaje = -1)
    super(3)
  end

  def descripcion
    'sin calificacion'
  end
end

class CalificacionBuena < Calificacion
  def initialize(puntaje = 3)
    super(puntaje)
  end
end

class CalificacionMala < Calificacion
  def initialize(puntaje = 1)
    super(puntaje)
  end
end

class CalificacionExcelente < Calificacion
  def initialize(puntaje = 5)
    super(puntaje)
  end
end
