require 'spec_helper'

describe Pedido do
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con id, usuario y menu' do
      id = 12367262
      usuario = '123'
      menu = 1
      expect(described_class.new(usuario, menu, id).id).to eq id
    end

    xit 'tiene estado recibido' do
      id = 12367262
      usuario = '123'
      menu = 1
      expect(described_class.new(usuario, menu, id).estado).to eq estado
    end
  end
end
