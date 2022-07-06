require 'integration_helper'

describe Persistence::Repositories::PedidoRepository do
  let(:menu) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}
  let(:pedido_repo) { Persistence::Repositories::PedidoRepository.new }
  let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
  let(:un_pedido) { Pedido.new(usuario, menu) }
  let(:repartidor_repo) { Persistence::Repositories::RepartidorRepository.new }
  before :each do
    Persistence::Repositories::UsuarioRepository.new.save(usuario)
    Persistence::Repositories::MenuRepository.new.save(menu)
  end

  it 'deberia guardar un nuevo pedido' do
    pedido_repo.delete_all
    pedido_repo.save(un_pedido)
    expect(pedido_repo.all.count).to eq(1)
  end

  it 'el nuevo pedido deberia tener un id de usuario' do
    pedido = pedido_repo.save(un_pedido)
    expect(pedido.usuario).to be_present
  end

  it 'el nuevo pedido deberia tener un id de menu' do
    pedido = pedido_repo.save(un_pedido)
    expect(pedido.menu).to be_present
  end

  context 'cuando un pedido existe' do
    before :each do
      @nuevo_pedido = pedido_repo.save(un_pedido)
      @pedido_id = @nuevo_pedido.id
    end

    it 'deberia borrar todos los pedidos' do
      pedido_repo.delete_all

      expect(pedido_repo.all.count).to eq(0)
    end

    it 'deberia encontrar el pedido por id' do
      pedido = pedido_repo.find(@pedido_id)
      
      expect(pedido.id).to eq(@nuevo_pedido.id)
    end
  end

  it 'deberia lanzar un error al buscar un pedido no existente' do
    expect do
      pedido_repo.find(99_999)
    end.to raise_error(ObjectNotFound)
  end

  it 'deberia guardar un pedido con su repartidor si es que tiene uno asignado' do
    pedido = Pedido.new(usuario, menu)
    pedido.siguiente_estado #lo pongo En Preparacion
    repartidor = Repartidor.new('Ying Hu', '41199980', '1144449999')
    repartidor_repo.save(repartidor)

    pedido.asignar_repartidor(repartidor)
    pedido_guardado = pedido_repo.save(pedido)

    pedido_encontrado = pedido_repo.find(pedido_guardado.id)
    expect(pedido_encontrado).to eq(pedido)
    expect(pedido_encontrado.repartidor_asignado).to eq(repartidor)
  end

  it 'deberia guardar un pedido con su repartidor si es que tiene uno asignado' do
    pedido = Pedido.new(usuario, menu)
    pedido.siguiente_estado

    repartidor = Repartidor.new('Ying Hu', '41199980', '1144449999')
    repartidor_nuevo = repartidor_repo.save(repartidor)

    pedido.asignar_repartidor(repartidor)
    repartidor.asignar(pedido)

    pedido_repo.save(pedido)

    pedidos_encontrado = pedido_repo.find_by_id_repartidor(repartidor_nuevo.id)

    expect(pedidos_encontrado[0]).to eq(pedido)
    expect(pedidos_encontrado.size).to eq(1)
  end

  it 'deberia guardar calificacion si tiene una calificacion' do
    pedido = Pedido.new(usuario, menu)
    pedido.siguiente_estado
    pedido.siguiente_estado
    pedido.siguiente_estado
    pedido.calificar(usuario, CalificacionFactory.new.crear(5))

    pedido_guardado = pedido_repo.save(pedido)

    pedidos_encontrado = pedido_repo.find(pedido_guardado.id)

    expect(pedidos_encontrado.calificacion).to eq(CalificacionExcelente.new)
  end
end
