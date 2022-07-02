require 'spec_helper'

describe CalificacionBuena do
  let(:menu_individual) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}

    it 'Comision de menu individual es 50' do
      expect(described_class.new.comision(menu_individual)).to eq 50 
    end
end
