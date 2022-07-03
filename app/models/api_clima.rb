class APIClima
  # TODO: Poner loggers en la API
  def initialize(token)
    @token = token
  end

  def esta_lloviendo?
    request = Faraday.get("https://api.openweathermap.org/data/2.5/weather?lat=-34.36&lon=-58.26&appid=#{@token}")
    body = request.body
    JSON.parse(body).symbolize_keys[:weather].first['main'] == 'Rain'
  end
end

class MockAPIClimaLluvia
  def initialize; end

  def esta_lloviendo?
    true
  end
end

class MockAPIClimaSinLLuvia
  def initialize; end

  def esta_lloviendo?
    false
  end
end
