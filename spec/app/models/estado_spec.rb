require 'spec_helper'

describe EstadoPedido do
  it 'estado se crea con un codigo' do
    # TODO: modelar codigos de estado como enum
    id_estado = 0
    estado = described_class.new(id_estado)
    expect(estado.estado).to eq id_estado
  end
end
