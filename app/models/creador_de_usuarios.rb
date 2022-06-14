class CreadorDeUsuarios
  def initialize(user_repo)
    @repo = user_repo
  end

  def crear_usuario(nombre, telefono, direccion)
    user = Usuario.new(nombre, telefono, direccion)

    raise UsuarioRepetido if @repo.has(telefono)

    @repo.save(user)
  end
end
