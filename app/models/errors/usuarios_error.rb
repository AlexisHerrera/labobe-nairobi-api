class InvalidUser < StandardError
end

class UserNotFound < StandardError; end

class UsuarioInvalido < StandardError; end

class UsuarioRegistrado < UsuarioInvalido; end

class TelefonoUtilizado < UsuarioInvalido; end
