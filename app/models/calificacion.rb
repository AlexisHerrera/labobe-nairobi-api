class Calificacion
  attr_reader :puntaje

  def initialize(puntaje)
    @puntaje = puntaje
  end

  def ==(other)
    @puntaje == other.puntaje
  end

  def descripcion
    @puntaje.to_s
  end
end

class CalificacionInexistente
  def ==(other)
    self.class == other.class
  end

  def descripcion
    'sin calificacion'
  end
end
