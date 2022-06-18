require 'spec_helper'

describe 'CreadorDeEstados' do
  it 'deberia crear un estado y guardar en el repositorio' do
    repo = instance_double(Persistence::Repositories::EstadoRepository).as_null_object
    estado = Estado.new(0, 'En preparacion')

    allow(repo).to receive(:save).with(estado).and_return(estado)

    nuevo_estado = CreadorDeEstados.new(repo).crear_menu(0, 'En preparacion')
    expect(nuevo_estado).to eq(estado)
  end
end
