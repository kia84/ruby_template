# -*- encoding : utf-8 -*-

module RubyTemplateApp
  class << self
    attr_accessor :config
  end

  # Configures global settings for our application
  #  RubyTemplateApp.configure do |config|
  #    config.default_host = 'localhost'
  #  end
  def self.configure
    yield @config ||= self::Configuration.new
  end

  class Configuration #:nodoc:
    attr_accessor :default_host,
                  :default_port

    def initialize
      @default_host = '127.0.0.1'
      @default_port = 8081
    end
  end
end
