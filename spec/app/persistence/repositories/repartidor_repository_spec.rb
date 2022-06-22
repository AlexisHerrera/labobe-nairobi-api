require 'integration_helper'

describe Persistence::Repositories::RepartidorRepository do
  let(:repartidor_repo) { Persistence::Repositories::RepartidorRepository.new }
  let(:repartidor) { Repartidor.new(nil, 'Juan', '41199980', '0123456789') }

  it 'deberia guardar un nuevo repartidor' do
    repartidor_repo.save(repartidor)
    expect(repartidor_repo.all.count).to eq(1)
  end
end
