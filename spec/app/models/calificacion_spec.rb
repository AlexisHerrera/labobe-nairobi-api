require 'spec_helper'

describe Calificacion do
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con puntaje 5' do
      puntaje = 5
      expect(described_class.new(puntaje).puntaje).to eq puntaje
    end

    it 'deberia ser invalido cuando se crea con puntaje 0' do
      puntaje = 0
      expect{described_class.new(puntaje).puntaje}.to raise_error(CalificacionInvalida)
    end

    it 'deberia ser invalido cuando se crea con puntaje 10' do
      puntaje = 0
      expect{described_class.new(puntaje).puntaje}.to raise_error(CalificacionInvalida)
    end

  end
end
