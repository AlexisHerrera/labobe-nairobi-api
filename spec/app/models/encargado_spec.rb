require 'spec_helper'
require_relative 'api_clima_spec'

describe Encargado do
  let(:menu_individual) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}
  let(:menu_familiar) {MenuFactory.new.crear(3, "Menu familiar", 2000, MenusPosibles::GRANDE)}
  let(:repartidor_repo) { Persistence::Repositories::RepartidorRepository.new }
  let(:pedido_repo) { Persistence::Repositories::PedidoRepository.new }
  let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
  let(:pedido_individual) { Pedido.new(usuario, menu_individual, EstadosPosibles::PREPARACION) }
  let(:pedido_familiar) { Pedido.new(usuario, menu_familiar, EstadosPosibles::PREPARACION) }

  let(:repartidor) { Repartidor.new('Ying Hu', '41199980', '1144449999') }
  let(:otro_repartidor) { Repartidor.new('Carlos Solari', '14367888', '1234567999') }

  before :each do
    Persistence::Repositories::UsuarioRepository.new.save(usuario)

    Persistence::Repositories::MenuRepository.new.save(menu_individual)
    Persistence::Repositories::MenuRepository.new.save(menu_familiar)

    Persistence::Repositories::PedidoRepository.new.save(pedido_individual)
    Persistence::Repositories::PedidoRepository.new.save(pedido_familiar)

    Persistence::Repositories::RepartidorRepository.new.save(repartidor)
    Persistence::Repositories::RepartidorRepository.new.save(otro_repartidor)
  end

  context 'Asignar pedido' do
    it 'Deberia asignar un pedido que esta en preparacion al repartidor por orden alfabetico' do
      described_class.new(pedido_repo, repartidor_repo).procesar_pedido(pedido_individual)
      expect(pedido_individual.repartidor_asignado).to eq otro_repartidor
    end

    it 'Deberia actualizar estado de repartidor con mochila llena' do
      described_class.new(pedido_repo, repartidor_repo).procesar_pedido(pedido_familiar)
      expect(pedido_familiar.estado).to eq EstadosFactory.new.crear(EstadosPosibles::ENTREGADO)
    end

    it 'Deberia asignar pedidos al repartidor con la mochila mas vacía' do
      encargado = described_class.new(pedido_repo, repartidor_repo)
      encargado.procesar_pedido(pedido_individual)
      encargado.procesar_pedido(pedido_familiar)
      expect(pedido_individual.repartidor_asignado).to eq otro_repartidor
      expect(pedido_familiar.repartidor_asignado).to eq repartidor
    end
  end

  context 'encontrar repartidor' do
    it 'Si hay un solo repartidor que no tiene nada en la mochila, lo elige' do
      repartidores = [repartidor]

      # pedidos_repo = instance_double(Persistence::Repositories::PedidoRepository).as_null_object
      expect(described_class.elegir_repartidor(repartidores, pedido_individual)).to eq repartidor
    end

    it 'Si hay 2 repartidores elige al que la tiene vacia' do
      repartidor.asignar(pedido_individual)
      repartidores = [repartidor, otro_repartidor]
      expect(described_class.elegir_repartidor(repartidores, pedido_individual)).to eq repartidor
    end

    it 'Si hay 2 repartidores elige por orden alfabetico' do
      repartidores = [repartidor, otro_repartidor]
      expect(described_class.elegir_repartidor(repartidores, pedido_individual)).to eq otro_repartidor
    end

    it 'Si hay 2 repartidores, un con 1 pedido realizado. elige al que tiene menor cantidad de pedidos realizados' do
      repartidores = [repartidor, otro_repartidor]
      repartidor.pedidos_entregados = [1]
      expect(described_class.elegir_repartidor(repartidores, pedido_individual)).to eq otro_repartidor
    end
  end
# hay que cambiar el nombre de las variables de los repartidores para que sea mas claro
end

describe Encargado do
  let(:menu_individual) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}
  let(:menu_familiar) {MenuFactory.new.crear(3, "Menu familiar", 2500, MenusPosibles::GRANDE)}
  let(:repartidor_repo) { Persistence::Repositories::RepartidorRepository.new }
  let(:pedido_repo) { Persistence::Repositories::PedidoRepository.new }
  let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
  let(:pedido_individual) { Pedido.new(usuario, menu_individual, EstadosPosibles::ENTREGADO) }
  let(:pedido_familiar) { Pedido.new(usuario, menu_familiar, EstadosPosibles::ENTREGADO) }

  let(:repartidor) { Repartidor.new('Carlos Solari', '14367888', '1234567999') }

  before :each do
    Persistence::Repositories::UsuarioRepository.new.save(usuario)

    Persistence::Repositories::MenuRepository.new.save(menu_individual)
    Persistence::Repositories::MenuRepository.new.save(menu_familiar)


    Persistence::Repositories::RepartidorRepository.new.save(repartidor)
  end

  context 'calcular comision' do

    it 'comision de un pedido individual con calificacion buena' do
      pedido_individual.asignar_repartidor(repartidor)
      pedido_individual.calificar(usuario, CalificacionFactory.new.crear(3))
      pedido_repo.save(pedido_individual)

      configurar_api_dia_sin_lluvia
      expect(described_class.new(pedido_repo, repartidor_repo).calcular_comision('14367888')).to eq 50
    end

    it 'comision de un pedido individual con calificacion mala en una fecha que llovio' do
      pedido_individual.asignar_repartidor(repartidor)
      pedido_individual.calificar(usuario, CalificacionFactory.new.crear(1))
      pedido_repo.save(pedido_individual)

      configurar_api_dia_lluvioso
      expect(described_class.new(pedido_repo, repartidor_repo).calcular_comision('14367888')).to eq 40
    end
  end
end
