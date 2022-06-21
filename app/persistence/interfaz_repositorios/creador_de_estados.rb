class CreadorDeEstados
  # TODO: Esto no se utiliza nunca, no esta mal. Se puede eliminar (junto con sus tests)?
  def initialize(estado_repo)
    @repo = estado_repo
  end

  def crear_estado(id, descripcion)
    estado_a_crear = EstadoDTO.new(id, descripcion)
    @repo.save(estado_a_crear)
  end
end
