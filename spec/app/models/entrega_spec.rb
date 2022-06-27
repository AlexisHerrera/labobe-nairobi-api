require 'spec_helper'

describe Entrega do
  it 'deberia ser valido cuando se crea con un pedido y un repartidor' do
    id = 12367262
    usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')
    menu = MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)
    estado = :Aceptado
    pedido = Pedido.new(id, usuario, menu, estado)

    id = 1
    nombre = 'Ying Hu'
    dni = '41199980'
    telefono = '1144449999'
    repartidor = Repartidor.new(id, nombre, dni, telefono)

    expect(described_class.new(nil, pedido, repartidor).pedido).to eq pedido
  end
end
