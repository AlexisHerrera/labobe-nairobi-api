require 'spec_helper'

describe 'CreadorDeEstados' do
  it 'deberia crear un estado y guardar en el repositorio' do
    repo = instance_double(Persistence::Repositories::EstadoRepository).as_null_object
    estado = EstadoDTO.new(0, 'En preparacion')

    allow(repo).to receive(:save).with(estado).and_return(estado)

    nuevo_estado = CreadorDeEstados.new(repo).crear_estado(0, 'En preparacion')
    expect(nuevo_estado==estado).to eq(true)
  end
end
