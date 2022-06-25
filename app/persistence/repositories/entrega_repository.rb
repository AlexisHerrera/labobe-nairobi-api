module Persistence
  module Repositories
    class EntregaRepository < AbstractRepository
      self.table_name = :entregas
      self.model_class = 'Entrega'

      protected

      # De la DB al objeto entrega
      def load_object(a_hash)
        Entrega.new(a_hash[:id], a_hash[:id_pedido], a_hash[:id_repartidor])
      end

      # Del objeto entrega a la DB
      def changeset(entrega)
        {
          id_pedido: entrega.pedido.id,
          id_repartidor: entrega.repartidor.id
        }
      end
    end
  end
end
