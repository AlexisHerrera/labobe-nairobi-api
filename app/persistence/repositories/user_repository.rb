module Persistence
  module Repositories
    class UserRepository < AbstractRepository
      self.table_name = :usuarios
      self.model_class = 'Usuario'

      protected

      def load_object(a_hash)
        Usuario.new(a_hash[:nombre], a_hash[:telefono], a_hash[:direccion])
      end

      def changeset(user)
        {
          nombre: user.nombre,
          telefono: user.telefono,
          direccion: user.direccion
        }
      end
    end
  end
end
