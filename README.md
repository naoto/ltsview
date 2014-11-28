Ltsview
=================================================================

Ltsview - Labeled Tab Separated Value manipulator Viewer

[![Build Status](https://travis-ci.org/naoto/ltsview.png?branch=master)](https://travis-ci.org/naoto/ltsview)
[![Gem Version](https://badge.fury.io/rb/ltsview.png)](https://badge.fury.io/rb/ltsview)
[![Code CLimate](https://codeclimate.com/github/naoto/ltsview.png)](https://codeclimate.com/github/naoto/ltsview)
[![Coverage Status](https://coveralls.io/repos/naoto/ltsview/badge.png?branch=master)](https://coveralls.io/r/naoto/ltsview)


## Supported

 * OSX or Ubuntu
 * Ruby 1.9.3 or 2.0.0 or 2.1.0

## Installation

Add this line to your application's Gemfile:

    gem 'ltsview'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ltsview

## Usage

    $ cat logfile.ltsv | ltsview

 key select

    $ cat logfile.ltsv | ltsview -k firstkey,therdkey

  key select and reorder

    $ cat logfile.ltsv | ltsview -k firstkey,therdkey --reorder

 ignore key select

    $ cat logfile.ltsv | ltsview -i firstkey,secondkey

 regex key select

    $ cat logfile.ltsv | ltsview -r key:regex

 load file

    $ ltsview -f logfile.ltsv

 render json

    $ cat logfile.ltsv | ltsview -j

 raw mode

    $ cat logfile.ltsv | ltsview -l 

 appended tag

    $ cat logfile.ltsv | ltsview -t sample.tag

### Option

 * `-k` ,` --keys VAL` to display keys select
 * `-i`, `--ignore-key VAL` to ignore keys select display
 * `-r`, `--regexp KEY:VAL` 
 * `-f`, `--file VAL` to load ltsv format file
 * `-j`, `--json` to render json format
 * `-t`, `--tag` to append tag
 * `-l`, `--ltsv`  to raw format
 * `-o`, `--reorder` to reorder keys with `--keys` option
 * `--no-colors` to no color

### Inspired by

 * https://github.com/naoya/perl-Text-LTSV
 * http://d.hatena.ne.jp/naoya/20130207/1360229220

### Author

 * Naoto SHINGAKI

### Contributors (Thanks!)

 * [a2ikm](https://github.com/a2ikm/) 
 * [Tomohiro](https://github.com/Tomohiro/)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
