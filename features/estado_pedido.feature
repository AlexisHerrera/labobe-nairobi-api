#language: es

Característica: Estado de un pedido
  Como admin
  Quiero modificar el estado de un pedido
  Para que el cliente sepa como esta

Antecedentes:
  Dado que el usuario ya esta registrado

Escenario: 7.0 - Estado de un pedido recien creado es recibido
  Cuando creo un pedido
  Entonces el pedido esta "Recibido"

@wip
Escenario: 7.1 - Estado de un pedido de recibido a en preparacion
  Dado que tengo un pedido "Recibido"
  Cuando cambio el estado del pedido
  Entonces el pedido esta "En preparacion"

@wip
Escenario: 7.2 - Estado de un pedido de en preparacion a en camino
  Dado que tengo un pedido "En preparacion"
  Cuando cambio el estado del pedido
  Entonces el pedido esta "En camino"

@wip
Escenario: 7.3 - Estado de un pedido de en camino a entregado
  Dado que tengo un pedido "En camino"
  Cuando cambio el estado del pedido
  Entonces el pedido esta "Entregado"

@wip
Escenario: 7.4 - Estado de un pedido entregado
  Dado que tengo un pedido "Entregado"
  Cuando cambio el estado del pedido
  Entonces el pedido esta "Entregado"
