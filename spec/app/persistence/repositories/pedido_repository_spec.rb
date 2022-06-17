require 'integration_helper'

describe Persistence::Repositories::PedidoRepository do
  let(:pedido_repo) { Persistence::Repositories::PedidoRepository.new }
  let(:un_pedido) { Pedido.new(1, "0123456789", 1) }

  before :each do
    usuario = Usuario.new('Juan', '0123456789', 'paseo colon 850', '123')
    Persistence::Repositories::UserRepository.new.save(usuario)
    menu = Menu.new(1, 'Menu individual', 1000.0)
    Persistence::Repositories::MenuRepository.new.save(menu)
  end

  after :each do
    # Necesario porque antes de eliminar la tabla usuario o menu, hay que borrar primero la de pedidos
    # porque hace referencia a esas tablas (integridad referencial)
    pedido_repo.delete_all
  end

  it 'deberia guardar un nuevo pedido' do
    pedido_repo.delete_all
    pedido_repo.save(un_pedido)
    expect(pedido_repo.all.count).to eq(1)
  end

  it 'el nuevo pedido deberia tener un id de usuario' do
    new_user = pedido_repo.save(un_pedido)
    expect(new_user.id_usuario).to be_present
  end

  it 'el nuevo pedido deberia tener un id de menu' do
    new_user = pedido_repo.save(un_pedido)
    expect(new_user.id_menu).to be_present
  end

  context 'cuando un pedido existe' do
    before :each do
      @nuevo_pedido = pedido_repo.save(un_pedido)
      @pedido_id = @nuevo_pedido.id
    end

    it 'deberia borrar todos los pedidos' do
      pedido_repo.delete_all

      expect(pedido_repo.all.count).to eq(0)
    end

    it 'deberia encontrar el pedido por id' do
      pedido = pedido_repo.find(@pedido_id)

      expect(pedido.id).to eq(@nuevo_pedido.id)
    end
  end

  it 'deberia lanzar un error al buscar un pedido no existente' do
    expect do
      pedido_repo.find(99_999)
    end.to raise_error(ObjectNotFound)
  end
end
