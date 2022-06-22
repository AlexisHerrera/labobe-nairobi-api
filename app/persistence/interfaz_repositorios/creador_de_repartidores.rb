class CreadorDeRepartidores
  def initialize(repartidor_repo)
    @repo = repartidor_repo
  end

  def crear_repartidor(nombre, dni, telefono)
    repartidor_a_crear = Repartidor.new(nil, nombre, dni, telefono)

    @repo.save(repartidor_a_crear)
  end
end
