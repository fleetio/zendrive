module Zendrive
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :user_agent,].freeze
    VALID_OPTIONS_KEYS    = [:api_key, :format].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT      = "https://api.zendrive.com"
    DEFAULT_USER_AGENT    = "Zendrive Ruby Gem #{Zendrive::VERSION}".freeze
    DEFAULT_API_KEY       = nil
    DEFAULT_FORMAT        = :json

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def reset
      self.endpoint   = DEFAULT_ENDPOINT
      self.user_agent = DEFAULT_USER_AGENT
      self.api_key    = DEFAULT_API_KEY
      self.format     = DEFAULT_FORMAT
    end
  end
end
