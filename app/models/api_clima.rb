require 'faraday'

class APIClima
  def initialize(token)
    @token = token
    logger.info "Se utiliza el token #{token}"
  end

  def esta_lloviendo?
    esta_lloviendo = obtener_clima == 'Rain'
    logger.info 'La API indica que esta lloviendo' if esta_lloviendo
    logger.info 'La API indica que no esta lloviendo'
    esta_lloviendo
  end

  private

  def obtener_clima
    request = Faraday.get("https://api.openweathermap.org/data/2.5/weather?lat=-34.36&lon=-58.26&appid=#{@token}")
    if request.status != 200
      logger.error "No se pudo obtener el clima de la API: #{request}"
      # TODO: refactorizar a algo mejor que devolver 'Clouds' (tal vez una lanzar una excepcion?)
      return 'Clouds'
    end
    climas = JSON.parse(request.body).symbolize_keys[:weather]
    logger.info "API CLIMAS: #{climas}"
    climas.first['main']
  end
end

class MockAPIClimaLluvia
  def initialize; end

  def esta_lloviendo?
    logger.info 'MockAPIClimaLluvia: indica que esta lloviendo'
    true
  end
end

class MockAPIClimaSinLluvia
  def initialize; end

  def esta_lloviendo?
    logger.info 'MockAPISinLluvia: indica que no esta lloviendo'
    false
  end
end
