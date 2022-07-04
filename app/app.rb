module LaBobe
  class App < Padrino::Application
    register Padrino::Helpers

    Padrino.configure :test do
      ENV['URL_API_CLIMA'] = 'https://fake.clima.api'
      ENV['ENABLE_MOCK'] = 'true'
    end

    Padrino.configure do
    end

    get '/' do
      "It\'s alive! version: #{Version.current}"
    end

    post '/reset', :provides => [:js] do
      if ENV['ENABLE_RESET'] == 'true'
        Persistence::Repositories::PedidoRepository.new.delete_all
        Persistence::Repositories::RepartidorRepository.new.delete_all
        Persistence::Repositories::UsuarioRepository.new.delete_all

        status 200
        {message: 'reset ok'}.to_json
      else
        status 403
        {message: 'reset not enabled'}.to_json
      end
    end

    get :docs, map: '/docs' do
      render 'docs'
    end
  end
end
