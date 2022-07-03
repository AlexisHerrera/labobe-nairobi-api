# rubocop:disable Metrics/MethodLength
def configurar_api_dia_lluvioso(token)
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

  stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?appid=#{token}&lat=-34.36&lon=-58.26")
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v1.3.0'
      }
    )
    .to_return(status: 200, body: body.to_json, headers: {})
end

def configurar_api_dia_sin_lluvia(token)
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

  stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?appid=#{token}&lat=-34.36&lon=-58.26")
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v1.3.0'
      }
    )
    .to_return(status: 200, body: body.to_json, headers: {})
end
# rubocop:enable Metrics/MethodLength
