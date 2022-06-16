module Persistence
  module Repositories
    class PedidoRepository < AbstractRepository
      self.table_name = :pedidos
      self.model_class = 'Pedido'

      protected

      def load_object(a_hash)
        Pedido.new(a_hash[:id], a_hash[:id_usuario], a_hash[:id_menu])
      end

      def changeset(pedido)
        {
          id: pedido.id,
          id_usuario: pedido.id_usuario,
          id_menu: pedido.id_menu
        }
      end
    end
  end
end
