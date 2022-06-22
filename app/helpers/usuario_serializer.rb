# Helper methods defined here can be accessed in any controller or view in the application

module LaBobe
  class App
    module UsuarioSerializer
      def usuario_to_json(user)
        user_attributes(user).to_json
      end

      private

      def user_attributes(user)
        {id: user.id, nombre: user.nombre, direccion: user.direccion, telefono: user.telefono}
      end
    end

    helpers UsuarioSerializer
  end
end
