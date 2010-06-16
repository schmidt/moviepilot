require 'httparty'

module Moviepilot; end

require 'moviepilot/configuration'
require 'moviepilot/base'
require 'moviepilot/movie'
require 'moviepilot/movie/cast'
require 'moviepilot/movie/images'
require 'moviepilot/movie/neighbourhood'
require 'moviepilot/person'
require 'moviepilot/person/filmography'
require 'moviepilot/person/images'

module Moviepilot
  class << self
    attr_accessor :configuration

    def configure
      yield(configuration)
    end
  end

  self.configuration ||= Configuration.new
  configuration.base_url = 'http://www.moviepilot.de/'

  Exception = Class.new(StandardError)
end
