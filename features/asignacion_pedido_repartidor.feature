#language: es

Característica: Asignación de pedidos a repartidores
  Como encargado del backoffice
  Quiero que el sistema asigne un repartidor al pedido
  Para que el pedido llegue al domicilio del cliente

Antecedentes:
  Dado que el usuario ya esta registrado

Escenario: US9.1 - Asignar repartidor sin pedidos un pedido con menu individual
    Dado que hay un repartidor
    Y no tiene pedidos asignados
    Y hay un pedido con menu individual sin asignar
    Cuando el pedido pasa del estado "En prepracion" a "En camino"
    Entonces se le asigna ese repartidor
    Y el repartidor no sale

Escenario: US9.2 - Asignar repartidor sin pedidos un pedido con menu pareja
    Dado que hay un repartidor
    Y no tiene pedidos asignados
    Y hay un pedido con menu pareja sin asignar
    Cuando el pedido pasa del estado "En prepracion" a "En camino"
    Entonces se le asigna ese repartidor


Escenario: US9.3 - Asignar repartidor sin pedidos un pedido con menu familiar
    Dado que hay un repartidor
    Y no tiene pedidos asignados
    Y hay un pedido con menu familiar sin asignar
    Cuando el pedido pasa del estado "En prepracion" a "En camino"
    Entonces se le asigna ese repartidor
    Y el repartidor sale

@wip
Escenario: US9.4 - Asignar repartidor con dos pedidos con menu individual un pedido con menu individual
    Dado que hay un repartidor
    Y tiene dos pedidos con menu individual asignados
    Y hay un pedido con menu individual sin asignar
    Cuando el pedido pasa del estado "En prepracion" a "En camino"
    Entonces se le asigna ese repartidor
    Y el repartidor sale

@wip
Escenario: US9.6 - Asignar repartidor con un pedido con menu individual un pedido con menu pareja
    Dado que hay un repartidor
    Y tiene un pedido con menu individual asignado
    Y hay un pedido con menu pareja sin asignar
    Cuando el pedido pasa del estado "En prepracion" a "En camino"
    Entonces se le asigna ese repartidor
    Y el repartidor sale

@wip
Escenario: US9.7 - No asignar repartidor con un pedido con menu individual un pedido con menu familiar
    Dado que hay un repartidor
    Y tiene un pedido con menu individual asignado
    Y hay un pedido con menu familiar sin asignar
    Cuando el pedido pasa del estado "En prepracion" a "En camino"
    Entonces no se le asigna ese repartidor

@wip
Escenario: US9.8 - No asignar repartidor con un pedido con menu pareja un pedido con menu familiar
    Dado que hay un repartidor
    Y tiene un pedido con menu pareja asignado
    Y hay un pedido con menu familiar sin asignar
    Cuando el pedido pasa del estado "En prepracion" a "En camino"
    Entonces no se le asigna ese repartidor

@wip
Escenario: US9.9 - No asignar repartidor con un pedido con menu individual un pedido con menu familiar
    Dado que hay un repartidor
    Y tiene un pedido con menu individual asignado
    Y hay un pedido con menu familiar sin asignar
    Cuando el pedido pasa del estado "En prepracion" a "En camino"
    Entonces no se le asigna ese repartidor

@wip
Escenario: US9.10 - No hay repartidores
    Dado que no hay un repartidores
    Y hay un pedido con menu individual sin asignar
    Cuando el pedido pasa del estado "En prepracion" a "En camino"
    Entonces no se le asigna repartidor

@wip
Escenario: US9.11 - Dado 1 repartidor disponible, puede repartir 2 menus familiares secuencialmente
    Dado que hay un repartidor
    Y tiene un pedido con menu familiar asignado
    Y hay un pedido con menu familiar sin asignar
    Cuando el pedido pasa del estado "En prepracion" a "En camino"
    Entonces se le asigna ese repartidor
    Y el repartidor sale
