module Ltsview
  class Parse

    def initialize(options)
      @color = true
      option_parse options
    end

    def print
      file_or_stdin do |ltsv|
        filter(ltsv) do |key, val|
          puts color key, val
        end
      end
    end

    private
     def option_parse(options)
       option = OptionParser.new(options)
       option.on('-f', '--file VAL'){ |v| @file = v }
       option.on('-k', '--keys VAL'){ |v| @keys = v.split(',') }
       option.on('-i', '--ignore-key VAL'){ |v| @ignore_key = v.split(',') }
       option.on('-r', '--regexp key:VAL', /\A([^:]+):(.*)/){ |_, k,v| @regex = {key: k.to_sym, value: v} }
       option.on('--[no-]colors'){ |v| @color = v }
       option.permute!(options)
     end

     def file_or_stdin(&block)
       if !@file.nil?
         file_load(@file, &block)
       else 
         stdin_load(&block)
       end
     end

     def stdin_load
       $stdin.each_line do |line|
         yield LTSV.parse(line.chomp)
       end
     end

     def file_load(file_path)
       stream = File.open(file_path, 'r')
       LTSV.parse(stream).each do |line|
         yield line
       end
     end

     def filter(ltsv)
       matcher(ltsv).each do |key, val|
         yield key, val if keys?(key) && !ignore?(key)
       end
     end

     def matcher(ltsv)
       if !@regex.nil? && ltsv[@regex[:key]] !~ /(#{@regex[:value]})/
         ltsv = {}
       end
       ltsv
     end

     def keys?(key)
       @keys.nil? || @keys.include?(key.to_s)
     end

     def ignore?(key)
       !@ignore_key.nil? && @ignore_key.include?(key.to_s)
     end

     def color(key, val)
       @color ? "#{key.to_s.magenta}: #{val.cyan}" : "#{key}: #{val}"
     end

  end
end
