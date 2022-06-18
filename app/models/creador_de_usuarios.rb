class CreadorDeUsuarios
  def initialize(user_repo)
    @repo = user_repo
  end

  def crear_usuario(nombre, telefono, direccion, id_telegram)
    usuario_a_crear = Usuario.new(nombre, telefono, direccion, id_telegram)
    raise UsuarioRegistrado if @repo.has(id_telegram)
    raise TelefonoUtilizado if @repo.has_telefono(telefono)

    @repo.save(usuario_a_crear)
  end
end
