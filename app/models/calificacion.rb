class Calificacion
  attr_reader :puntaje

  def initialize(puntaje)
    @puntaje = puntaje
  end

  def ==(other)
    self.class == other.class
  end
end
