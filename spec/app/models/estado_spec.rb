require 'spec_helper'

describe EstadoPedido do

  it 'al cambiar estado de un estadoAceptado se pasa a estadoEnPreparacion' do
    estado = EstadoAceptado.new
    estado = estado.siguiente_estado
    expect(estado).to eq EstadoEnPreparacion.new
  end

  it 'al cambiar estado de un estadoEnPreparacion se pasa a estadoEnCamino' do
    estado = EstadoEnPreparacion.new
    estado = estado.siguiente_estado
    expect(estado).to eq EstadoEnCamino.new
  end
  it 'al cambiar estado de un estadoEnCamino se pasa a estadoEntregado' do
    estado = EstadoEnCamino.new
    estado = estado.siguiente_estado
    expect(estado).to eq EstadoEntregado.new
  end

  it 'al cambiar estado de un estadoEntregado queda estadoEntregado' do
    estado = EstadoEntregado.new
    estado = estado.siguiente_estado
    expect(estado).to eq EstadoEntregado.new
  end

  it 'cuando se consulta si el estado es "en preparacion" y es "en preparacion" devuelve true' do
    estado = EstadoEnPreparacion.new
    expect(estado.esta_en_preparacion?).to eq true
  end

  it 'el estado conoce a que pedido pertenece' do
    usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')
    menu = MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)
    pedido = Pedido.new(1, usuario, menu, EstadosPosibles::ACEPTADO)
    estado = EstadoAceptado.new(pedido)
    expect(estado.pedido).to eq pedido
  end
end
