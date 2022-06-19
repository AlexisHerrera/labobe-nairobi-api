require 'spec_helper'

describe Pedido do
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con id, usuario, menu y estado' do
      id = 12367262
      usuario = '123'
      menu = 1
      id_estado = 0
      expect(described_class.new(id, usuario, menu, id_estado).id).to eq id
    end

    it 'cuando se crea tiene estado recibido' do
      id = 12367262
      usuario = '123'
      menu = 1
      id_estado = 0
      expect(described_class.new(id, usuario, menu, id_estado).estado.estado).to eq id_estado
    end

    it 'cuando se modifica el estado de un pedido recien creado, el estado es 1' do
      id = 12367262
      usuario = '123'
      menu = 1
      id_estado = 0
      pedido = described_class.new(id, usuario, menu, id_estado)
      pedido.cambiar_estado
      expect(pedido.estado.estado).to eq 1
    end
  end
end
