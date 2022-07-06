describe MockAPIClimaLluvia do
  it 'devuelve true cuando le preguntan si esta lloviendo' do
    expect(described_class.new.esta_lloviendo?).to eq true
  end
end

describe MockAPIClimaSinLluvia do
  it 'devuelve false cuando le preguntan si esta lloviendo' do
    expect(described_class.new.esta_lloviendo?).to eq false
  end
end
