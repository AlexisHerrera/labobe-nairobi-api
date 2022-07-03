class Encargado
  def initialize(pedido_repo, repartidor_repo, token = 'fake_token')
    @pedido_repo = pedido_repo
    @repartidor_repo = repartidor_repo
    # TODO: Cargar el token del environment
    @token = token
  end

  def procesar_pedido(pedido)
    if pedido.esta_en_preparacion?
      repartidores = obtener_repartidores
      repartidor = self.class.elegir_repartidor(repartidores, pedido)
      repartidor.asignar(pedido)
      enviar(repartidor) if repartidor.mochila_llena?
    end
    pedido.siguiente_estado if pedido.estado == EstadosFactory.new.crear(EstadosPosibles::ACEPTADO)
    @pedido_repo.save(pedido)
  end

  def self.elegir_repartidor(repartidores, pedido)
    repartidores = repartidores.sort
    repartidores = repartidores.select { |repartidor| repartidor.entra_pedido?(pedido) }
    repartidores[0]
  end

  def calcular_comision(dni_repartidor)
    # TODO: mover la api para adentro del dia factory?
    api_clima = APIClima.new(@token)
    tipo_dia = DiaFactory.new(api_clima).obtener_dia
    obtener_repartidor(dni_repartidor).comision(tipo_dia)
  end

  private

  def obtener_repartidores
    repartidores = @repartidor_repo.all
    raise NoHayRepartidores if repartidores.length.zero?

    repartidores.each do |repartidor|
      asignar_pedidos(repartidor)
    end
    repartidores
  end

  def obtener_repartidor(dni_repartidor)
    repartidor = @repartidor_repo.find_by_dni(dni_repartidor)
    asignar_pedidos(repartidor)
    repartidor
  end

  def asignar_pedidos(repartidor)
    pedidos_repartidor = @pedido_repo.find_by_id_repartidor(repartidor.id)

    pedidos_actuales = pedidos_repartidor.select { |pedido| pedido.estado == EstadosFactory.new.crear(EstadosPosibles::CAMINO) }
    repartidor.pedidos_en_camino = pedidos_actuales
    pedidos_entregados = pedidos_repartidor.select { |pedido| pedido.estado == EstadosFactory.new.crear(EstadosPosibles::ENTREGADO) }
    repartidor.pedidos_entregados = pedidos_entregados
  end

  def enviar(repartidor)
    repartidor.salir
    pedidos = repartidor.pedidos_en_camino
    pedidos.each do |pedido|
      @pedido_repo.save(pedido)
    end
  end
end
