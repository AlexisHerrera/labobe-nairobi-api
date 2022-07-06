#language: es

Característica: Estado de un pedido
  Como admin
  Quiero modificar el estado de un pedido
  Para que el cliente sepa como esta

Antecedentes:
  Dado que el usuario ya esta registrado
  Dado que hay un repartidor

Escenario: 7.0 - Estado de un pedido recien creado es Aceptado
  Cuando creo un pedido
  Entonces el pedido esta "Aceptado"

Escenario: 7.1 - Estado de un pedido de Aceptado a en preparacion
  Dado que tengo un pedido con menu grande
  Cuando cambio el estado del pedido
  Entonces el pedido esta "En preparacion"

Escenario: 7.2 - Estado de un pedido de en preparacion a en camino
  Dado que tengo un pedido con menu mediano
  Y esta En preparacion
  Cuando cambio el estado del pedido
  Entonces el pedido esta "En camino"

Escenario: 7.3 - Estado de un pedido de en camino a entregado
  Dado que tengo un pedido con menu grande
  Y esta En camino
  Cuando cambio el estado del pedido
  Entonces el pedido esta "Entregado"

Escenario: 7.4 - Estado de un pedido entregado
  Dado que tengo un pedido con menu grande
  Y esta Entregado
  Cuando cambio el estado del pedido
  Entonces el pedido esta "Entregado"

Escenario: 6.2 - Consultar el estado de un pedido con un código inválido
  Dado que tengo un pedido con menu grande
  Cuando consulto el estado de un pedido inexistente
  Entonces recibo un codigo de error

Escenario: US6.3 - Consultar el estado de un pedido que no es mio
    Dado que tengo un pedido con menu grande
    Y yo estoy registrado con otra cuenta
    Cuando consulto el estado de ese pedido con otro usuario
    Entonces recibo un mensaje con un error de pedido que no me pertenece

