require 'spec_helper'

describe EstadoPedido do
  it 'estado se crea con un codigo' do
    # TODO: modelar codigos de estado como enum
    id_estado = 0
    estado = described_class.new(id_estado)
    expect(estado.estado).to eq id_estado
  end

  it 'al cambiar estado de un estadoPedido recien creado este se pasa a 1' do
    # TODO: modelar codigos de estado como enum
    id_estado = 0
    estado = described_class.new(id_estado)
    estado.cambiar_estado
    expect(estado.estado).to eq 1
  end

  it 'al cambiar estado de un estadoPedido en 1 creado este se pasa a 2' do
    # TODO: modelar codigos de estado como enum
    id_estado = 1
    estado = described_class.new(id_estado)
    estado.cambiar_estado
    expect(estado.estado).to eq 2
  end
  it 'al cambiar estado de un estadoPedido en 2 creado este se pasa a 3' do
    # TODO: modelar codigos de estado como enum
    id_estado = 2
    estado = described_class.new(id_estado)
    estado.cambiar_estado
    expect(estado.estado).to eq 3
  end

  it 'al cambiar estado de un estadoPedido en 3 queda 3' do
    # TODO: modelar codigos de estado como enum
    id_estado = 3
    estado = described_class.new(id_estado)
    estado.cambiar_estado
    expect(estado.estado).to eq 3
  end
end
