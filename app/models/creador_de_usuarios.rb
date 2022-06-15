class CreadorDeUsuarios
  def initialize(user_repo)
    @repo = user_repo
  end

  def crear_usuario(nombre, telefono, direccion, id_telegram)
    user = Usuario.new(nombre, telefono, direccion, id_telegram)

    raise UsuarioRepetido if @repo.has(telefono)

    @repo.save(user)
  end
end
