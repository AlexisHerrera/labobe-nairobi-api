require 'spec_helper'

describe Pedido do
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con id, usuario, menu y estado' do
      id = 12367262
      usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')
      menu = MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)
      estado = EstadosPosibles::ACEPTADO
      expect(described_class.new(id, usuario, menu, estado).id).to eq id
    end

    it 'cuando se modifica el estado de un pedido recien creado, el estado es 1' do
      id = 12367262
      usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')
      menu = MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)
      estado = EstadosPosibles::ACEPTADO
      pedido = described_class.new(id, usuario, menu, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEnPreparacion.new
    end

    it 'cuando se modifica el estado de un pedido con estado 1, el estado es 2' do
      id = 12367262
      usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')
      menu = MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)
      estado = EstadosPosibles::PREPARACION
      pedido = described_class.new(id, usuario, menu, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEnCamino.new
    end

    it 'cuando se modifica el estado de un pedido con estado 2, el estado es 3' do
      id = 12367262
      usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')
      menu = MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)
      estado = EstadosPosibles::CAMINO
      pedido = described_class.new(id, usuario, menu, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEntregado.new
    end

    it 'cuando se modifica el estado de un pedido con estado 3, el estado es 3' do
      id = 12367262
      usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')
      menu = MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(id, usuario, menu, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEntregado.new
    end

    it 'cuando se consulta el estado de un pedido con un id_usuario diferente lanza excepcion' do
      id = 12367262
      usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')
      menu = MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(id, usuario, menu, estado)
      id_usuario_diferente = '9999'
      expect { pedido.consultar(id_usuario_diferente) }.to raise_error(UsuarioInvalido)
    end

    it 'cuando se consulta si el estado es "en preparacion" y es "en preparacion" devuelve true' do
      id = 12367262
      usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')
      menu = MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)
      estado = EstadosPosibles::PREPARACION
      pedido = described_class.new(id, usuario, menu, estado)
      expect(pedido.esta_en_preparacion?).to eq true
    end
  end
end
