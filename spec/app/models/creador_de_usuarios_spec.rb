require 'spec_helper'

describe 'CreadorDeUsuarios' do
  it 'deberia crear usuario y gurdar en el repositorio' do

    repo = instance_double(Persistence::Repositories::UserRepository)
    usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606')

    expect(repo).to receive(:save).with(usuario).and_return(usuario)
    expect(repo).to receive(:has).with("1234567890").and_return(false)

    nuevo_usuario =   CreadorDeUsuarios.new(repo).crear_usuario('john', '1234567890', 'Paseo Colon 606')
    expect(nuevo_usuario).to eq(usuario)

  end

  it 'no deberia guardar usuario repetido' do

    repo = instance_double(Persistence::Repositories::UserRepository)
    Usuario.new('john', '1234567890', 'Paseo Colon 606')

    expect(repo).to receive(:has).with("1234567890").and_return(true)

    expect{CreadorDeUsuarios.new(repo).crear_usuario('john', '1234567890', 'Paseo Colon 606')}.to raise_error(UsuarioInvalido)

  end
end
