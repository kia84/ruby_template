# -*- encoding : utf-8 -*-

module RubyTemplateApp
  class ApplicationController < EventMachine::Connection

    def post_init
      puts '-- someone connected to the echo server!'
    end

    def receive_data(data)
      send_data ">>>you sent: #{data}"
      puts "#{data}"
      close_connection if data =~ /quit/i
    end

    def unbind
      puts '-- someone disconnected from the echo server!'
    end

  end
end
