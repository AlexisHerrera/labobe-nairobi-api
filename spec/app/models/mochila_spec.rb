require 'spec_helper'

describe Mochila do
  it 'deberia ser valido cuando se crea una mochila con un repartidor' do
    id = 1
    nombre = 'Ying Hu'
    dni = '41199980'
    telefono = '1144449999'
    repartidor = Repartidor.new(id, nombre, dni, telefono)

    expect(described_class.new(repartidor).nil?).to eq false
  end

  it 'deberia no estar llena una mochila recien creada' do
    id = 1
    nombre = 'Ying Hu'
    dni = '41199980'
    telefono = '1144449999'
    repartidor = Repartidor.new(id, nombre, dni, telefono)

    mochila = described_class.new(repartidor)

    expect(mochila.esta_vacia?).to eq true
    expect(mochila.esta_llena?).to eq false
  end

end
