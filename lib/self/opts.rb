# -*- encoding : utf-8 -*-

require 'optparse'
require 'optparse/time'
require 'ostruct'

class OptParser

  #
  # Return a structure describing the options.
  #
  def self.parse(args)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new

    options.verbose = false

    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: script/server [options]'

      opts.separator ''
      opts.separator 'Specific options:'

      # Port, default in config/application.rb.
      opts.on('-p', '--port PORT', 'Start server on specified port') do |port|
        options.port = port.to_i
      end

      # Host, default in config/application.rb.
      opts.on('-h', '--host HOST', 'Start server on specified host') do |host|
        options.host = host
      end

      # Boolean switch.
      opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
        options.verbose = v
      end

      opts.separator ''
      opts.separator 'Common options:'

      # No argument, shows at tail.  This will print an options summary.
      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end
    end

    opt_parser.parse!(args)
    options
  end

end
