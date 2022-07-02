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

class CalificacionInexistente
  def initialize; end

  def ==(other)
    self.class == other.class
  end

  def comision(menu)
    (menu.precio * 0.05).to_i
  end
end

class CalificacionBuena
  def initialize; end

  def ==(other)
    self.class == other.class
  end

  def comision(menu)
    (menu.precio * 0.05).to_i
  end
end

class CalificacionMala
  def initialize; end

  def ==(other)
    self.class == other.class
  end

  def comision(menu)
    (menu.precio * 0.03).to_i
  end
end

class CalificacionExcelente
  def initialize; end

  def ==(other)
    self.class == other.class
  end

  def comision(menu)
    (menu.precio * 0.07).to_i
  end
end
