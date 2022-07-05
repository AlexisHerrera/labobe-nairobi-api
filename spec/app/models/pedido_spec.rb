require 'spec_helper'

describe Pedido do
  let(:menu_chico) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}
  let(:menu_grande) {MenuFactory.new.crear(2, "Menu individual", 2500, MenusPosibles::GRANDE)}
  let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
  let(:id) { 12367262 }

  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con id, usuario y menu' do
      expect(described_class.new(usuario, menu_chico, id).id).to eq id
    end

    it 'cuando se modifica el estado de un pedido recien creado, el estado es 1' do
      estado = EstadosPosibles::ACEPTADO
      pedido = described_class.new(usuario, menu_chico, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEnPreparacion.new
    end

    xit 'cuando se modifica el estado de un pedido con estado 1, el estado es 2' do
      estado = EstadosPosibles::PREPARACION
      pedido = described_class.new(usuario, menu_chico, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEnCamino.new
    end

    xit 'cuando se modifica el estado de un pedido con estado 2, el estado es 3' do
      estado = EstadosPosibles::CAMINO
      pedido = described_class.new(usuario, menu_chico, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEntregado.new
    end

    xit 'cuando se modifica el estado de un pedido con estado 3, el estado es 3' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(usuario, menu_chico, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEntregado.new
    end

    it 'cuando se consulta el estado de un pedido con un id_usuario diferente lanza excepcion' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(usuario, menu_chico, estado)
      usuario_diferente = Usuario.new('roberto', '1234567000', 'Brandsen 805', '9999')
      expect { pedido.verificar_propietario(usuario_diferente) }.to raise_error(UsuarioInvalido)
    end

    xit 'cuando se consulta si el estado es "en preparacion" y es "en preparacion" devuelve true' do
      estado = EstadosPosibles::PREPARACION
      pedido = described_class.new(usuario, menu_chico, estado)
      expect(pedido.esta_en_preparacion?).to eq true
    end
  end

  context 'repartidor asignado' do
    it 'no tiene repartidor si no le fue asignado uno' do
      estado = EstadosPosibles::ACEPTADO
      expect(described_class.new(usuario, menu_chico, estado).repartidor_asignado).to eq Repartidor.no_repartidor
    end

    it 'tiene un repartidor si se le asigna uno' do
      estado = EstadosPosibles::PREPARACION
      pedido = described_class.new(usuario, menu_chico, estado)
      repartidor = Repartidor.new('Ying Hu', '41199980', '1144449999')
      pedido.asignar_repartidor(repartidor)
      expect(pedido.repartidor_asignado).to eq repartidor
    end
  end

  context 'repartidor calificado' do
    it 'no tiene calificaion si no le fue asignado uno' do
      estado = EstadosPosibles::ENTREGADO
      expect(described_class.new(usuario, menu_chico, estado).calificacion).to eq CalificacionInexistente.new
    end

    xit 'tiene calificacion si se califica pedido' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(usuario, menu_chico, estado)
      pedido.calificar(usuario, CalificacionFactory.new.crear(5))
      expect(pedido.calificacion).to eq CalificacionExcelente.new
    end

    it 'tiene calificacion si no se califica pedido' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(usuario, menu_chico, estado)
      expect(pedido.calificacion).to eq CalificacionInexistente.new
    end

    it 'no deberia guardar calificacion si se le pasa un usuario que no hizo el pedido' do
      otro_usuario = Usuario.new('maria', '1234511190', 'Paseo Colon 606', '345')
      pedido = Pedido.new(usuario, menu_chico, EstadosPosibles::ENTREGADO)
  
      expect{pedido.calificar(otro_usuario, CalificacionFactory.new.crear(5))}.to raise_error(UsuarioInvalido)
    end
  end

  context 'calcular comision sin lluvia' do
    xit 'comision de un pedido con menu individual con calificacion buena' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(usuario, menu_chico, estado)
      pedido.calificar(usuario, CalificacionFactory.new.crear(3))
      expect(pedido.comision_base).to eq 50
    end

    xit 'comision de un pedido con menu familiar con calificacion excelente' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(usuario, menu_grande, estado)
      pedido.calificar(usuario, CalificacionFactory.new.crear(5))
      expect(pedido.comision_base).to eq 175
    end

    xit 'comision de un pedido con menu familiar con calificacion mala' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(usuario, menu_grande, estado)
      pedido.calificar(usuario, CalificacionFactory.new.crear(1))
      expect(pedido.comision_base).to eq 75
    end
  end

  context 'calcular comision extra con lluvia' do
    let(:pedido_chico) {described_class.new(usuario, menu_chico, EstadosPosibles::ENTREGADO)}
    it 'comision de un pedido con menu individual' do
      comision_extra_esperada = menu_chico.precio*0.01
      expect(comision_extra_esperada).to eq 10
      expect(pedido_chico.comision_extra(DiaLluvioso.new)).to eq comision_extra_esperada
    end

  end
end
