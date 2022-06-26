describe 'CreadorDeMochilas' do
  let(:pedido) { Pedido.new(12_367_262, '1144449999', 1, 0) }
  let(:repartidor) { Repartidor.new(1, 'Ying Hu', '41199980', '1144449999') }
  let(:entrega) { Entrega.new(nil, pedido, repartidor) }

  it 'deberia crear una  mochila y guarda las entregas en el repositorio' do
    pedidos = Array.new
    pedidos.push(pedido)
    mochila = Mochila.new(repartidor, pedidos)
    entregas = Array.new
    entregas.push(entrega)

    entregas_repo = instance_double(Persistence::Repositories::EntregaRepository).as_null_object
    pedidos_repo = instance_double(Persistence::Repositories::PedidoRepository).as_null_object
    repartidores_repo = instance_double(Persistence::Repositories::RepartidorRepository).as_null_object

    expect(pedidos_repo).to receive(:find).with(pedido.id).and_return(pedido)
    expect(repartidores_repo).to receive(:find).with(repartidor.id).and_return(repartidor)
    expect(entregas_repo).to receive(:find_by_repartidor).with(repartidor.id).and_return(entregas)

    nueva_mochila = CreadorDeMochilas.new(entregas_repo,pedidos_repo,repartidores_repo).crear_mochila(repartidor.id)
    expect(nueva_mochila).to eq(mochila)
  end
end
