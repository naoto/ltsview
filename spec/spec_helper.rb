require 'rubygems'
require 'ltsview'

require 'coveralls'
Coveralls.wear!

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  rescue => e
    puts "Error : #{e}"
  ensure
    eval "$#{stream} = #{stream.upcase}"
  end
  result
end
