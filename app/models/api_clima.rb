require 'faraday'

class APIClima
  attr_reader :url

  def initialize(url)
    @url = url
    logger.info "Se utiliza la url #{url}"
  end

  def esta_lloviendo?
    begin
      esta_lloviendo = obtener_clima == 'Rain'
    rescue APIError
      # Por disenio si el sistema de clima no funciona, se asume que no esta lloviendo.
      return false
    end

    logger.info 'La API indica que esta lloviendo' if esta_lloviendo
    logger.info 'La API indica que no esta lloviendo'
    esta_lloviendo
  end

  private

  def obtener_clima
    request = Faraday.get(url)
    if request.status != 200
      logger.error "No se pudo obtener el clima de la API: #{request}"
      raise APIError
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
