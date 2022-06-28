require 'spec_helper'

describe Encargado do
  let(:menu) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}
  let(:entrega_repo) { Persistence::Repositories::EntregaRepository.new }
  let(:repartidor_repo) { Persistence::Repositories::RepartidorRepository.new }
  let(:pedido_repo) { Persistence::Repositories::PedidoRepository.new }
  let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
  let(:pedido) { Pedido.new(12367262, usuario, menu, EstadosPosibles::PREPARACION) }
  let(:repartidor) { Repartidor.new(1, 'Ying Hu', '41199980', '1144449999') }

  before :each do
    Persistence::Repositories::UsuarioRepository.new.save(usuario)
    Persistence::Repositories::MenuRepository.new.save(menu)
    Persistence::Repositories::PedidoRepository.new.save(pedido)
    Persistence::Repositories::RepartidorRepository.new.save(repartidor)
  end

  context 'Asignar pedido' do
    it 'Deberia asignar un pedido que esta en preparacion a un repartidor' do
      described_class.new(pedido_repo, repartidor_repo).asignar_pedido(pedido)
      expect(pedido.repartidor_asignado).to eq repartidor
    end
  end
end


