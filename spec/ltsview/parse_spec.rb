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
      }.should eq("\e[45m---\e[0m\n\e[1;32m:hoge\e[0m: \e[1;33m\e[41mfuga hago\e[0m\n\e[1;32m:foo\e[0m: \e[1;33m\e[41mbarbaz\e[0m\n")
    end

    it 'shoild get json' do
      parse = Ltsview::Parse.new(['-j'])
      capture(:stdout) {
        $stdin = StringIO.new
        $stdin << "hoge:fuga hago\tfoo:barbaz\n"
        $stdin.rewind
        parse.print
      }.should eq("{\e[35m\"hoge\"\e[0m:\e[32m\e[1;32m\"\e[0m\e[32mfuga hago\e[1;32m\"\e[0m\e[32m\e[0m,\e[35m\"foo\"\e[0m:\e[32m\e[1;32m\"\e[0m\e[32mbarbaz\e[1;32m\"\e[0m\e[32m\e[0m}\n")
    end

    it 'should get non-colored ltsv' do
      parse = Ltsview::Parse.new(['-l'])
      capture(:stdout) {
        $stdin = StringIO.new
        $stdin << "hoge:fuga hago\tfoo:barbaz\n"
        $stdin.rewind
        parse.print
      }.should eq("hoge:fuga hago\tfoo:barbaz\n")
    end
  end

  describe 'when appended tag' do
    it 'should apeended tag' do
      parse = Ltsview::Parse.new(['-t', 'test.tag'])
      capture(:stdout) {
        $stdin = StringIO.new
        $stdin << "hoge:fuga hago\tfoo:barbaz\n"
        $stdin.rewind
        parse.print
      }.should eq("@[test.tag] \e[45m---\e[0m\n\e[1;32m:hoge\e[0m: \e[1;33m\e[41mfuga hago\e[0m\n\e[1;32m:foo\e[0m: \e[1;33m\e[41mbarbaz\e[0m\n")
    end
  end

  describe 'when encode ltsv format file' do
    it 'should load ltsv' do
      parse = Ltsview::Parse.new(['-f','spec/test.ltsv'])
      capture(:stdout){
        parse.print
      }.should eq("\e[45m---\e[0m\n\e[1;32m:hoge\e[0m: \e[1;33m\e[41mfuga hago\e[0m\n\e[1;32m:foo\e[0m: \e[1;33m\e[41mbarbaz\e[0m\n")
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
      }.should eq("\e[45m---\e[0m\n\e[1;32m:foo\e[0m: \e[1;33m\e[41mbarbaz\e[0m\n")
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
      }.should eq("\e[45m---\e[0m\n\e[1;32m:hoge\e[0m: \e[1;33m\e[41mfuga hago\e[0m\n")
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
        }.should eq("\e[45m---\e[0m\n\e[1;32m:hago\e[0m: \e[1;33m\e[41mfuga2 hago\e[0m\n\e[1;32m:foo\e[0m: \e[1;33m\e[41mfugabarbaz\e[0m\n")
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
      }.should eq("\e[45m---\e[0m\n\e[1;32m:hoge\e[0m: \e[1;33m\e[41mfuga hago\e[0m\n\e[1;32m:foo\e[0m: \e[1;33m\e[41mbarbaz\e[0m\n")
    end

    it 'should by color mode off' do
      parse = Ltsview::Parse.new(['--no-colors'])
      capture(:stdout){
        $stdin = StringIO.new
        $stdin << "hoge:fuga hago\tfoo:barbaz\n"
        $stdin.rewind
        parse.print
      }.should eq("---\n:hoge: fuga hago\n:foo: barbaz\n")
    end

  end

end

