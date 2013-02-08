# Ltsview

Ltsview - Labeled Tab Separated Value manipulator Viewer

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

ignore key select

    $ cat logfile.ltsv | ltsview -i firstkey,secondkey

### Option

 *  `-k , --keys VAL` to display keys select
 *  `-i, --ignore-key VAL` to ignore keys select display

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
