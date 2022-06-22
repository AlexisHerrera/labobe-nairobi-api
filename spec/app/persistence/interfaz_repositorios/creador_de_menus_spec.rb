require 'spec_helper'

describe 'CreadorDeMenu' do
  it 'deberia crear menu y guardar en el repositorio' do
    repo = instance_double(Persistence::Repositories::MenuRepository).as_null_object
    menu = Menu.new(11, 'Menu pareja', 1500)

    allow(repo).to receive(:save).with(menu).and_return(menu)

    nuevo_menu = CreadorDeMenus.new(repo).crear_menu(11, 'Menu pareja', 1500)
    expect(nuevo_menu==menu).to eq(true)
  end
end
