require 'integration_helper'

describe Persistence::Repositories::PedidoRepository do
  let(:menu) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}
  let(:pedido_repo) { Persistence::Repositories::PedidoRepository.new }
  let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
  let(:un_pedido) { Pedido.new(nil, usuario, menu, EstadosPosibles::ACEPTADO) }

  before :each do
    Persistence::Repositories::UsuarioRepository.new.save(usuario)
    Persistence::Repositories::MenuRepository.new.save(menu)
  end

  it 'deberia guardar un nuevo pedido' do
    pedido_repo.delete_all
    pedido_repo.save(un_pedido)
    expect(pedido_repo.all.count).to eq(1)
  end

  it 'el nuevo pedido deberia tener un id de usuario' do
    pedido = pedido_repo.save(un_pedido)
    expect(pedido.usuario).to be_present
  end

  it 'el nuevo pedido deberia tener un id de menu' do
    pedido = pedido_repo.save(un_pedido)
    expect(pedido.menu).to be_present
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
