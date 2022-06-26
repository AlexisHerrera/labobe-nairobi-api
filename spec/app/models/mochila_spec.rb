require 'spec_helper'

describe Mochila do
  it 'deberia ser valido cuando se creo un repartidor' do
    id = 1
    nombre = 'Ying Hu'
    dni = '41199980'
    telefono = '1144449999'
    repartidor = Repartidor.new(id, nombre, dni, telefono)

    expect(described_class.new(repartidor).nil?).to eq false
  end
end
