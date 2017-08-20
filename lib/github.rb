require 'httparty'
require 'json'
require 'github'
require 'dotenv'
require 'logging'
dotenv.load

# Due to github gem, avoid open classes
class RepoAssignment
  attr_reader :user
  github = Github.new oauth_token: ENV["GITHUB_OAUTH_TOKEN"]
  logger = Logging.logger(STDOUT)

  def initialize(username:'preciselyalyss')
    @user = username
  end

  def list_repos(num)
    # list number of repos as passed in argument
    high = num - 1
    begin
      @repos = github.repos.list[0..high].map { |repo| repo['name'] }
    rescue Github::Error::GithubError => e
      puts e.message
      if e.is_a? Github::Error::ServiceError
        logger.error "Service error occurred"
      elsif e.is_a? Github::Error::ClientError
        logger.error "Client error occurred"
      end
    end
  end

  def list_commits
    # include sleep
    @repos.each do |repo_name|
      p "Last 10 commit messages for #{repo_name}:"
      commits = github.repos
                  .commits
                  .list(@user, repo_name)
                  .map { |c| c['commit']['message'] }
      commit_num = commits.count
      p commits[(commit_num - 10)..-1]
      # double quotes around new lines
      p "\n\n"
      sleep 0.2
    end
  end
end
