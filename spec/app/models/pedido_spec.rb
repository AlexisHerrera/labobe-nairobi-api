require 'spec_helper'

describe Pedido do
  let(:menu) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}
  let(:menu_grande) {MenuFactory.new.crear(2, "Menu individual", 2500, MenusPosibles::GRANDE)}
  let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
  let(:id) { 12367262 }
  # Todo: sacar id pedido (ponerlo ultimo con nil opcional o hacerle un setter)
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con id, usuario, menu y estado' do
      estado = EstadosPosibles::ACEPTADO
      expect(described_class.new(id, usuario, menu, estado).id).to eq id
    end

    it 'cuando se modifica el estado de un pedido recien creado, el estado es 1' do
      estado = EstadosPosibles::ACEPTADO
      pedido = described_class.new(id, usuario, menu, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEnPreparacion.new
    end

    it 'cuando se modifica el estado de un pedido con estado 1, el estado es 2' do
      estado = EstadosPosibles::PREPARACION
      pedido = described_class.new(id, usuario, menu, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEnCamino.new
    end

    it 'cuando se modifica el estado de un pedido con estado 2, el estado es 3' do
      estado = EstadosPosibles::CAMINO
      pedido = described_class.new(id, usuario, menu, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEntregado.new
    end

    it 'cuando se modifica el estado de un pedido con estado 3, el estado es 3' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(id, usuario, menu, estado)
      pedido.siguiente_estado
      expect(pedido.estado).to eq EstadoEntregado.new
    end

    it 'cuando se consulta el estado de un pedido con un id_usuario diferente lanza excepcion' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(id, usuario, menu, estado)
      usuario_diferente = Usuario.new('roberto', '1234567000', 'Brandsen 805', '9999')
      expect { pedido.verificar_propietario(usuario_diferente) }.to raise_error(UsuarioInvalido)
    end

    it 'cuando se consulta si el estado es "en preparacion" y es "en preparacion" devuelve true' do
      estado = EstadosPosibles::PREPARACION
      pedido = described_class.new(id, usuario, menu, estado)
      expect(pedido.esta_en_preparacion?).to eq true
    end
  end

  context 'repartidor asignado' do
    it 'no tiene repartidor si no le fue asignado uno' do
      estado = EstadosPosibles::ACEPTADO
      expect(described_class.new(id, usuario, menu, estado).repartidor_asignado).to eq Repartidor.no_repartidor
    end

    it 'tiene un repartidor si se le asigna uno' do
      estado = EstadosPosibles::PREPARACION
      pedido = described_class.new(id, usuario, menu, estado)
      repartidor = Repartidor.new(nil, 'Ying Hu', '41199980', '1144449999')
      pedido.asignar_repartidor(repartidor)
      expect(pedido.repartidor_asignado).to eq repartidor
    end
  end

  context 'repartidor calificado' do
    it 'no tiene calificaion si no le fue asignado uno' do
      estado = EstadosPosibles::ENTREGADO
      expect(described_class.new(id, usuario, menu, estado).calificacion).to eq CalificacionInexistente.new
    end

    it 'tiene calificacion si se califica pedido' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(id, usuario, menu, estado)
      pedido.calificar(usuario, Calificacion.new(5))
      expect(pedido.calificacion).to eq Calificacion.new(5)
    end

    it 'tiene calificacion si no se califica pedido' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(id, usuario, menu, estado)
      expect(pedido.calificacion).to eq CalificacionInexistente.new
    end

    it 'no deberia guardar calificacion si se le pasa un usuario que no hizo el pedido' do
      otro_usuario = Usuario.new('maria', '1234511190', 'Paseo Colon 606', '345')
      pedido = Pedido.new(nil, usuario, menu, EstadosPosibles::ENTREGADO)
  
      expect{pedido.calificar(otro_usuario, Calificacion.new(5))}.to raise_error(UsuarioInvalido)
    end
  end

  context 'calcular comision' do
    it 'comision de un pedido con menu individual con calificacion buena' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(id, usuario, menu, estado)
      pedido.calificar(usuario, CalificacionFactory.new.crear(3))
      expect(pedido.comision).to eq 50
    end

    it 'comision de un pedido con menu familiar con calificacion excelente' do
      estado = EstadosPosibles::ENTREGADO
      pedido = described_class.new(id, usuario, menu_grande, estado)
      pedido.calificar(usuario, CalificacionFactory.new.crear(5))
      expect(pedido.comision).to eq 175
    end
  end
end
