require 'spec_helper'

describe 'CreadorDeUsuarios' do
  it 'should create save and notify observer' do

    repo = instance_double(Persistence::Repositories::UserRepository)
    usuario = Usuario.new('john', '2222222', 'Paseo Colon 606')

    expect(repo).to receive(:save).with(usuario).and_return(usuario)

    nuevo_usuario =   CreadorDeUsuarios.new(repo).crear_usuario('john', '2222222', 'Paseo Colon 606')
    expect(nuevo_usuario).to eq(usuario)

  end
end
