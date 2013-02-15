require 'rubygems'
require 'bundler/setup'

require 'minitest/unit'
require 'minitest/autorun'

require 'ltsview'

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
