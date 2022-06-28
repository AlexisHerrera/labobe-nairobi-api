
require 'spec_helper'

describe Repartidor do
  context 'Crear un repartidor' do
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

    it 'No deberia ser valido cuando el numero no es numerico' do
      id = 1
      nombre = 'Ying Hu'
      dni = '41199980'
      telefono = '123456789A'
      expect{described_class.new(id, nombre, dni, telefono)}.to raise_error(RepartidorInvalido)
    end

    it 'No deberia ser valido cuando el numero no tiene 10 digitos' do
      id = 1
      nombre = 'Ying Hu'
      dni = '41199980'
      telefono = '12345678901'
      expect{described_class.new(id, nombre, dni, telefono)}.to raise_error(RepartidorInvalido)
    end
    
  end

  context 'Consultar mochila' do

    let(:menu) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::GRANDE)}
    let(:entrega_repo) { Persistence::Repositories::EntregaRepository.new }
    let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
    let(:pedido) { Pedido.new(12367262, usuario, menu, EstadosPosibles::ACEPTADO) }
    
    it 'si un repartidor no tiene ningun pedido, esta vacia' do
      id = 1
      nombre = 'Ying Hu'
      dni = '41199980'
      telefono = '1144449999'
      expect(described_class.new(id, nombre, dni, telefono).tiene_pedidos?).to eq true
    end

    it 'si un repartidor tiene un pedido con menu familiar, la mochila esta llena' do
      id = 1
      nombre = 'Ying Hu'
      dni = '41199980'
      telefono = '1144449999'
      repartidor = described_class.new(id, nombre, dni, telefono)
      repartidor.asignar(pedido)
      expect(repartidor.mochila_llena?).to eq true
    end
    
  end
end
