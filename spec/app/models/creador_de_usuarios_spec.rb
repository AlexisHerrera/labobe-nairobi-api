require 'spec_helper'

describe 'CreadorDeUsuarios' do
  it 'deberia crear usuario y guardar en el repositorio' do

    repo = instance_double(Persistence::Repositories::UsuarioRepository).as_null_object
    usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')

    expect(repo).to receive(:save).with(usuario).and_return(usuario)
    expect(repo).to receive(:has).with("1234567890").and_return(false)
    expect(repo).to receive(:has_telegram_id).with("123").and_return(false)

    nuevo_usuario = CreadorDeUsuarios.new(repo).crear_usuario('john', '1234567890', 'Paseo Colon 606', '123')
    expect(nuevo_usuario).to eq(usuario)

  end

  it 'no deberia guardar un numero que ya esta en uso' do

    repo = instance_double(Persistence::Repositories::UsuarioRepository).as_null_object
    usuario = Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')

    expect(repo).to receive(:has).with("1234567890").and_return(true)
    expect(repo).to receive(:has_telegram_id).with('123').and_return(false)

    expect{CreadorDeUsuarios.new(repo).crear_usuario('john', '1234567890', 'Paseo Colon 606', '123')}.to raise_error(TelefonoUtilizado)

  end
end
