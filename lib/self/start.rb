# -*- encoding : utf-8 -*-

module RubyTemplateApp

  class Application
    def self.start!
      # Note that this will block current thread.
      EventMachine.run do
        EventMachine.start_server(
            RubyTemplateApp.config.default_host,
            RubyTemplateApp.config.default_port,
            RubyTemplateApp::ApplicationController
        )
      end
    end
  end

end
