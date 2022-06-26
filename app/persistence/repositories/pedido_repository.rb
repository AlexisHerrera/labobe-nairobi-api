module Persistence
  module Repositories
    class PedidoRepository < AbstractRepository
      self.table_name = :pedidos
      self.model_class = 'Pedido'

      protected

      def load_object(a_hash)
        Pedido.new(a_hash[:id], a_hash[:id_usuario].to_s, a_hash[:id_menu], a_hash[:estado].to_sym)
      end

      def changeset(pedido)
        {
          id_usuario: pedido.id_usuario,
          id_menu: pedido.id_menu,
          estado: detectar_estado(pedido.estado)
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
          raise ''
        end
      end
    end
  end
end
