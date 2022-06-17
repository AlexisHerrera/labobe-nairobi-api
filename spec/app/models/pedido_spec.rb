require 'spec_helper'

describe Pedido do
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con id, usuario y menu' do
      id = 12367262
      usuario = "0123456789"
      menu = 1
      expect(described_class.new(usuario, menu, id).id).to eq id
    end
  end
end
