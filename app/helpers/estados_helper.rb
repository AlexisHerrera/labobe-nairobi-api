# Helper methods defined here can be accessed in any controller or view in the application

module LaBobe
  class App
    # TODO: Ver si vale la pena el shorthand o no
    module EstadoRepoShorthand
      def estado_repo
        Persistence::Repositories::EstadoRepository.new
      end
    end

    module EstadoSerializer
      def estado_to_json(estado)
        estado_attributes(estado).to_json
      end

      private

      def estado_attributes(estado)
        {estado: estado.descripcion}
      end
    end

    module EstadoParser
      def estado_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end
    end
    helpers EstadoRepoShorthand
    helpers EstadoParser
    helpers EstadoSerializer
  end
end
