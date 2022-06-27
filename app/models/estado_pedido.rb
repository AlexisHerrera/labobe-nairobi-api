class EstadosPosibles
  ACEPTADO = :Aceptado
  CAMINO = :EnCamino
  PREPARACION = :EnPreparacion
  ENTREGADO = :Entregado
end

class EstadoPedido
  attr_reader :pedido

  def siguiente_estado
    raise ''
  end

  def ==(other)
    self.class == other.class
  end

  def esta_en_preparacion?
    false
  end

  def initialize(pedido = PedidoInexistente)
    @pedido = pedido
  end
end

class EstadosFactory
  def crear_estado(estado, pedido)
    case estado
    when EstadosPosibles::ACEPTADO
      EstadoAceptado.new(pedido)
    when EstadosPosibles::PREPARACION
      EstadoEnPreparacion.new(pedido)
    when EstadosPosibles::CAMINO
      EstadoEnCamino.new(pedido)
    when EstadosPosibles::ENTREGADO
      EstadoEntregado.new(pedido)
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
    AsignadorDePedidos.new.asignar(@pedido)
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
