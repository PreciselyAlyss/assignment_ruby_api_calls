require './lib/github'

describe RepoAssignment do

  let(:gitub) { described_class.new('preciselyalyss') }

  # https://robots.thoughtbot.com/how-to-stub-external-services-in-tests
  before(:each) do
    stub_request(:get, /api.github.com/).
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: "stubbed response", headers: {})
  end

  describe '#initialize' do
    it 'sets username variable' do
      expect(github.user).to eq("preciselyalyss")
    end
  end

  # https://robots.thoughtbot.com/how-to-stub-external-services-in-tests
  describe '#list_repos' do
    it 'queries for repos based on provided username' do
      # replace URI
      uri = URI('https://api.github.com/repos/thoughtbot/factory_girl/contributors')
      response = Net::HTTP.get(uri)
      expect(response).to be_an_instance_of(String)
    end
  end

  describe '#list_commits' do
    # stuff here
  end
end
