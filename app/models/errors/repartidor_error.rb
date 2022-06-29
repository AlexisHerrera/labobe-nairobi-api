class RepartidorInvalido < StandardError; end

class NoHayRepartidores < StandardError; end

class DniEnUso < RepartidorInvalido; end
