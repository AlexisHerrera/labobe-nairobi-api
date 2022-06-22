
require 'spec_helper'

describe Repartidor do
  it 'deberia ser valido cuando se crea con nombre, dni y telefonos con formato correcto' do
    nombre = 'Ying Hu'
    dni = '41199980'
    telefono = '1144449999'
    id = 1
    expect(described_class.new(id, nombre, dni, telefono).nombre).to eq 'Ying Hu'
  end
end
