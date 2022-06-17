#language: es

Característica: Registración de usuarios
  Como sistema
  Quiero impedir que un usuario registrado se vuelva a registrar
  Para que mas usuarios deban registrarse

Escenario: 01 - Un usuario registrado no se puede registrar de nuevo
  Dado que el usuario ya esta registrado
  Cuando recibo un pedido de registracion del mismo usuario registrado
  Entonces le respondo que el usuario ya esta registrado
