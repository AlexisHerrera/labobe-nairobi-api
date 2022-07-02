require 'spec_helper'

describe BackOffice do
  let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}

  before :each do
    @backoffice = BackOffice.new
    Persistence::Repositories::UsuarioRepository.new.save(usuario)
    # repo_pedidos = Persistence::Repositories::PedidoRepository.new
    # Persistence::Repositories::RepartidorRepository.new.save(repartidor)
  end

  context 'Crear pedido' do
    it 'Debería crear un pedido con un usuario y un menu determinado' do
      id_usuario = '123'
      id_menu = 1
      pedido = @backoffice.crear_pedido(id_usuario, id_menu)
      expect(pedido).not_to be nil
    end
  end
end
