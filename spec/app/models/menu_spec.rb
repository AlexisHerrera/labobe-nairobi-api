require 'spec_helper'

describe Menu do
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con id, descripcion y precio' do
      id = 1
      descripcion = 'Menu Pareja'
      precio = 1500
      expect(described_class.new(id, descripcion, precio).descripcion).to eq descripcion
    end
  end
end