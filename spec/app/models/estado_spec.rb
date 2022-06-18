require 'spec_helper'

describe Estado do
  it 'codigo 0 es recibido' do
    # TODO: modelar codigos de estado como enum
    codigo_estado = 0
    estado = described_class.new(codigo_estado)
    expect(estado.estado).to eq codigo_estado
  end
end
