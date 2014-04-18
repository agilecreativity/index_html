## IndexHtml

[![Gem Version](https://badge.fury.io/rb/index_html.svg)](http://badge.fury.io/rb/index_html)

Quickly generate the index.html files based on your simple criteria.

### Installation

Add this line to your application's Gemfile:

    gem 'index_html'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install index_html

### Usage

Say you have lots of ebook files (pdf, epub, or mobi) and you have properly named them
with something like [ebook_renamer](https://rubygems.org/gems/ebook_renamer).

Now that you have the good inputs, if you like to create a quick index to all of the files
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
  index_html generate [OPTIONS]

Options:
  -b, [--base-dir=BASE_DIR]                # Base directory
                                           # Default: . (current directory)
  -e, [--exts=one two three]               # List of extensions to search for
  -n, [--inc-words=one two three]          # List of words to be included in the result if any
  -x, [--exc-words=one two three]          # List of words to be excluded from the result if any
  -i, [--ignore-case], [--no-ignore-case]  # Match case insensitively
                                           # Default: true
  -r, [--recursive], [--no-recursive]      # Search for files recursively
                                           # Default: true
  -p, [--prefix=PREFIX]                    # Prefix string to the URL
  d, [--indent=N]                          # Indentation to each list item in the output
                                           # Default: 6
  -o, [--output=OUTPUT]                    # Output file name
                                           # Default: index.html
  -v, [--version], [--no-version]          # Display version information

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
      <li><a href="./spec/fixtures/demo1.xxx.java" target="_blank">./spec/fixtures/demo1.xxx.java</li>
      <li><a href="./spec/fixtures/demo1.xxx.rb" target="_blank">./spec/fixtures/demo1.xxx.rb</li>
      <li><a href="./spec/fixtures/demo2.xxx.java" target="_blank">./spec/fixtures/demo2.xxx.java</li>
      <li><a href="./spec/fixtures/demo2.xxx.rb" target="_blank">./spec/fixtures/demo2.xxx.rb</li>
      <li><a href="./spec/fixtures/sub-dir/demo3.yyy.java" target="_blank">./spec/fixtures/sub-dir/demo3.yyy.java</li>
      <li><a href="./spec/fixtures/sub-dir/demo3.yyy.rb" target="_blank">./spec/fixtures/sub-dir/demo3.yyy.rb</li>
      <li><a href="./spec/fixtures/sub-dir/demo4.yyy.java" target="_blank">./spec/fixtures/sub-dir/demo4.yyy.java</li>
      <li><a href="./spec/fixtures/sub-dir/demo4.yyy.rb" target="_blank">./spec/fixtures/sub-dir/demo4.yyy.rb</li>
    </ol>
  </body>
</html>
```
- Run with simple prefix option

```shell
index_html generate --base-dir spec/fixtures --exts rb java --recursive --prefix http://localhost/
```

The output file `index.html` should be something like

```html
<html>
<title>File Listing</title>
<header>File List</header>
  <body>
    <ol>
      <li><a href="http://localhost//spec/fixtures/demo1.xxx.java" target="_blank">http://localhost//spec/fixtures/demo1.xxx.java</li>
      <li><a href="http://localhost//spec/fixtures/demo1.xxx.rb" target="_blank">http://localhost//spec/fixtures/demo1.xxx.rb</li>
      <li><a href="http://localhost//spec/fixtures/demo2.xxx.java" target="_blank">http://localhost//spec/fixtures/demo2.xxx.java</li>
      <li><a href="http://localhost//spec/fixtures/demo2.xxx.rb" target="_blank">http://localhost//spec/fixtures/demo2.xxx.rb</li>
      <li><a href="http://localhost//spec/fixtures/sub-dir/demo3.yyy.java" target="_blank">http://localhost//spec/fixtures/sub-dir/demo3.yyy.java</li>
      <li><a href="http://localhost//spec/fixtures/sub-dir/demo3.yyy.rb" target="_blank">http://localhost//spec/fixtures/sub-dir/demo3.yyy.rb</li>
      <li><a href="http://localhost//spec/fixtures/sub-dir/demo4.yyy.java" target="_blank">http://localhost//spec/fixtures/sub-dir/demo4.yyy.java</li>
      <li><a href="http://localhost//spec/fixtures/sub-dir/demo4.yyy.rb" target="_blank">http://localhost//spec/fixtures/sub-dir/demo4.yyy.rb</li>
    </ol>
  </body>
</html>
```
### Known Issues

- Will be listed here if any

### Changelogs

#### 0.0.7

- Fix the bug in 'make_links' logic to make it generate the link properly

#### 0.0.6

- Fix the Rakefile to include the correct library

#### 0.0.5

- Always make the url relative in `make_links` method.

#### 0.0.4

- Update code_lister to 0.0.6 for new option and fix the mistake in '-d' option

#### 0.0.3

- Remove the code duplication by using the shared_option from code_lister gem

#### 0.0.2

- Initial release

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
