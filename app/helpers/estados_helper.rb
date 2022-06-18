# Helper methods defined here can be accessed in any controller or view in the application

module LaBobe
  class App
    module EstadosHelper
      def estado_repo
        Persistence::Repositories::EstadoRepository.new
      end

      def estado_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def estado_to_json(estado)
        estado_attributes(estado).to_json
      end

      private

      def estados_attributes(estado)
        {id: estado.id, descripcion: estado.descripcion}
      end
    end

    helpers EstadosHelper
  end
end
