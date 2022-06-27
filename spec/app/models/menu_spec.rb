require 'spec_helper'


describe Menu do
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con id, descripcion y precio' do
      id = 1
      descripcion = 'Menu Pareja'
      precio = 1500
      expect(described_class.new(id, descripcion, precio).descripcion).to eq descripcion
    end

    it 'deberia ser invalido cuando se crea con id, descripcion y precio -1500' do
      id = 1
      descripcion = 'Menu Pareja'
      precio = -1500
      expect{described_class.new(id, descripcion, precio)}.to raise_error(MenuInvalido)
    end

    it 'deberia ser invalido cuando se crea con id no es entero, descripcion y precio' do
      id = "1"
      descripcion = 'Menu Pareja'
      precio = 1500
      expect{described_class.new(id, descripcion, precio)}.to raise_error(MenuInvalido)
    end

  end
end



describe MenuFactory do
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con id, descripcion y precio' do
      id = 1
      descripcion = 'Menu Individual'
      precio = 1500

      menu = MenuFactory.new.crear(id, descripcion, precio, MenusPosibles::CHICO)
      expect(menu.tamanio).to eq MenusPosibles::CHICO
    end

    it 'deberia ser valido cuando se crea con id, descripcion y precio' do
      id = 1
      descripcion = 'Menu Pareja'
      precio = 1500

      menu = MenuFactory.new.crear(id, descripcion, precio, MenusPosibles::MEDIANO)
      expect(menu.tamanio).to eq MenusPosibles::MEDIANO
    end

    it 'deberia ser valido cuando se crea con id, descripcion y precio' do
      id = 1
      descripcion = 'Menu Familiar'
      precio = 1500

      menu = MenuFactory.new.crear(id, descripcion, precio, MenusPosibles::GRANDE)
      expect(menu.tamanio).to eq MenusPosibles::GRANDE
    end

  end
end