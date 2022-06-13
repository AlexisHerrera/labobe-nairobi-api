require 'spec_helper'

describe Usuario do
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con nombre, numero y direccion' do
      nombre = 'Juan'
      telefono = '1144449999'
      direccion = 'Av. Paseo Colón 850'
      expect(described_class.new(nombre, telefono, direccion).telefono).to eq telefono
    end

    it 'no deberia ser valido cuando se crea con nombre, numero sin 10 digitos y direccion' do
      nombre = 'Juan'
      telefono = '1149'
      direccion = 'Av. Paseo Colón 850'

      expect{Usuario.new(nombre, telefono, direccion).telefono}.to raise_error(UsuarioInvalido)
    end

    it 'no deberia ser valido cuando se crea con nombre, numero no numerico y direccion' do
      nombre = 'Juan'
      telefono = 'Perez'
      direccion = 'Av. Paseo Colón 850'

      expect{Usuario.new(nombre, telefono, direccion).telefono}.to raise_error(UsuarioInvalido)
    end

    it 'no deberia ser valido cuando se crea con nombre con caracteres especiales, numero y direccion' do
      nombre = '4N4 :)'
      telefono = '1144349999'
      direccion = 'Av. Paseo Colón 850'

      expect{Usuario.new(nombre, telefono, direccion).telefono}.to raise_error(UsuarioInvalido)
    end

    it 'no deberia ser valido cuando se crea con nombre y numero' do
      nombre = '4N4 :)'
      telefono = '1144349999'
      direccion = ''

      expect{Usuario.new(nombre, telefono, direccion).telefono}.to raise_error(UsuarioInvalido)
    end
    
  end
end
