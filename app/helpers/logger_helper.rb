module LaBobe
  class App
    module LoggerHelper
      def logger
        SemanticLogger['LaBobeAPI']
      end
    end

    helpers LoggerHelper
  end
end
