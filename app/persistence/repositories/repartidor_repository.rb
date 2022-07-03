module Persistence
  module Repositories
    class RepartidorRepository < AbstractRepository
      self.table_name = :repartidores
      self.model_class = 'Repartidor'

      def has_dni(dni)
        found_record = DB[:repartidores].first(Sequel[self.class.table_name][:dni] => dni)
        !found_record.nil?
      end

      def find_by_dni(dni)
        found_record = dataset.first(Sequel[self.class.table_name][:dni] => dni)
        raise ObjectNotFound.new(self.class.model_class, dni) if found_record.nil?

        load_object dataset.first(found_record)
      end

      protected

      # De la DB al objeto Repartidor
      def load_object(a_hash)
        Repartidor.new(a_hash[:nombre], a_hash[:dni], a_hash[:telefono], a_hash[:id])
      end

      # Del objeto Repartidor a la DB
      def changeset(repartidor)
        {
          nombre: repartidor.nombre,
          dni: repartidor.dni,
          telefono: repartidor.telefono
        }
      end
    end
  end
end
