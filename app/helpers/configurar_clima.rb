module LaBobe
  class App
    module ConfigurarClima
      def configurar_clima(clima)
        ENV['MOCK_CLIMA'] = clima
      end
    end
    helpers ConfigurarClima
  end
end
