# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module MenuHelper
      def menu_repo
        Persistence::Repositories::MenuRepository.new
      end

      def menu_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

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

    helpers MenuHelper
  end
end
