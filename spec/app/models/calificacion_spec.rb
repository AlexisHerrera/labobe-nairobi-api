require 'spec_helper'

describe CalificacionBuena do
  let(:menu_individual) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}
  let(:menu_pareja) {MenuFactory.new.crear(2, "Menu pareja", 1500, MenusPosibles::MEDIANO)}
  let(:menu_familiar) {MenuFactory.new.crear(3, "Menu familiar", 2500, MenusPosibles::GRANDE)}


    it 'Comision de menu individual es 50' do
      expect(described_class.new.comision(menu_individual)).to eq 50 
    end

    it 'Comision de menu pareja es 75' do
      expect(described_class.new.comision(menu_pareja)).to eq 75
    end

    it 'Comision de menu familiar es 125' do
      expect(described_class.new.comision(menu_familiar)).to eq 125
    end
end



describe CalificacionMala do
  let(:menu_individual) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}
  let(:menu_pareja) {MenuFactory.new.crear(2, "Menu pareja", 1500, MenusPosibles::MEDIANO)}
  let(:menu_familiar) {MenuFactory.new.crear(3, "Menu familiar", 2500, MenusPosibles::GRANDE)}


    it 'Comision de menu individual es 30' do
      expect(described_class.new.comision(menu_individual)).to eq 30 
    end

    it 'Comision de menu pareja es 45' do
      expect(described_class.new.comision(menu_pareja)).to eq 45
    end

    it 'Comision de menu familiar es 75' do
      expect(described_class.new.comision(menu_familiar)).to eq 75
    end
end

describe CalificacionExcelente do
  let(:menu_individual) {MenuFactory.new.crear(1, "Menu individual", 1000, MenusPosibles::CHICO)}
  let(:menu_pareja) {MenuFactory.new.crear(2, "Menu pareja", 1500, MenusPosibles::MEDIANO)}
  let(:menu_familiar) {MenuFactory.new.crear(3, "Menu familiar", 2500, MenusPosibles::GRANDE)}


    it 'Comision de menu individual es 70' do
      expect(described_class.new.comision(menu_individual)).to eq 70 
    end

    it 'Comision de menu pareja es 105' do
      expect(described_class.new.comision(menu_pareja)).to eq 105
    end

    it 'Comision de menu familiar es 175' do
      expect(described_class.new.comision(menu_familiar)).to eq 175
    end
end
