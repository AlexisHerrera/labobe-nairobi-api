class CreadorDeEstados
  def initialize(estado_repo)
    @repo = estado_repo
  end

  def crear_estado(id, descripcion)
    estado_a_crear = Estado.new(id, descripcion)
    @repo.save(estado_a_crear)
  end
end
