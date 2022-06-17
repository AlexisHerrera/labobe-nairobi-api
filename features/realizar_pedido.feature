#language: es

Característica: Registrar pedido de un cliente
  Como sistema
  Quiero registrar el pedido de un cliente
  Para que pueda consumir alguno de los menus disponibles

  @wip
  Escenario: Hacer un pedido en el menu
    Dado que soy un cliente registrado
    Cuando recibo un pedido del menu 1 del cliente
    Entonces deberia aceptar su pedido
    Y devolverle el codigo del pedido

  @wip
  Escenario: Hacer un pedido que no esta en el menu
    Dado que soy un cliente registrado
    Cuando recibo un pedido del menu 4 del cliente
    Entonces no deberia aceptar su pedido

