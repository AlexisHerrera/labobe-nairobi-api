require 'integration_helper'

describe Persistence::Repositories::EntregaRepository do
  let(:entrega_repo) { Persistence::Repositories::EntregaRepository.new }
  let(:pedido) { Pedido.new(12367262, '1144449999', 1, 0) }
  let(:repartidor) { Repartidor.new(1, 'Ying Hu', '41199980', '1144449999') }

  before :each do
    usuario = Usuario.new('Juan', '1144449999', 'paseo colon 850', '123')
    Persistence::Repositories::UsuarioRepository.new.save(usuario)
    menu = Menu.new(1, 'Menu individual', 1000.0)
    Persistence::Repositories::MenuRepository.new.save(menu)
    pedido_repo = Persistence::Repositories::PedidoRepository.new
    pedido_repo.save(pedido)
    repartidor_repo = Persistence::Repositories::RepartidorRepository.new
    repartidor_repo.save(repartidor)
  end

  let(:entrega) { Entrega.new(nil, pedido, repartidor) }

  it 'deberia guardar una nueva entrega' do
    entrega_repo.save(entrega)
    expect(entrega_repo.all.count).to eq(1)
  end
  # Faltan los otros test, pero no es redundante? Como lo hace el abstract repository, no van a fallar.
end
