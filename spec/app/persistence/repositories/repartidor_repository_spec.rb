require 'integration_helper'

describe Persistence::Repositories::RepartidorRepository do
  let(:repartidor_repo) { Persistence::Repositories::RepartidorRepository.new }
  let(:repartidor) { Repartidor.new('Ying Hu', '41199980', '1144449999') }

  it 'deberia guardar un nuevo repartidor' do
    repartidor_repo.save(repartidor)
    expect(repartidor_repo.all.count).to eq(1)
  end

  it 'deberia devolver todos los repartidores creados' do
    repartidor_repo.save(repartidor)
    repartidores = Array.new
    repartidores.push(repartidor)
    expect(repartidor_repo.all).to eq(repartidores)
  end

  # Faltan los otros test, pero no es redundante? Como lo hace el abstract repository, no van a fallar.
end
