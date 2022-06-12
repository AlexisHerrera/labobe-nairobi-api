require 'integration_helper'

describe Persistence::Repositories::UserRepository do
  let(:user_repo) { Persistence::Repositories::UserRepository.new }
  let(:a_user) { Usuario.new('Juan', '1144449999', 'Av. Paseo Colón 850') }

  it 'deberia guardar un nuevo usuario' do
    user_repo.save(a_user)
    expect(user_repo.all.count).to eq(1)
  end

  it 'el nuevo usuario deberia tener un telefono' do
    new_user = user_repo.save(a_user)
    expect(new_user.telefono).to be_present
  end

  context 'cuando un usuario existe' do
    before :each do
      @new_user = user_repo.save(a_user)
      @user_id = @new_user.telefono
    end

    it 'deberia borrar todos los usuarios' do
      user_repo.delete_all

      expect(user_repo.all.count).to eq(0)
    end

    xit 'deberia encontrar el usuario por telefono' do
      user = user_repo.find(@user_id)

      expect(user.name).to eq(@new_user.name)
    end
  end

  it 'deberia lanzar un error al buscar un usuario no existente' do
    expect do
      user_repo.find(99_999)
    end.to raise_error(ObjectNotFound)
  end
end
