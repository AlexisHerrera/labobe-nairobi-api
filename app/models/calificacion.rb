class Calificacion
  attr_reader :puntaje

  def initialize(puntaje)
    validar_puntaje(puntaje)

    @puntaje = puntaje
  end

  def ==(other)
    self.class == other.class
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

class CalificacionPosibles
  MALA = :Mala
  BUENA = :Buena
  EXCELENTE = :Excelente
  INEXISTENTE = :Inexistente
end

class CalificacionFactory
  def crear(puntaje)
    case puntaje
    when CalificacionPosibles::INEXISTENTE
      CalificacionInexistente.new
    when CalificacionPosibles::MALA
      CalificacionMala.new
    when CalificacionPosibles::BUENA
      CalificacionBuena.new
    when CalificacionPosibles::EXCELENTE
      CalificacionExcelente.new
    else
      crear(validar_puntaje(puntaje))
    end
  end

  private

  def validar_puntaje(puntaje)
    puntaje = puntaje.to_i
    if puntaje == 1
      CalificacionPosibles::MALA
    elsif puntaje < 5 && puntaje > 1
      CalificacionPosibles::BUENA
    elsif puntaje == 5
      CalificacionPosibles::EXCELENTE
    else
      raise CalificacionInvalida
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
