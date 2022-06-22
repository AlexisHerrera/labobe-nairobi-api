module LaBobe
  class App
    module Parser
      def body_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end
    end
    helpers Parser
  end
end
