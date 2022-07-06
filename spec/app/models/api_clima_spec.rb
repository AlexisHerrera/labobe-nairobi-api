describe APIClima do
  it 'Cuando responde correctamente devuelve un 200' do
    configurar_api_dia_sin_lluvia
    expect(described_class.new('https://fake.clima.api').obtener_respuesta.status).to eq 200
  end

  it 'Cuando no responde correctamente devuelve un error' do
    configurar_api_responde_error
    expect { described_class.new('https://fake.clima.api').obtener_respuesta}.to raise_error(APIError)
  end

  it 'Cuando responde correctamente tiene un clima' do
    configurar_api_dia_sin_lluvia
    request = described_class.new('https://fake.clima.api').obtener_respuesta
    clima_obtenido = JSON.parse(request.body).symbolize_keys[:weather]
    expect(clima_obtenido).not_to be nil
  end

  it 'Cuando no obtiene un clima por error, devuelve que no esta lloviendo' do
    configurar_api_responde_error
    expect(described_class.new('https://fake.clima.api').esta_lloviendo?).to eq false
  end
end

# rubocop:disable Metrics/MethodLength
def configurar_api_dia_lluvioso
  # TODO: eliminar codigo repetido
  body = {
    "coord": {
      "lon": -58.26,
      "lat": -34.36
    },
    "weather": [
      {
        "id": 500,
        "main": 'Rain',
        "description": 'light rain',
        "icon": '10d'
      }
    ],
    "base": 'stations',
    "main": {
      "temp": 285.72,
      "feels_like": 284.52,
      "temp_min": 285.19,
      "temp_max": 287.77,
      "pressure": 1021,
      "humidity": 57,
      "sea_level": 1021,
      "grnd_level": 1021
    },
    "visibility": 10_000,
    "wind": {
      "speed": 4.11,
      "deg": 139,
      "gust": 4.15
    },
    "clouds": {
      "all": 46
    },
    "dt": 1_656_874_517,
    "sys": {
      "type": 1,
      "id": 8224,
      "country": 'AR',
      "sunrise": 1_656_845_992,
      "sunset": 1_656_881_660
    },
    "timezone": -10_800,
    "id": 3_436_508,
    "name": 'Acassuso',
    "cod": 200
  }

  stub_request(:get, "https://fake.clima.api")
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v1.3.0'
      }
    )
    .to_return(status: 200, body: body.to_json, headers: {})
end

def configurar_api_dia_sin_lluvia
  body = {
    "coord": {
      "lon": -58.26,
      "lat": -34.36
    },
    "weather": [
      {
        "id": 802,
        "main": 'Clouds',
        "description": 'scattered clouds',
        "icon": '03d'
      }
    ],
    "base": 'stations',
    "main": {
      "temp": 285.72,
      "feels_like": 284.52,
      "temp_min": 285.19,
      "temp_max": 287.77,
      "pressure": 1021,
      "humidity": 57,
      "sea_level": 1021,
      "grnd_level": 1021
    },
    "visibility": 10_000,
    "wind": {
      "speed": 4.11,
      "deg": 139,
      "gust": 4.15
    },
    "clouds": {
      "all": 46
    },
    "dt": 1_656_874_517,
    "sys": {
      "type": 1,
      "id": 8224,
      "country": 'AR',
      "sunrise": 1_656_845_992,
      "sunset": 1_656_881_660
    },
    "timezone": -10_800,
    "id": 3_436_508,
    "name": 'Acassuso',
    "cod": 200
  }

  stub_request(:get, "https://fake.clima.api")
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v1.3.0'
      }
    )
    .to_return(status: 200, body: body.to_json, headers: {})
end

def configurar_api_responde_error
  stub_request(:get, "https://fake.clima.api")
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v1.3.0'
      }
    )
    .to_return(status: 404, body: {"error": "token failed"}.to_json, headers: {})
end
# rubocop:enable Metrics/MethodLength
