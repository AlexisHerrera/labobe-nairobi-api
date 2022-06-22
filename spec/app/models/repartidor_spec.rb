
require 'spec_helper'

describe Repartidor do
  it 'deberia ser valido cuando se crea con nombre, dni y telefonos con formato correcto' do
    id = 1
    nombre = 'Ying Hu'
    dni = '41199980'
    telefono = '1144449999'
    expect(described_class.new(id, nombre, dni, telefono).nombre).to eq 'Ying Hu'
  end

  it 'No deberia ser valido cuando tiene un nombre menor a 5 caracteres' do
    id = 1
    nombre = 'Yi Hu'
    dni = '41199980'
    telefono = '1144449999'
    expect{described_class.new(id, nombre, dni, telefono)}.to raise_error(RepartidorInvalido)
  end

  it 'No deberia ser valido cuando tiene un nombre mayor a 20 caracteres' do
    id = 1
    nombre = 'Ying HuHaHeHeHeHUHAHUHAHHAHAHAHAHAHHAHA'
    dni = '41199980'
    telefono = '1144449999'
    expect{described_class.new(id, nombre, dni, telefono)}.to raise_error(RepartidorInvalido)
  end
end
