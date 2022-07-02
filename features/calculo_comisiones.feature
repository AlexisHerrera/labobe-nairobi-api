#language: es

Característica: Calculo de comisiones
  Como encargado del backoffice
  Quiero que el sistema me devuelva las comisiones de un repartidor
  Para poder pagarele


Antecedentes:
  Dado que el usuario ya esta registrado
  Dado que hay un repartidor

@local
Escenario: 11.1 - Comisión para un repartidor sobre un menú Individual con calificación mala
  Dado que un repartidor repartió un menú Individual y fue calificado con calificación "mala"
  Cuando calculo su comisión
  Entonces esta será del 3% del valor del pedido individual

@local
Escenario: 11.2 - Comisión para un repartidor sobre un menú Pareja con calificación mala
  Dado que un repartidor repartió un menú Pareja y fue calificado con calificación "mala"
  Cuando calculo su comisión
  Entonces esta será del 3% del valor del pedido pareja

Escenario: 11.3 - Comisión para un repartidor sobre un menú Familiar con calificación mala
  Dado que un repartidor repartió un menú Familiar y fue calificado con calificación "mala"
  Cuando calculo su comisión
  Entonces esta será del 3% del valor del pedido familiar

@local
Escenario: 11.4 - Comisión para un repartidor sobre un menú Individual con calificación buena
  Dado que un repartidor repartió un menú Individual y fue calificado con calificación "buena"
  Cuando calculo su comisión
  Entonces esta será del 5% del valor del pedido individual

@local
Escenario: 11.5 - Comisión para un repartidor sobre un menú Pareja con calificación buena
  Dado que un repartidor repartió un menú Pareja y fue calificado con calificación "buena"
  Cuando calculo su comisión
  Entonces esta será del 5% del valor del pedido pareja

Escenario: 11.6 - Comisión para un repartidor sobre un menú Familiar con calificación buena
  Dado que un repartidor repartió un menú Familiar y fue calificado con calificación "buena"
  Cuando calculo su comisión
  Entonces esta será del 5% del valor del pedido familiar

@local
Escenario: 11.8 - Comisión para un repartidor sobre un menú Pareja con calificación excelente
  Dado que un repartidor repartió un menú Pareja y fue calificado con calificación "excelente"
  Cuando calculo su comisión
  Entonces esta será del 7% del valor del pedido pareja

Escenario: 11.9 - Comisión para un repartidor sobre un menú Familiar con calificación excelente
  Dado que un repartidor repartió un menú Familiar y fue calificado con calificación "excelente"
  Cuando calculo su comisión
  Entonces esta será del 7% del valor del pedido familiar

Escenario: 11.10 - Comisión para un repartidor sobre 3 menus individuales con 3 calificaciones diferentes
  Dado que un repartidor repartió 3 menus individuales calificados
  Cuando calculo su comisión
  Entonces esta será del del valor 150

Escenario: 11.11 - Comisión para un repartidor inexistente
  Cuando calculo la comisión de un repartidor inexistente
  Entonces no tendra comision y lanzara error
