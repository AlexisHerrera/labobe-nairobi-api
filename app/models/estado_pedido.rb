class EstadosPosibles
  ACEPTADO = :Aceptado
  CAMINO = :EnCamino
  PREPARACION = :EnPreparacion
  ENTREGADO = :Entregado
end

class EstadoPedido
  def siguiente_estado
    raise ''
  end

  def ==(other)
    self.class == other.class
  end

  def esta_en_preparacion?
    false
  end
end

class EstadosFactory
  def crear_estado(estado)
    case estado
    when EstadosPosibles::ACEPTADO
      EstadoAceptado.new
    when EstadosPosibles::PREPARACION
      EstadoEnPreparacion.new
    when EstadosPosibles::CAMINO
      EstadoEnCamino.new
    when EstadosPosibles::ENTREGADO
      EstadoEntregado.new
    else
      raise ''
    end
  end
end

class EstadoAceptado < EstadoPedido
  def siguiente_estado
    EstadoEnPreparacion.new
  end
end

class EstadoEnPreparacion < EstadoPedido
  def siguiente_estado
    # logica
    EstadoEnCamino.new
  end

  def esta_en_preparacion?
    true
  end
end

class EstadoEnCamino < EstadoPedido
  def siguiente_estado
    # logica
    EstadoEntregado.new
  end
end

class EstadoEntregado < EstadoPedido
  def siguiente_estado
    # logica
    EstadoEntregado.new
  end
end
