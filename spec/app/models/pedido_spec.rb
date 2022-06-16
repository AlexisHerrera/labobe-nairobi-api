require 'spec_helper'

describe Pedido do
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con id, usuario y menu' do
      id = 12367262
      usuario = Usuario.new("Ana", "0123456789", "Paseo Colon 859","123")
      menu = Menu.new(1, "Menu pareja", 1500)
      expect(described_class.new(id, usuario, menu).id).to eq id
    end
  end
end