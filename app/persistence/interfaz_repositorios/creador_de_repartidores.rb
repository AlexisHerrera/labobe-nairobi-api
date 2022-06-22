class CreadorDeRepartidores
  # Es necesario pasarle un repo? Como es de un repartidor, siempre voy a usar RepartidorRepository.
  def initialize(repartidor_repo)
    @repo = repartidor_repo
  end

  def crear_repartidor(nombre, dni, telefono)
    repartidor_a_crear = Repartidor.new(nil, nombre, dni, telefono)

    @repo.save(repartidor_a_crear)
  end
end
