describe 'CreadorDeRepartidores' do
  it 'deberia crear un repartidor y guardar en el repositorio' do

    repo = instance_double(Persistence::Repositories::RepartidorRepository).as_null_object
    repartidor = Repartidor.new(nil , 'Ying Hu', '41199980', '1144449999')

    expect(repo).to receive(:save).with(repartidor).and_return(repartidor)

    nuevo_repartidor = CreadorDeRepartidores.new(repo).crear_repartidor('Ying Hu', '41199980', '1144449999')
    expect(nuevo_repartidor).to eq(repartidor)

  end
end
