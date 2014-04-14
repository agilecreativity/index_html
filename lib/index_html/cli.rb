require 'thor'
require_relative '../index_html'

module IndexHtml
  #TODO: this should be re-use from the 'CodeLister' module
  class BaseCLI < Thor
    def self.shared_options

      method_option :base_dir,
                    aliases: "-b",
                    desc: "Base directory",
                    default: Dir.pwd

      method_option :exts,
                    aliases: "-e",
                    desc: "List of extensions to search for",
                    type: :array,
                    default: []

      method_option :inc_words,
                    aliases: "-n",
                    desc: "List of words to be included in the result if any",
                    type: :array,
                    default: []

      method_option :exc_words,
                    aliases: "-x",
                    desc: "List of words to be excluded from the result if any",
                    type: :array,
                    default: []

      method_option :ignore_case,
                    aliases: "-i",
                    desc: "Match case insensitively",
                    type: :boolean,
                    default: true

      method_option :recursive,
                    aliases: "-r",
                    desc: "Search for files recursively",
                    type: :boolean,
                    default: true
    end
  end

  class CLI < IndexHtml::BaseCLI
    desc 'generate', 'Generate the index.html base on simple criteria'
    shared_options

    method_option :prefix,
                  aliases: "-p",
                  desc: "Prefix string to the URL",
                  default: "" # empty string

    method_option :indent,
                  aliases: "d",
                  desc: "Indentation to each list item in the output",
                  type: :numeric,
                  default: 6

    method_option :output,
                  aliases: "-o",
                  desc: "Output file name",
                  type: :string,
                  default: "index.html"

    method_option :version,
                  aliases: "-v",
                  desc: "Display version information",
                  type: :boolean,
                  default: false

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
  cli.rb generate

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
      EOS
    end
    default_task :usage
  end
end
