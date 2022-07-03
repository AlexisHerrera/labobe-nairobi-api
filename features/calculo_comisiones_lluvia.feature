#language: es

Característica: Asignación de pedidos a repartidores
  Como encargado del backoffice
  Quiero que el sistema asigne un repartidor al pedido
  Para que el pedido llegue al domicilio del cliente

  Antecedentes:
    Dado que el usuario ya esta registrado
    Dado que hay un repartidor
    Dado que llueve

    Escenario: 12.0 - Configura el sistema para que crea que esta lloviendo
      Dado que configuro el sistema para que crea que esta lloviendo
      Cuando consulto el clima
      Entonces el sistema cree que esta lloviendo

    Escenario: 12.1 - Comisión para un repartidor sobre un menú Individual con calificación mala y con lluvia
      Dado que un repartidor repartió un menú Individual y fue calificado con calificación "mala"
      Y llovió durante la entrega del pedido
      Cuando calculo su comisión
      Entonces esta será del 4% del valor del pedido individual

    Escenario: 12.2 - Comisión para un repartidor sobre un menú Pareja con calificación mala y con lluvia
      Dado que un repartidor repartió un menú Pareja y fue calificado con calificación "mala"
      Y llovió durante la entrega del pedido
      Cuando calculo su comisión
      Entonces esta será del 4% del valor del pedido pareja

    Escenario: 12.3 - Comisión para un repartidor sobre un menú Familiar con calificación mala y con lluvia
      Dado que un repartidor repartió un menú Familiar y fue calificado con calificación "mala"
      Y llovió durante la entrega del pedido
      Cuando calculo su comisión
      Entonces esta será del 4% del valor del pedido familiar

    Escenario: 12.4 - Comisión para un repartidor sobre un menú Individual con calificación buena y con lluvia
      Dado que un repartidor repartió un menú Individual y fue calificado con calificación "buena"
      Y llovió durante la entrega del pedido
      Cuando calculo su comisión
      Entonces esta será del 6% del valor del pedido individual

    Escenario: 12.5 - Comisión para un repartidor sobre un menú Pareja con calificación buena y con lluvia
      Dado que un repartidor repartió un menú Pareja y fue calificado con calificación "buena"
      Y llovió durante la entrega del pedido
      Cuando calculo su comisión
      Entonces esta será del 6% del valor del pedido pareja

    Escenario: 12.6 - Comisión para un repartidor sobre un menú Familiar con calificación buena y con lluvia
      Dado que un repartidor repartió un menú Familiar y fue calificado con calificación "buena"
      Y llovió durante la entrega del pedido
      Cuando calculo su comisión
      Entonces esta será del 6% del valor del pedido familiar

    Escenario: 12.7 - Comisión para un repartidor sobre un menú Individual con calificación excelente y con lluvia
      Dado que un repartidor repartió un menú Individual y fue calificado con calificación "excelente"
      Y llovió durante la entrega del pedido
      Cuando calculo su comisión
      Entonces esta será del 8% del valor del pedido individual

    Escenario: 12.8 - Comisión para un repartidor sobre un menú Pareja con calificación excelente y con lluvia
      Dado que un repartidor repartió un menú Pareja y fue calificado con calificación "excelente"
      Y llovió durante la entrega del pedido
      Cuando calculo su comisión
      Entonces esta será del 8% del valor del pedido pareja

    Escenario: 12.9 - Comisión para un repartidor sobre un menú Familiar con calificación excelente y con lluvia
      Dado que un repartidor repartió un menú Familiar y fue calificado con calificación "excelente"
      Y llovió durante la entrega del pedido
      Cuando calculo su comisión
      Entonces esta será del 8% del valor del pedido familiar
