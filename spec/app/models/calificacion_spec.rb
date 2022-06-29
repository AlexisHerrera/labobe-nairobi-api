require 'spec_helper'

describe Calificacion do
  context 'cuando es creado' do
    it 'deberia ser valido cuando se crea con puntaje 5' do
      puntaje = 5
      expect(described_class.new(puntaje).puntaje).to eq puntaje
    end

  end
end
