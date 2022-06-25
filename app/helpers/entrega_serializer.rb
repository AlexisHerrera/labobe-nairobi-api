module LaBobe
  class App
    module EntregaSerializer
      def entrega_to_json(entrega)
        entrega_attributes(entrega).to_json
      end

      private

      def entrega_attributes(entrega)
        {id_repartidor: entrega.repartidor.id, id_pedido: entrega.pedido.id}
      end
    end

    helpers EntregaSerializer
  end
end
