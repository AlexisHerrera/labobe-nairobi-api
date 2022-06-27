require 'integration_helper'

describe Persistence::Repositories::EntregaRepository do
  let(:menu) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}
  let(:entrega_repo) { Persistence::Repositories::EntregaRepository.new }
  let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
  let(:pedido) { Pedido.new(12367262, usuario, menu, EstadosPosibles::ACEPTADO) }
  let(:repartidor) { Repartidor.new(1, 'Ying Hu', '41199980', '1144449999') }

  before :each do
    Persistence::Repositories::UsuarioRepository.new.save(usuario)
    Persistence::Repositories::MenuRepository.new.save(menu)
    Persistence::Repositories::PedidoRepository.new.save(pedido)
    Persistence::Repositories::RepartidorRepository.new.save(repartidor)
  end

  let(:entrega) { Entrega.new(nil, pedido, repartidor) }

  it 'deberia guardar una nueva entrega' do
    entrega_repo.save(entrega)
    expect(entrega_repo.all.count).to eq(1)
  end

  it 'deberia devolver una entrega segun su id de pedido' do
    entrega_repo.save(entrega)
    id_pedido = pedido.id
    entrega_encontrada = entrega_repo.find_by_id_pedido(id_pedido)

    expect(entrega_encontrada == entrega).to eq true
  end

  it 'deberia devolver entregas segun el id de un repartidor' do
    entrega_repo.save(entrega)
    entregas_encontrada = entrega_repo.find_by_repartidor(entrega.repartidor.id)

    entregas = Array.new
    entregas.push(entrega)

    expect(entregas_encontrada == entregas).to eq true
  end
end
