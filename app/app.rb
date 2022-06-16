module WebTemplate
  class App < Padrino::Application
    register Padrino::Helpers

    Padrino.configure :development, :test, :staging, :production do
    end

    Padrino.configure do
    end

    get '/' do
      "It\'s alive! version: #{Version.current}"
    end

    post '/reset', :provides => [:js] do
      if ENV['ENABLE_RESET'] == 'true'
        user_repo.delete_all
        menu_repo.delete_all

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
