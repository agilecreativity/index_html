require 'thor'
require_relative '../index_html'

module IndexHtml

  class CLI < CodeLister::BaseCLI
    desc 'generate', 'Generate the index.html base on simple criteria'

    shared_options

    method_option :prefix,
                  aliases: "-p",
                  desc: "Prefix string to the URL",
                  default: "" # empty string

    method_option :indent,
                  aliases: "-d",
                  desc: "Indentation to each list item in the output",
                  type: :numeric,
                  default: 6

    method_option :output,
                  aliases: "-o",
                  desc: "Output file name",
                  type: :string,
                  default: "index.html"

    def generate
      if options[:version]
        puts "You are using IndexHtml Version #{IndexHtml::VERSION}"
        exit
      end
      IndexHtml::Main.run(options.symbolize_keys)
    end

    desc "usage", "Display help screen"
    def usage
      puts <<-EOS
Usage:
  index_html generate [OPTIONS]

Options:
  -b, [--base-dir=BASE_DIR]                # Base directory
                                           # Default: /home/bchoomnuan/Dropbox/spikes/index_html
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
  -d, [--indent=N]                         # Indentation to each list item in the output
                                           # Default: 6
  -o, [--output=OUTPUT]                    # Output file name
                                           # Default: index.html

Generate the index.html base on simple criteria
      EOS
    end

    default_task :usage
  end
end
