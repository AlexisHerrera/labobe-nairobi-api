# Helper methods defined here can be accessed in any controller or view in the application

module LaBobe
  class App
    module PedidosHelper
      def pedido_repo
        Persistence::Repositories::PedidoRepository.new
      end

      def pedido_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def pedido_to_json(pedido)
        pedido_attributes(pedido).to_json
      end

      private

      def pedido_attributes(pedido)
        {id_pedido: pedido.id, id_usuario: pedido.id_usuario, id_menu: pedido.id_menu}
      end
    end

    helpers PedidosHelper
  end
end
