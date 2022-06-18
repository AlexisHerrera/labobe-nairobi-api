require 'integration_helper'

describe Persistence::Repositories::EstadoRepository do

   let(:estado_repo) { Persistence::Repositories::EstadoRepository.new }
   let(:un_estado) { Estado.new(0, 'Recibido') }

   context 'cuando un estado existe' do
     before :each do
       @nuevo_estado = estado_repo.save(un_estado)
       @estado_id = @nuevo_estado.id
     end

     it 'deberia encontrar el estado por id' do
       estado = estado_repo.find(@estado_id)

       expect(estado.id).to eq(@nuevo_estado.id)
     end
   end

   context 'cuando un estado existe' do
    before :each do
      @nuevo_estado = estado_repo.save(un_estado)
      @estado_id = @nuevo_estado.id
    end

    it 'deberia borrar todos los estados' do
      estado_repo.delete_all

      expect(estado_repo.all.count).to eq(0)
    end
  end
 end
