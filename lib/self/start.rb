# -*- encoding : utf-8 -*-

module RubyTemplateApp

  class Application
    def self.start!(opts)
      # Note that this will block current thread.
      EventMachine.run do
        EventMachine.start_server(
            opts.host || RubyTemplateApp.config.default_host,
            opts.port || RubyTemplateApp.config.default_port,
            RubyTemplateApp::ApplicationController
        )
      end
    end
  end

end
