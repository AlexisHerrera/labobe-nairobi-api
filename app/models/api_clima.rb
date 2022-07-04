class APIClima
  def initialize(token)
    @token = token
    logger.info "Se utiliza el token #{token}"
  end

  def esta_lloviendo?
    request = Faraday.get("https://api.openweathermap.org/data/2.5/weather?lat=-34.36&lon=-58.26&appid=#{@token}")
    body = request.body
    esta_lloviendo = parsear_clima(body) == 'Rain'
    logger.info 'La API indica que esta lloviendo' if esta_lloviendo
    logger.info 'La API indica que no esta lloviendo'
    esta_lloviendo
  end

  private

  def parsear_clima(body)
    climas = JSON.parse(body).symbolize_keys[:weather]
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
