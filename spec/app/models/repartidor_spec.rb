
require 'spec_helper'

describe Repartidor do
  context 'Crear un repartidor' do
    it 'deberia ser valido cuando se crea con nombre, dni y telefonos con formato correcto' do
      nombre = 'Ying Hu'
      dni = '41199980'
      telefono = '1144449999'
      expect(described_class.new(nombre, dni, telefono).nombre).to eq 'Ying Hu'
    end

    it 'No deberia ser valido cuando tiene un nombre menor a 5 caracteres' do
      nombre = 'Yi Hu'
      dni = '41199980'
      telefono = '1144449999'
      expect{described_class.new(nombre, dni, telefono)}.to raise_error(RepartidorInvalido)
    end

    it 'No deberia ser valido cuando tiene un nombre mayor a 20 caracteres' do
      nombre = 'Ying HuHaHeHeHeHUHAHUHAHHAHAHAHAHAHHAHA'
      dni = '41199980'
      telefono = '1144449999'
      expect{described_class.new(nombre, dni, telefono)}.to raise_error(RepartidorInvalido)
    end

    it 'No deberia ser valido cuando el numero no es numerico' do
      nombre = 'Ying Hu'
      dni = '41199980'
      telefono = '123456789A'
      expect{described_class.new(nombre, dni, telefono)}.to raise_error(RepartidorInvalido)
    end

    it 'No deberia ser valido cuando el numero no tiene 10 digitos' do
      nombre = 'Ying Hu'
      dni = '41199980'
      telefono = '12345678901'
      expect{described_class.new(nombre, dni, telefono)}.to raise_error(RepartidorInvalido)
    end
    
  end

  context 'Consultar mochila' do

    let(:menu) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::GRANDE)}
    let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
    let(:pedido) { Pedido.new(usuario, menu, EstadosPosibles::ACEPTADO) }
    let(:pedido_en_preparacion) { Pedido.new(usuario, menu, EstadosPosibles::PREPARACION) }
    
    it 'si un repartidor no tiene ningun pedido, esta vacia' do
      nombre = 'Ying Hu'
      dni = '41199980'
      telefono = '1144449999'
      expect(described_class.new(nombre, dni, telefono).tiene_pedidos?).to eq true
    end

    it 'si un repartidor tiene un pedido con menu familiar, la mochila esta llena' do
      nombre = 'Ying Hu'
      dni = '41199980'
      telefono = '1144449999'
      repartidor = described_class.new(nombre, dni, telefono)
      repartidor.asignar(pedido)
      expect(repartidor.mochila_llena?).to eq true
    end

    it 'al salir, los pedidos que tenga en la mochila pasan a estado Entregados' do
      nombre = 'Ying Hu'
      dni = '41199980'
      telefono = '1144449999'
      repartidor = described_class.new(nombre, dni, telefono)
      repartidor.asignar(pedido_en_preparacion)
      repartidor.salir
      pedidos = repartidor.pedidos_entregados
      pedidos.each do |pedido|
        expect(pedido.estado).to eq EstadosFactory.new.crear(EstadosPosibles::ENTREGADO)
      end
    end
    
  end

  context 'Consultar espacio restante' do
    let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
    let(:menu_chico) {MenuFactory.new.crear(1, "Menu", 1000, MenusPosibles::CHICO)}
    let(:menu_mediano) {MenuFactory.new.crear(1, "Menu", 1000, MenusPosibles::MEDIANO)}
    let(:menu_grande) {MenuFactory.new.crear(1, "Menu", 1000, MenusPosibles::GRANDE)}
    let(:pedido_chico) { Pedido.new(usuario, menu_chico, EstadosPosibles::CAMINO) }
    let(:pedido_mediano) { Pedido.new(usuario, menu_mediano, EstadosPosibles::CAMINO) }
    let(:pedido_grande) { Pedido.new(usuario, menu_grande, EstadosPosibles::CAMINO) }
    let(:repartidor) {described_class.new("nombre", "41199980", "1144449999")}

    it 'repartidor con pedido chico tiene espacio para menu mediano' do
      repartidor.asignar(pedido_chico)
      expect(repartidor.entra_pedido?(pedido_mediano)).to eq(true)
    end

    it 'repartidor con pedido mediano tiene lugar para pedido individual' do
      repartidor.asignar(pedido_mediano)
      expect(repartidor.entra_pedido?(pedido_chico)).to eq(true)
    end

    it 'repartidor con 2 pedidos individuales tiene lugar para pedido individual' do
      repartidor.asignar(pedido_chico)
      repartidor.asignar(pedido_chico)
      expect(repartidor.entra_pedido?(pedido_chico)).to eq(true)
    end

    it 'repartidor con pedido mediano y chico no tiene lugar' do
      repartidor.asignar(pedido_mediano)
      repartidor.asignar(pedido_chico)
      expect(repartidor.entra_pedido?(pedido_chico)).to eq(false)
    end

    it 'repartidor con pedido grande no tiene lugar' do
      repartidor.asignar(pedido_grande)
      expect(repartidor.entra_pedido?(pedido_chico)).to eq(false)
    end
  end

  context 'Calcular comision repartidor' do
    let(:usuario) { Usuario.new('john', '1234567890', 'Paseo Colon 606', '123')}
    let(:menu_chico) {MenuFactory.new.crear(1, "Menu", 1000, MenusPosibles::CHICO)}
    let(:menu_mediano) {MenuFactory.new.crear(1, "Menu", 1500, MenusPosibles::MEDIANO)}
    let(:menu_grande) {MenuFactory.new.crear(1, "Menu", 2000, MenusPosibles::GRANDE)}
    let(:pedido_chico) { Pedido.new(usuario, menu_chico, EstadosPosibles::ENTREGADO) }
    let(:pedido_mediano) { Pedido.new(usuario, menu_mediano, EstadosPosibles::ENTREGADO) }
    let(:pedido_grande) { Pedido.new(usuario, menu_grande, EstadosPosibles::ENTREGADO) }
    let(:repartidor) {described_class.new("nombre", "41199980", "1144449999")}

    it 'repartidor con pedido chico y calificacion buena calcula 50 de comision sin lluvia' do
      pedido_chico.calificar(usuario, CalificacionFactory.new.crear(3))
      repartidor.pedidos_entregados.push(pedido_chico)
      expect(repartidor.comision(DiaSinLluvia.new)).to eq(50)
    end

    it 'repartidor con pedido chico y calificacion mala con lluvia obtiene el 4%' do
      pedido_chico.calificar(usuario, CalificacionFactory.new.crear(1))
      repartidor.pedidos_entregados.push(pedido_chico)
      comision_esperada = menu_chico.precio * 0.04
      expect(repartidor.comision(DiaLluvioso.new)).to eq(comision_esperada)
    end

    it 'repartidor con pedido mediano y calificacion buena con lluvia obtiene el 6%' do
      pedido_mediano.calificar(usuario, CalificacionFactory.new.crear(3))
      repartidor.pedidos_entregados.push(pedido_mediano)
      comision_esperada = menu_mediano.precio * 0.06
      expect(repartidor.comision(DiaLluvioso.new)).to eq(comision_esperada)
    end

    it 'repartidor con pedido grande y calificacion excelente con lluvia obtiene el 8%' do
      pedido_grande.calificar(usuario, CalificacionFactory.new.crear(5))
      repartidor.pedidos_entregados.push(pedido_grande)
      comision_esperada = menu_grande.precio * 0.08
      expect(repartidor.comision(DiaLluvioso.new)).to eq(comision_esperada)
    end

    # Nota: mas test del mismo estilo son innecesarios, debido a que la logica es sencilla
  end
end
