module Persistence
  module Repositories
    class UserRepository < AbstractRepository
      self.table_name = :usuarios
      self.model_class = 'Usuario'

      def has_telegram_id(id_telegram)
        found_record = DB[:usuarios].first(Sequel[self.class.table_name][:id_telegram] => id_telegram)
        !found_record.nil?
      end

      def has_telefono(telefono)
        found_record = DB[:usuarios].first(Sequel[self.class.table_name][:telefono] => telefono)
        !found_record.nil?
      end

      protected

      def load_object(a_hash)
        Usuario.new(a_hash[:nombre], a_hash[:telefono], a_hash[:direccion], a_hash[:id_telegram])
      end

      def changeset(user)
        {
          id: user.id,
          telefono: user.telefono,
          id_telegram: user.id_telegram,
          nombre: user.nombre,
          direccion: user.direccion
        }
      end
    end
  end
end
