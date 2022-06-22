require 'integration_helper'

describe Persistence::Repositories::RepartidorRepository do
  let(:repartidor_repo) { Persistence::Repositories::RepartidorRepository.new }
  let(:repartidor) { Repartidor.new(nil, 'Juan', '41199980', '1144449999') }

  it 'deberia guardar un nuevo repartidor' do
    repartidor_repo.save(repartidor)
    expect(repartidor_repo.all.count).to eq(1)
  end
  # Faltan los otros test, pero no es redundante? Como lo hace el abstract repository, no van a fallar.
end
