module Ltsview
  class Parse

    def initialize(options)
      @ltsv = option_parse options
    end

    def print
      $stdin.each_line do |line|
        LTSV.parse(line).each do |key,val|
          puts "#{key.to_s.magenta}: #{val.cyan}"
        end
      end
    end

    private
     def option_parse(options)
       option = OptionParser.new
       option.on('-f VAL'){ |v| @file = v }
       option.permute!(options)
       options
     end

     def file_load(file_path)
       stream = File.open(file_path, 'r')
       LTSV.parse(stream)
     end

  end
end
