module Persistence
  module Repositories
    class PedidoRepository < AbstractRepository
      self.table_name = :pedidos
      self.model_class = 'Pedido'

      protected

      def load_object(a_hash)
        menu = Persistence::Repositories::MenuRepository.new.find(a_hash[:id_menu].to_i)
        usuario = Persistence::Repositories::UsuarioRepository.new.find(a_hash[:id_usuario].to_s)

        Pedido.new(a_hash[:id], usuario, menu, a_hash[:estado].to_sym)
      end

      def changeset(pedido)
        {
          id_usuario: pedido.usuario.id,
          id_menu: pedido.menu.id,
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
          raise EstadoInvalido
        end
      end
    end
  end
end
