# Helper methods defined here can be accessed in any controller or view in the application

module LaBobe
  class App
    module MenuSerializer
      def menu_to_json(menu)
        menu_attributes(menu).to_json
      end

      def menus_to_json(menus)
        menus.map { |menu| menu_attributes(menu) }.to_json
      end

      private

      def menu_attributes(menu)
        {id: menu.id, descripcion: menu.descripcion, precio: menu.precio}
      end
    end

    helpers MenuSerializer
  end
end
