#language: es

Característica: Registración de usuarios
  Como usuario
  Quiero poder registrarme
  Para poder realizar un pedido

Escenario: 01 - Registro exitoso
   Dado que un usuario se quiere registrar
   Cuando recibo un usuario con nombre "Juan", teléfono "1144449999" y dirección "Av. Paseo Colón 850"
   Entonces el usuario queda registrado con teléfono "1144449999"
