module Persistence
  module Repositories
    class EstadoRepository < AbstractRepository
      self.table_name = :estados
      self.model_class = 'Estado'

      protected

      def load_object(a_hash)
        Estado.new(a_hash[:id], a_hash[:descripcion])
      end

      def changeset(estado)
        {
          id: estado.id,
          descripcion: estado.descripcion
        }
      end
    end
  end
end
