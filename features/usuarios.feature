#language: es

Característica: Registración de usuarios
  Como usuario
  Quiero poder registrarme
  Para poder realizar un pedido

Escenario: 01 - Registro exitoso
   Dado que un usuario se quiere registrar
   Cuando recibo un usuario con nombre "Juan", teléfono "1144449999" y dirección "Av. Paseo Colón 850"
   Entonces el usuario queda registrado con teléfono "1144449999"

Escenario: 02 - Registro denegado por numero corto
   Dado que un usuario se quiere registrar
   Cuando recibo un usuario con nombre "Juan", teléfono "123" y dirección "Av. Paseo Colón 850"
   Entonces el usuario no queda registrado

Escenario: 03 - Registro sin exito, numero largo
   Dado que un usuario se quiere registrar
   Cuando recibo un usuario con nombre "Juan", teléfono "11444499990000" y dirección "Av. Paseo Colón 850"
   Entonces el usuario no queda registrado

Escenario: 04 - Registro sin exito, el número ingresado no es un valor númerico
   Dado que un usuario se quiere registrar
   Cuando recibo un usuario con nombre "Juan", teléfono "Perez" y dirección "Av. Paseo Colón 850"
   Entonces el usuario no queda registrado

Escenario: 05 - Registro sin exito, el número ingresado es vacío
   Dado que un usuario se quiere registrar
   Cuando recibo un usuario con nombre "Juan", teléfono "" y dirección "Av. Paseo Colón 850"
   Entonces el usuario no queda registrado

Escenario: 06 - Registro sin exito, el nombre ingresado tiene números o caracteres especiales
   Dado que un usuario se quiere registrar
   Cuando recibo un usuario con nombre "1J23", teléfono "1144449999" y dirección "Av. Paseo Colón 850"
   Entonces el usuario no queda registrado
