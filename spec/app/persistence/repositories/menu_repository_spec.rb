require 'integration_helper'

describe Persistence::Repositories::MenuRepository do
  let(:menu_repo) { Persistence::Repositories::MenuRepository.new }
  let(:a_menu) { Menu.new(1, "Menu pareja", 1400) }

  it 'deberia guardar un nuevo menu' do
    menu_repo.save(a_menu)
    expect(menu_repo.all.count).to eq(1)
  end

  it 'el nuevo menu deberia tener un precio' do
    new_user = menu_repo.save(a_menu)
    expect(new_user.precio).to be_present
  end

  context 'cuando un menu existe' do
    before :each do
      @nuevo_menu = menu_repo.save(a_menu)
      @menu_id = @nuevo_menu.id
    end

    it 'deberia borrar todos los usuarios' do
      menu_repo.delete_all

      expect(menu_repo.all.count).to eq(0)
    end

    it 'deberia encontrar el usuario por id' do
      menu = menu_repo.find(@menu_id)

      expect(menu.precio).to eq(@nuevo_menu.precio)
    end
  end

  it 'deberia lanzar un error al buscar un menu no existente' do
    expect do
      menu_repo.find(99_999)
    end.to raise_error(ObjectNotFound)
  end
end
