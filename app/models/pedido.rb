require_relative 'estado_pedido'

class Pedido
  attr_reader :updated_on, :created_on, :repartidor_asignado

  attr_accessor :id, :usuario, :menu, :estado, :calificacion

  def initialize(usuario, menu, id = nil)
    @id = id # = numero de pedido
    @usuario = usuario
    @menu = menu
    @estado = EstadosFactory.new.crear(EstadosPosibles::ACEPTADO)
    @repartidor_asignado = Repartidor.no_repartidor
    @calificacion = CalificacionInexistente.new
  end

  def verificar_propietario(usuario)
    raise UsuarioInvalido if usuario != @usuario
  end

  def calificar(usuario, calificacion)
    raise UsuarioInvalido if usuario != @usuario
    raise EstadoInvalido if (estado != EstadoEntregado.new) && (calificacion != CalificacionInexistente.new)

    @calificacion = calificacion
  end

  def comision_base
    @calificacion.comision(menu)
  end

  def comision_extra(dia)
    return menu.precio * 0.01 if dia.llueve?

    0
  end

  def siguiente_estado
    @estado = @estado.siguiente_estado
  end

  def esta_en_preparacion?
    @estado.esta_en_preparacion?
  end

  def asignar_repartidor(repartidor)
    @repartidor_asignado = repartidor
  end

  def ==(other)
    @id == other.id &&
      @usuario == other.usuario &&
      @menu == other.menu &&
      @estado == other.estado &&
      @repartidor_asignado == other.repartidor_asignado
  end
end

class PedidoInexistente < Pedido
end
