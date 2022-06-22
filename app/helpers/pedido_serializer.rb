# Helper methods defined here can be accessed in any controller or view in the application

module LaBobe
  class App
    module PedidoSerializer
      def pedido_to_json(pedido)
        pedido_attributes(pedido).to_json
      end

      private

      def pedido_attributes(pedido)
        # Smell: acceder al id del estado con : pedido.estado.estado
        {id_pedido: pedido.id, id_usuario: pedido.id_usuario, id_menu: pedido.id_menu, id_estado: pedido.estado.estado}
      end
    end

    helpers PedidoSerializer
  end
end
