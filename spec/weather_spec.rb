require './lib/weather'

describe WeatherForecast do

  let(:weather) { described_class.new }

  # https://robots.thoughtbot.com/how-to-stub-external-services-in-tests
  before(:each) do
    stub_request(:get, '/api.openweathermap.org/data/2.5').
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: "stubbed response", headers: {})
  end

  describe '#initialize' do
    it 'sets days variable'
  end

  describe '#request' do
    it 'something'
  end

  describe '#city' do
    it 'something'
  end

  describe '#hi_temps' do
    it 'something'
  end

  describe '#low_temps' do
    it 'something'
  end

  describe '#today' do
    it 'something'
  end

  describe '#tomorrow' do
    it 'something'
  end
end
