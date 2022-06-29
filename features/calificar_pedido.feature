#language: es

Característica: Usuario califica pedido
  Como usuario
  Quiero calificar el pedido
  Para poder expresar mi satisfacion con el pedido

Antecedentes:
  Dado que el usuario ya esta registrado
  Dado que hay un repartidor
  Dado tiene un pedido con menu individual asignado

Escenario: US10.1 - Calificacion exitosa
   Dado que un pedido del cliente esta entregado
   Cuando quiero calificar un pedido como excelente
   Entonces la calificacion queda registrada

Escenario: US10.2 - Calificacion de un pedido inexistente
   Cuando califico un pedido inexistente
   Entonces la calificacion no queda registrada porque no existe el cliente

Escenario: US10.3 - Calificacion de un pedido con un valor que excede el rango
   Dado que un pedido del cliente esta entregado
   Cuando quiero calificar un pedido con un valor que excede el rango
   Entonces la calificacion no queda registrada

Escenario: US10.4 - Calificacion de un pedido con un valor que es inferior al rango
   Dado que un pedido del cliente esta entregado
   Cuando quiero calificar un pedido con un valor que es inferior al rango
   Entonces la calificacion no queda registrada

@wip
Escenario: US10.5 - Calificacion de un pedido con un valor no numerico
   Dado que un pedido del cliente esta entregado
   Cuando quiero calificar un pedido con un valor no numerico
   Entonces la calificacion no queda registrada

@wip
Escenario: US10.6 - Calificacion de un pedido que no esta entregado
   Dado que un pedido del cliente esta en preparacion
   Cuando quiero calificar un pedido como excelente
   Entonces la calificacion no queda registrada

@wip
Escenario: US10.7 - Calificacion de un pedido que no es del cliente que lo pidio
   Dado que un pedido que no es del cliente esta entregado
   Cuando quiero calificar un pedido que no es del cliente como excelente
   Entonces la calificacion no queda registrada porque no es su pedido
