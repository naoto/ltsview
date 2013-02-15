require 'spec_helper'
require 'ltsview/parse'

describe Ltsview::Parse do

  describe 'when encode stdin text line' do
    it 'should get yaml' do
      parse = Ltsview::Parse.new(ARGV)
      capture(:stdout) {
        $stdin = StringIO.new
        $stdin << "hoge:fuga hago\tfoo:barbaz\n"
        $stdin.rewind
        parse.print
      }.must_equal("\e[35mhoge\e[0m: \e[36mfuga hago\e[0m\n\e[35mfoo\e[0m: \e[36mbarbaz\e[0m\n")
    end
  end

  describe 'when encode ltsv format file' do
    it 'should load ltsv' do
      parse = Ltsview::Parse.new(['-f','spec/test.ltsv'])
      capture(:stdout){
        parse.print
      }.must_equal("\e[35mhoge\e[0m: \e[36mfuga hago\e[0m\n\e[35mfoo\e[0m: \e[36mbarbaz\e[0m\n")
    end
  end


  describe 'when key select' do
    it 'should by key select' do
      parse = Ltsview::Parse.new(['-k','foo'])
      capture(:stdout){
        $stdin = StringIO.new
        $stdin << "hoge:fuga hago\tfoo:barbaz\n"
        $stdin.rewind
        parse.print
      }.must_equal("\e[35mfoo\e[0m: \e[36mbarbaz\e[0m\n")
    end
  end

  describe 'when ignore key select' do
    it 'should by igonore key select' do
      parse = Ltsview::Parse.new(['-i','foo'])
      capture(:stdout){
        $stdin = StringIO.new
        $stdin << "hoge:fuga hago\tfoo:barbaz\n"
        $stdin.rewind
        parse.print
      }.must_equal("\e[35mhoge\e[0m: \e[36mfuga hago\e[0m\n")
    end
  end

  describe 'when regex matche' do
    it 'should by regex matcher' do
      parse = Ltsview::Parse.new(['-r', 'foo:^fuga'])
      capture(:stdout){
        $stdin = StringIO.new
        $stdin << "hago:fuga hago\tfoo:barbaz\n"
        $stdin << "hago:fuga2 hago\tfoo:fugabarbaz\n"
        $stdin.rewind
        parse.print
      }.must_equal("\e[35mhago\e[0m: \e[36mfuga2 hago\e[0m\n\e[35mfoo\e[0m: \e[36mfugabarbaz\e[0m\n")
    end
  end

  describe 'when color mode' do
    it 'should by default color mode on' do
      parse = Ltsview::Parse.new(ARGV)
      capture(:stdout){
        $stdin = StringIO.new
        $stdin << "hoge:fuga hago\tfoo:barbaz\n"
        $stdin.rewind
        parse.print
      }.must_equal("\e[35mhoge\e[0m: \e[36mfuga hago\e[0m\n\e[35mfoo\e[0m: \e[36mbarbaz\e[0m\n")
    end

    it 'should by color mode off' do
      parse = Ltsview::Parse.new(['--no-colors'])
      capture(:stdout){
        $stdin = StringIO.new
        $stdin << "hoge:fuga hago\tfoo:barbaz\n"
        $stdin.rewind
        parse.print
      }.must_equal("hoge: fuga hago\nfoo: barbaz\n")
    end

  end

end

