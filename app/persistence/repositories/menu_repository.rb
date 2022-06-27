module Persistence
  module Repositories
    class MenuRepository < AbstractRepository
      self.table_name = :menu
      self.model_class = 'Menu'

      protected

      def load_object(a_hash)
        MenuFactory.new.crear(a_hash[:id], a_hash[:descripcion], a_hash[:precio], a_hash[:tamanio].to_sym)
      end

      def changeset(menu)
        {
          id: menu.id,
          descripcion: menu.descripcion,
          precio: menu.precio,
          tamanio: menu.tamanio.to_s
        }
      end
    end
  end
end
