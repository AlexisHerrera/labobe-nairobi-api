require 'spec_helper'

# TODO: Prescindir de este require_relative para que no dependa del webmock
require_relative 'api_clima_spec'

describe Restaurante do
  let(:menu) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::GRANDE)}
  let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
  let(:repartidor) { Repartidor.new('Carlos Solari', '14367888', '1234567999') }

  before :each do
    @restaurante = Restaurante.new
    Persistence::Repositories::UsuarioRepository.new.save(usuario)
    Persistence::Repositories::RepartidorRepository.new.save(repartidor)
  end

  context 'Crear pedido' do
    it 'Debería crear un pedido con un usuario y un menu determinado' do
      id_usuario = '123'
      id_menu = 1
      pedido = @restaurante.crear_pedido(id_usuario, id_menu)
      expect(pedido).not_to be nil
    end
  end

  it 'Debería devolver un pedido al consultar uno' do
    id_usuario = '123'
    id_menu = 1
    pedido = @restaurante.crear_pedido(id_usuario, id_menu)
    id_pedido = pedido.id
    pedido_consultado = @restaurante.consultar_pedido(id_pedido, id_usuario)
    expect(pedido_consultado.id).to eq id_pedido
  end

  it 'Cambia estado pedido' do
    id_usuario = '123'
    id_menu = 1
    pedido = @restaurante.crear_pedido(id_usuario, id_menu)
    id_pedido = pedido.id
    @restaurante.cambiar_estado_pedido(id_pedido)
    pedido_consultado = @restaurante.consultar_pedido(id_pedido, id_usuario)
    expect(pedido_consultado.estado).to eq EstadoEnPreparacion.new
  end

  it 'Califica pedido' do
    id_usuario = '123'
    id_menu = 3
    pedido = @restaurante.crear_pedido(id_usuario, id_menu)
    id_pedido = pedido.id
    @restaurante.cambiar_estado_pedido(id_pedido)
    @restaurante.cambiar_estado_pedido(id_pedido)
    @restaurante.cambiar_estado_pedido(id_pedido)
    puntaje = 5
    pedido_calificado = @restaurante.calificar_pedido(id_pedido, id_usuario, puntaje)
    expect(pedido_calificado.calificacion).to eq CalificacionExcelente.new
  end

  it 'Devuelve los menues disponibles' do
    menu_repo = Persistence::Repositories::MenuRepository.new
    menu_repo.delete_all
    menu_individual = MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)
    menu_familiar = MenuFactory.new.crear(3, "Menu familiar", 2000, MenusPosibles::GRANDE)
    menu_repo.save(menu_individual)
    menu_repo.save(menu_familiar)
    menus = @restaurante.consultar_menus
    expect(menus.length).to eq 2
  end

  it 'Crea un usuario' do
    nombre = 'Alexis'
    telefono = '1234512122'
    direccion = 'Brandsen 805'
    id_telegram = '124'
    usuario_creado = @restaurante.crear_usuario(nombre, telefono, direccion, id_telegram)
    expect(usuario_creado).not_to be nil
  end

  it 'Crea un repartidor' do
    nombre = 'pipita'
    telefono = '1234512126'
    dni = '23456789'
    repartidor_nuevo = @restaurante.crear_repartidor(nombre, dni, telefono)
    expect(repartidor_nuevo).not_to be nil
  end

  it 'Calcula comisiones' do
    configurar_api_dia_sin_lluvia('fake_token')
    expect(@restaurante.calcular_comision(repartidor.dni)).to eq 0
  end
end
