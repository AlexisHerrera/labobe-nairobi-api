class APIClima
  # TODO: Poner loggers en la API
  def initialize(token)
    @token = token
  end

  def esta_lloviendo?
    request = Faraday.get("https://api.openweathermap.org/data/2.5/weather?lat=-34.36&lon=-58.26&appid=#{@token}")
    # TODO: Sacar ASAP, es solo para que pueda preguntar en la lista:
    return false if request.status == 404

    body = request.body
    JSON.parse(body).symbolize_keys[:weather].first['main'] == 'Rain'
  end
end
