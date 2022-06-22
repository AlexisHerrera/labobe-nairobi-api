#language: es

Característica: Registración de repartidor
  Como encargado del delivery
  Quiero poder registrar repartidores
  Para que puedan empezar a entregar pedidos

  @wip
  Escenario: US8.1 - Registro de repartidor exitoso
    Dado que quiero registrar un repartidor
    Cuando intento registrar a "Ying Hu" con dni "41199980" y numero de telefono "1144449999"
    Entonces el repartidor esta registrado

  @wip
  Escenario: US8.2 - Registro de repartidor invalido por nombre corto
    Dado que quiero registrar un repartidor
    Cuando intento registrar a "Yi Hu" con dni "41199980" y numero de telefono "1144449999"
    Entonces el repartidor no se registra
    Y recibo el mensaje de error


  @wip
  Escenario: US8.3 - Registro de repartidor invalido por nombre largo
    Dado que quiero registrar un repartidor
    Cuando intento registrar a "Ying HuHaHeHeHeHUHAHUHAHHAHAHAHAHAHHAHA" con dni "41199980" y numero de telefono "1144449999"
    Entonces el repartidor no se registra
    Y recibo el mensaje de error

  @wip
  Escenario: US8.4 - Registro de repartidor invalido por DNI repetido
    Dado que quiero registrar un repartidor
    Y hay un repartidor con dni "41199980" registrado
    Cuando intento registrar a "Ying Hu" con dni "41199980" y numero de telefono "1144449999"
    Entonces el repartidor no se registra
    Y recibo el mensaje de error
