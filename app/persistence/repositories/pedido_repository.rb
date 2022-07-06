module Persistence
  module Repositories
    class PedidoRepository < AbstractRepository
      self.table_name = :pedidos
      self.model_class = 'Pedido'

      def find_by_id_repartidor(id_repartidor)
        pedidos = dataset.where(Sequel[self.class.table_name][:id_repartidor] => id_repartidor)
        return [] if pedidos.nil?

        load_collection pedidos.all
      end

      protected

      def load_object(a_hash)
        menu = Persistence::Repositories::MenuRepository.new.find(a_hash[:id_menu].to_i)
        usuario = Persistence::Repositories::UsuarioRepository.new.find(a_hash[:id_usuario].to_s)

        pedido = Pedido.new(usuario, menu, a_hash[:id])

        pasar_estados(a_hash, pedido)

        calificacion = CalificacionFactory.new.crear(a_hash[:calificacion].to_sym)
        pedido.calificar(usuario, calificacion)

        begin
          repartidor = Persistence::Repositories::RepartidorRepository.new.find(a_hash[:id_repartidor])
        rescue ObjectNotFound # TODO: Esto esta mega feo, buscar refactor
          return pedido
        end
        pedido.asignar_repartidor(repartidor)
        pedido
      end

      def changeset(pedido)
        {
          id_usuario: pedido.usuario.id,
          id_menu: pedido.menu.id,
          estado: detectar_estado(pedido.estado),
          id_repartidor: serializar_repartidor(pedido.repartidor_asignado),
          calificacion: detectar_calificacion(pedido.calificacion)
        }
      end

      def detectar_estado(estado)
        case estado
        when EstadoAceptado.new
          EstadosPosibles::ACEPTADO.to_s
        when EstadoEnPreparacion.new
          EstadosPosibles::PREPARACION.to_s
        when EstadoEnCamino.new
          EstadosPosibles::CAMINO.to_s
        when EstadoEntregado.new
          EstadosPosibles::ENTREGADO.to_s
        else
          raise EstadoInvalido
        end
      end

      def detectar_calificacion(calificacion)
        case calificacion
        when CalificacionMala.new
          CalificacionPosibles::MALA.to_s
        when CalificacionBuena.new
          CalificacionPosibles::BUENA.to_s
        when CalificacionExcelente.new
          CalificacionPosibles::EXCELENTE.to_s
        when CalificacionInexistente.new
          CalificacionPosibles::INEXISTENTE.to_s
        else
          raise CalificacionInvalida
        end
      end

      def serializar_repartidor(repartidor)
        return nil if repartidor == Repartidor.no_repartidor

        repartidor.id
      end

      private

      def pasar_estados(a_hash, pedido)
        estados_mapeo = {
          :Aceptado => 0,
          :EnPreparacion => 1,
          :EnCamino => 2
          # :Entregado => 3
        }
        estados_pasados = 0
        puts(a_hash[:estado].to_sym)
        while estados_pasados < estados_mapeo[a_hash[:estado].to_sym]
          pedido.siguiente_estado
          estados_pasados += 1
        end
      end
    end
  end
end
