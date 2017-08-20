require 'httparty'
require 'json'
require 'dotenv'
dotenv.load

class WeatherForecast

  BASE_URI = ENV["WEATHER_URI"]
  API_KEY = ENV["WEATHER_API_KEY"]

  def initialize(city: 'Austin', days: 2)
    @days = days
  end

  def request
    @json = get_forecast
  end

  def city
    city_object = @json['city']

    {
      id: city_object['id'],
      name: city_object['name'],
      country: city_object['country']
    }
  end

  def hi_temps
    temp_map 'max'
  end

  def low_temps
    temp_map 'min'
  end

  def today
    trim_response(1)
  end

  def tomorrow
    trim_response(2)
  end

  private

  def get_forecast
    response = self.class.get('/forecast/daily', @options)
    JSON.parse(response.body)
  end

  def temp_map(value)
    @json['list'][0...@days].map do |day|
      day['temp'][value].round
    end
  end

  def trim_response(day_num)
    day = @json['list'][day_num - 1]
    weather = day['weather'].first
    {
      date: Time.at(day['dt']),
      day: day['temp']['day'].round,
      low: day['temp']['min'].round,
      high: day['temp']['max'].round,
      weather: [
        {
          main: weather['main'],
          description: weather['description']
        }
      ]
    }
  end
end
