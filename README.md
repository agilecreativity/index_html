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
with something like [ebook_renamer](https://rubygems.org/gems/ebook_renamer).

Now that you havee the good inputs, if you like to create a quick index to all of the files
that have the word 'Android' in in the title you could perhap try something like the following:

```shell
gem install index_html
cd ~/Dropbox/ebooks/
index_html generate --base-dir . \
                    --exts epub pdf mobi  \
                    --inc-words android
```
## Help/Usage:
Just type `index_html` without any options to see the list of help

```
You are using index_html version 0.0.1

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

## My use-case

- Use to generate index for files from a particular publisher.
e.g. 'Oreilly', or 'Apress', or 'SitePoint', etc

- Use to generate index for a particular keyword like 'Android' or 'JQuery' etc

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
