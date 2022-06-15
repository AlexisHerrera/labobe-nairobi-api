module Persistence
  module Repositories
    class UserRepository < AbstractRepository
      self.table_name = :usuarios
      self.model_class = 'Usuario'

      protected

      def load_object(a_hash)
        Usuario.new(a_hash[:nombre], a_hash[:telefono], a_hash[:direccion], a_hash[:id_telegram])
      end

      def changeset(user)
        {
          id: user.telefono,
          telefono: user.telefono,
          id_telegram: user.id_telegram,
          nombre: user.nombre,
          direccion: user.direccion
        }
      end
    end
  end
end
