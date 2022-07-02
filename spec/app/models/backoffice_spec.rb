require 'spec_helper'

describe BackOffice do
  let(:menu) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::GRANDE)}
  let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}

  before :each do
    @backoffice = BackOffice.new
    Persistence::Repositories::UsuarioRepository.new.save(usuario)
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

  it 'Debería devolver un pedido al consultar uno' do
    id_usuario = '123'
    id_menu = 1
    pedido = @backoffice.crear_pedido(id_usuario, id_menu)
    id_pedido = pedido.id
    pedido_consultado = @backoffice.consultar_pedido(id_pedido, id_usuario)
    expect(pedido_consultado.id).to eq id_pedido
  end

  it 'Cambia estado pedido' do
    id_usuario = '123'
    id_menu = 1
    pedido = @backoffice.crear_pedido(id_usuario, id_menu)
    id_pedido = pedido.id
    @backoffice.cambiar_estado_pedido(id_pedido)
    pedido_consultado = @backoffice.consultar_pedido(id_pedido, id_usuario)
    expect(pedido_consultado.estado).to eq EstadoEnPreparacion.new
  end
end
