describe 'CreadorDeRepartidores' do
  it 'deberia crear un repartidor y guardar en el repositorio' do

    repo = instance_double(Persistence::Repositories::RepartidorRepository).as_null_object
    repartidor = Repartidor.new(nil , 'Ying Hu', '41199980', '1144449999')

    expect(repo).to receive(:has_dni).with('41199980').and_return(false)
    expect(repo).to receive(:save).with(repartidor).and_return(repartidor)

    nuevo_repartidor = CreadorDeRepartidores.new(repo).crear_repartidor('Ying Hu', '41199980', '1144449999')
    expect(nuevo_repartidor).to eq(repartidor)

  end

  it 'No deberia crear un repartidor cuando existe uno con el mismo dni' do

    repo = instance_double(Persistence::Repositories::RepartidorRepository).as_null_object

    expect(repo).to receive(:has_dni).with('41199980').and_return(true)

    expect{CreadorDeRepartidores.new(repo).crear_repartidor('Xing Hu', '41199980', '1144449999')}.to raise_error(DniEnUso)

  end
end
