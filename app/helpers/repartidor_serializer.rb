module LaBobe
  class App
    module RepartidorSerializer
      def repartidor_to_json(repartidor)
        repartidor_attributes(repartidor).to_json
      end

      def repartidor_to_hash(repartidor)
        repartidor_attributes(repartidor)
      end

      private

      def repartidor_attributes(repartidor)
        {id: repartidor.id, nombre: repartidor.nombre, dni: repartidor.dni, telefono: repartidor.telefono}
      end
    end

    helpers RepartidorSerializer
  end
end
