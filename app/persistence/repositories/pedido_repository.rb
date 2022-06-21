module Persistence
  module Repositories
    class PedidoRepository < AbstractRepository
      self.table_name = :pedidos
      self.model_class = 'Pedido'

      protected

      def load_object(a_hash)
        Pedido.new(a_hash[:id], a_hash[:id_usuario].to_s, a_hash[:id_menu], a_hash[:id_estado])
      end

      def changeset(pedido)
        {
          id_usuario: pedido.id_usuario,
          id_menu: pedido.id_menu,
          id_estado: pedido.estado.estado
        }
      end
    end
  end
end
