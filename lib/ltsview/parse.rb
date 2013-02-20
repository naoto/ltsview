module Ltsview
  class Parse

    def initialize(options)
      @options = {
        mode:       :yaml,
        color:      true,
        file:       nil,
        keys:       nil,
        ignore_key: nil,
        regex:      nil
      }
      option_parse options
    end

    def print
      file_or_stdin do |ltsv|
        line = formatter(filter(ltsv))
        puts "#{tag}#{line}" unless line.nil?
        $stdout.flush
      end
    end

    private
     def option_parse(options)
       option = OptionParser.new(options)
       option.on('-f', '--file VAL'){ |v| @options[:file] = v }
       option.on('-k', '--keys VAL'){ |v| @options[:keys] = v.split(',') }
       option.on('-i', '--ignore-key VAL'){ |v| @options[:ignore_key] = v.split(',') }
       option.on('-r', '--regexp key:VAL', /\A([^:]+):(.*)/){ |_, k,v| @options[:regex] = {key: k.to_sym, value: v} }
       option.on('-j', '--json') { |v| @options[:mode] = :json }
       option.on('-t', '--tag VAL'){ |v| @options[:tag] = v }
       option.on('--[no-]colors'){ |v| @options[:color] = v }
       option.permute!(options)
     end

     def file_or_stdin(&block)
       if !@options[:file].nil?
         file_load(@options[:file], &block)
       else 
         stdin_load(&block)
       end
     end

     def stdin_load
       $stdin.each_line do |line|
         yield LTSV.parse(line.chomp).first
       end
     end

     def file_load(file_path)
       stream = File.open(file_path, 'r')
       LTSV.parse(stream).each do |line|
         yield line
       end
     end

     def formatter(ltsv)
       color ltsv.send("to_#{@options[:mode]}".to_sym), @options[:mode] unless ltsv.empty?
     end

     def tag
       "@[#{@options[:tag]}] " if @options[:tag]
     end

     def filter(ltsv)
       matcher(ltsv).delete_if do |key, val|
         !keys?(key) || ignore?(key)
       end
     end

     def matcher(ltsv)
       if !@options[:regex].nil? && ltsv[@options[:regex][:key]] !~ /(#{@options[:regex][:value]})/
         ltsv = {}
       end
       ltsv
     end

     def keys?(key)
       @options[:keys].nil? || @options[:keys].include?(key.to_s)
     end

     def ignore?(key)
       !@options[:ignore_key].nil? && @options[:ignore_key].include?(key.to_s)
     end

     def color(ltsv, mode)
       @options[:color] ? CodeRay.scan(ltsv, mode).term : ltsv
     end

  end
end
