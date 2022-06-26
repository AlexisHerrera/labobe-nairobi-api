module Persistence
  module Repositories
    class EntregaRepository < AbstractRepository
      self.table_name = :entregas
      self.model_class = 'Entrega'

      def find_by_id_pedido(id_pedido)
        found_record = dataset.first(Sequel[self.class.table_name][:id_pedido] => id_pedido)
        raise ObjectNotFound.new(self.class.model_class, id_pedido) if found_record.nil?

        load_object dataset.first(found_record)
      end

      def find_by_repartidor(id_repartidor)
        found_record = dataset.where(Sequel[self.class.table_name][:id_repartidor] => id_repartidor)
        raise ObjectNotFound.new(self.class.model_class, id_repartidor) if found_record.nil?

        entregas = []
        found_record.each do |record|
          entregas.push(load_object(record))
        end
        entregas
      end

      protected

      # De la DB al objeto entrega
      def load_object(a_hash)
        pedido_repo = Persistence::Repositories::PedidoRepository.new
        repartidor_repo = Persistence::Repositories::RepartidorRepository.new
        Entrega.new(a_hash[:id], pedido_repo.find(a_hash[:id_pedido]), repartidor_repo.find(a_hash[:id_repartidor]))
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
