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

    it 'cuando se modifica el estado de un pedido con estado 1, el estado es 2' do
      id = 12367262
      usuario = '123'
      menu = 1
      id_estado = 1
      pedido = described_class.new(id, usuario, menu, id_estado)
      pedido.cambiar_estado
      expect(pedido.estado.estado).to eq 2
    end

    it 'cuando se modifica el estado de un pedido con estado 2, el estado es 3' do
      id = 12367262
      usuario = '123'
      menu = 1
      id_estado = 2
      pedido = described_class.new(id, usuario, menu, id_estado)
      pedido.cambiar_estado
      expect(pedido.estado.estado).to eq 3
    end

    it 'cuando se modifica el estado de un pedido con estado 3, el estado es 3' do
      id = 12367262
      usuario = '123'
      menu = 1
      id_estado = 3
      pedido = described_class.new(id, usuario, menu, id_estado)
      pedido.cambiar_estado
      expect(pedido.estado.estado).to eq 3
    end

    it 'cuando se consulta el estado de un pedido con un id_usuario diferente lanza excepcion' do
      id = 12367262
      usuario = '123'
      menu = 1
      id_estado = 3
      pedido = described_class.new(id, usuario, menu, id_estado)
      id_usuario_diferente = '9999'
      expect { pedido.consultar(id_usuario_diferente) }.to raise_error(UsuarioInvalido)
    end

    it 'cuando se consulta si el estado es "en camino" y es "en camino" devuelve true' do
      id = 12367262
      usuario = '123'
      menu = 1
      id_estado = 2
      pedido = described_class.new(id, usuario, menu, id_estado)
      expect(pedido.esta_en_camino?).to eq true
    end
  end
end
