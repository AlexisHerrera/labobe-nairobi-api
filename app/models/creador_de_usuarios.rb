class CreadorDeUsuarios
  def initialize(user_repo)
    @repo = user_repo
  end

  def crear_usuario(nombre, telefono, direccion)
    user = Usuario.new(nombre, telefono, direccion)
    @repo.save(user)
  end
end
