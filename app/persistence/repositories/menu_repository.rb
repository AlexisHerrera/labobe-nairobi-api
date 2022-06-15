module Persistence
  module Repositories
    class MenuRepository < AbstractRepository
      self.table_name = :menu
      self.model_class = 'Menu'

      protected

      def load_object(a_hash)
        Menu.new(a_hash[:id], a_hash[:descripcion], a_hash[:precio])
      end

      def changeset(menu)
        {
          id: menu.id,
          descripcion: menu.descripcion,
          precio: menu.precio
        }
      end
    end
  end
end
