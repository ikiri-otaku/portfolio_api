require 'octokit'
require 'uri'

class GithubClient
  class Error < StandardError; end

  def initialize
    @client = Octokit::Client.new(access_token: ENV.fetch('GITHUB_TOKEN', nil))
  end

  # def get_repo_stars(owner, repo)
  #   with_error_handling do
  #     repository = @client.repository("#{owner}/#{repo}")
  #     repository[:stargazers_count]
  #   rescue Octokit::NotFound => error
  #    Rails.logger.info "The repository named #{repo} is not owned by #{owner}"
  #   end
  # end

  def repository_exists?(owner, repo)
    with_error_handling do
      @client.repository?("#{owner}/#{repo}")
    end
  end

  def collaborator?(owner, repo, username)
    with_error_handling do
      @client.collaborator?("#{owner}/#{repo}", username)
    rescue Octokit::NotFound
      false
    end
  end

  def self.get_owner_and_repo(github_url)
    return nil if github_url.blank?

    uri = URI.parse github_url
    path = uri.path.split('/').compact_blank
    return nil if path.length != 2

    path # 0: owner, 1: repo
  end

  private

  def with_error_handling
    yield
  rescue Octokit::TooManyRequests
    raise Error, 'Rate limit exceeded: Please wait before making more requests.'
  rescue Octokit::Unauthorized
    raise Error, 'Unauthorized: Please check your GitHub token.'
  rescue Octokit::Forbidden
    raise Error, 'Forbidden: You do not have permission to access this resource.'
  rescue Octokit::Error => e
    raise Error, "An error occurred: #{e.message}"
  end
end
