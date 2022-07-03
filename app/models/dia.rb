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

class DiaFactory
  def initialize(api_clima)
    @api_clima = api_clima
  end

  def obtener_dia
    return DiaLluvioso.new if @api_clima.esta_lloviendo?

    DiaSinLluvia.new
  end
end
