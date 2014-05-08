require 'rubygems'

require 'coveralls'
Coveralls.wear!

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

def color(text, format = :yaml)
  CodeRay.scan(text, format).term
end
