module Persistence
  module Repositories
    class RepartidorRepository < AbstractRepository
      self.table_name = :repartidores
      self.model_class = 'Repartidor'

      def has_dni(dni)
        found_record = DB[:repartidores].first(Sequel[self.class.table_name][:dni] => dni)
        !found_record.nil?
      end

      protected

      # De la DB al objeto Repartidor
      def load_object(a_hash)
        Repartidor.new(a_hash[:id], a_hash[:nombre], a_hash[:dni], a_hash[:telefono])
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
