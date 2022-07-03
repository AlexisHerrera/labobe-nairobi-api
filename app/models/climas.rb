class DiaLluvioso
  def llueve?
    true
  end
end

class DiaSinLluvia
  def llueve?
    false
  end
end

class DiasPosibles
  LLUVIA = :lluvia
  SIN_LLUVIA = :sin_lluvia
end

class DiaFactory
  def initialize
    @proveedor_clima = obtener_proveedor_clima
  end

  def obtener_dia
    return DiaLluvioso.new if @proveedor_clima.esta_lloviendo?

    DiaSinLluvia.new
  end

  def obtener_proveedor_clima
    return MockAPIClimaLluvia.new if ENV['MOCK_CLIMA'] == DiasPosibles::LLUVIA.to_s
    return MockAPIClimaSinLLuvia.new if ENV['MOCK_CLIMA'] == DiasPosibles::SIN_LLUVIA.to_s

    APIClima.new(ENV['TOKEN_API_CLIMA'])
  end
end
