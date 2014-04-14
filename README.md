# IndexHtml

Quickly generate the index.html files based on your select criteria.

## Installation

Add this line to your application's Gemfile:

    gem 'index_html'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install index_html

## Usage

Say you have lots of ebook files (pdf, epub, or mobi) and you have properly named them
using [ebook_renamer](https://rubygems.org/gems/ebook_renamer).

Let says you want to generate the index to all of the files that have the word 'Android' in in the title you could
perhap try something like the following:

```ruby
gem install index_html
cd ~/Dropbox/ebooks/
index_html generate --base-dir . --exts epub pdf mobi --inc-words android --output index_android.html
```

This will generate the file `android_index.html` that you can open from your favourite browser.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
