module Persistence
  module Repositories
    class RepartidorRepository < AbstractRepository
      self.table_name = :repartidores
      self.model_class = 'Repartidor'

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
