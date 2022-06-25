require 'spec_helper'

describe Entrega do
  it 'deberia ser valido cuando se crea con un pedido y un repartidor' do
    id = 12367262
    usuario = '123'
    menu = 1
    id_estado = 0
    pedido = Pedido.new(id, usuario, menu, id_estado)

    id = 1
    nombre = 'Ying Hu'
    dni = '41199980'
    telefono = '1144449999'
    repartidor = Repartidor.new(id, nombre, dni, telefono)

    expect(described_class.new(nil, pedido, repartidor).pedido).to eq pedido
  end
end
