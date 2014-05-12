## index_html

[![Gem Version](https://badge.fury.io/rb/index_html.svg)][gem]
[![Dependency Status](https://gemnasium.com/agilecreativity/index_html.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/agilecreativity/index_html.png)][codeclimate]

[gem]: http://badge.fury.io/rb/index_html
[gemnasium]: https://gemnasium.com/agilecreativity/index_html
[codeclimate]: https://codeclimate.com/github/agilecreativity/index_html

Quickly generate the index.html files based on your simple criteria.

Note: start from version `0.1.2` this gem will follow the [Semantic Versioning][] release schedule.

### Installation

Add this line to your application's Gemfile:

    gem 'index_html'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install index_html

### Usage

Say you have lots of ebook files (pdf, epub, or mobi) and you have properly named them
with something like [ebook_renamer][].

Now that you have the good data, if you like to create a quick index to all of the files
that have the specific word 'Android' in the title you could perhap try something like the following:

```sh
gem install index_html
cd ~/Dropbox/ebooks/
index_html generate --base-dir . \
                    --exts epub pdf mobi  \
                    --inc-words android \
                    --recursive
```

### Help/Usage:

Just type `index_html` without any options to see the list of help

```
Usage:
  index_html generate

Options:
  -b, [--base-dir=BASE_DIR]                # Base directory
                                           # Default: . (current directory)
  -e, [--exts=one two three]               # List of extensions to search for
  -f, [--non-exts=one two three]           # List of files without extension to search for
  -n, [--inc-words=one two three]          # List of words to be included in the result if any
  -x, [--exc-words=one two three]          # List of words to be excluded from the result if any
  -i, [--ignore-case], [--no-ignore-case]  # Match case insensitively
                                           # Default: true
  -r, [--recursive], [--no-recursive]      # Search for files recursively
                                           # Default: true
  -v, [--version], [--no-version]          # Display version information
  -p, [--prefix=PREFIX]                    # Prefix string to the URL
                                           # Default: .
  -d, [--indent=N]                         # Indentation to each list item in the output
                                           # Default: 6
  -o, [--output=OUTPUT]                    # Output file name
                                           # Default: index.html

Generate the index.html base on simple criteria
```

This will generate the file `index.html` that you can open from your favourite browser.

### Sample output

- Sample list of files from a given directory

```shell
$index_html generate --base-dir=spec/fixtures --exts=rb java --recursive
```
The output file `index.html` should be generated with something like

```html
<html>
<title>File Listing</title>
<header>File List</header>
  <body>
    <ol>
      <li><a href="./demo1.xxx.java" target="_blank">./demo1.xxx.java</li>
      <li><a href="./demo1.xxx.rb" target="_blank">./demo1.xxx.rb</li>
      <li><a href="./demo2.xxx.java" target="_blank">./demo2.xxx.java</li>
      <li><a href="./demo2.xxx.rb" target="_blank">./demo2.xxx.rb</li>
      <li><a href="./sub-dir/demo3.yyy.java" target="_blank">./sub-dir/demo3.yyy.java</li>
      <li><a href="./sub-dir/demo3.yyy.rb" target="_blank">./sub-dir/demo3.yyy.rb</li>
      <li><a href="./sub-dir/demo4.yyy.java" target="_blank">./sub-dir/demo4.yyy.java</li>
      <li><a href="./sub-dir/demo4.yyy.rb" target="_blank">./sub-dir/demo4.yyy.rb</li>
    </ol>
  </body>
</html>
```
- Run with simple prefix option

```shell
index_html generate --base-dir spec/fixtures --exts rb java --recursive --prefix http://localhost
```

The output file `index.html` should be something like

```html
<html>
<title>File Listing</title>
<header>File List</header>
  <body>
    <ol>
      <li><a href="http://localhost/demo1.xxx.java" target="_blank">http://localhost/demo1.xxx.java</li>
      <li><a href="http://localhost/demo1.xxx.rb" target="_blank">http://localhost/demo1.xxx.rb</li>
      <li><a href="http://localhost/demo2.xxx.java" target="_blank">http://localhost/demo2.xxx.java</li>
      <li><a href="http://localhost/demo2.xxx.rb" target="_blank">http://localhost/demo2.xxx.rb</li>
      <li><a href="http://localhost/sub-dir/demo3.yyy.java" target="_blank">http:/localhost/sub-dir/demo3.yyy.java</li>
      <li><a href="http://localhost/sub-dir/demo3.yyy.rb" target="_blank">http://localhost/sub-dir/demo3.yyy.rb</li>
      <li><a href="http://localhost/sub-dir/demo4.yyy.java" target="_blank">http://localhost/sub-dir/demo4.yyy.java</li>
      <li><a href="http://localhost/sub-dir/demo4.yyy.rb" target="_blank">http://localhost/sub-dir/demo4.yyy.rb</li>
    </ol>
  </body>
</html>
```
### Contributing

Bug reports and suggestions for improvements are always welcome,
GitHub pull requests are even better!.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[agile_utils]: https://rubygems.org/gems/agile_utils
[code_lister]: https://rubygems.org/gems/code_lister
[ebook_renamer]: https://rubygems.org/gems/ebook_renamer
[rubocop]: https://github.com/bbatsov/rubocop
[Semantic Versioning]: http://semver.org
