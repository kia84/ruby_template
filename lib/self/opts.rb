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

    #options.library = []
    #options.inplace = false
    #options.transfer_type = :auto
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

=begin
      # Mandatory argument.
      opts.on('-r', '--require LIBRARY',
              'Require the LIBRARY before executing your script') do |lib|
        options.library << lib
      end

      # Optional argument; multi-line description.
      opts.on('-i', '--inplace [EXTENSION]',
              'Edit ARGV files in place',
              '  (make backup if EXTENSION supplied)') do |ext|
        options.inplace = true
        options.extension = ext || ''
        options.extension.sub!(/\A\.?(?=.)/, '.')  # Ensure extension begins with dot.
      end

      # Cast 'delay' argument to a Float.
      opts.on('--delay N', Float, 'Delay N seconds before executing') do |n|
        options.delay = n
      end

      # Cast 'time' argument to a Time object.
      opts.on('-t', '--time [TIME]', Time, 'Begin execution at given time') do |time|
        options.time = time
      end

      # Cast to octal integer.
      opts.on('-F', '--irs [OCTAL]', OptionParser::OctalInteger,
              'Specify record separator (default \\0)') do |rs|
        options.record_separator = rs
      end

      # List of arguments.
      opts.on('--list x,y,z', Array, "Example 'list' of arguments") do |list|
        options.list = list
      end

      # Optional argument with keyword completion.
      opts.on('--type [TYPE]', [:text, :binary, :auto],
              'Select transfer type (text, binary, auto)') do |t|
        options.transfer_type = t
      end
=end

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
