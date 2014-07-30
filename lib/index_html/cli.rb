require "thor"
require "agile_utils"
require_relative "../index_html"
module IndexHtml
  class CLI < Thor
    using AgileUtils::HashExt

    # rubocop:disable AmbiguousOperator, LineLength
    desc "generate", "Generate the index.html base on simple criteria"
    # Common shared options
    method_option *AgileUtils::Options::BASE_DIR
    method_option *AgileUtils::Options::EXTS
    method_option *AgileUtils::Options::NON_EXTS
    method_option *AgileUtils::Options::INC_WORDS
    method_option *AgileUtils::Options::EXC_WORDS
    method_option *AgileUtils::Options::IGNORE_CASE
    method_option *AgileUtils::Options::RECURSIVE
    method_option *AgileUtils::Options::VERSION

    # specific to this action only
    method_option :prefix,
                  aliases: "-p",
                  desc: "Prefix string to the URL",
                  default: "."
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
      opts = options.symbolize_keys
      if opts[:version]
        puts "You are using IndexHtml Version #{IndexHtml::VERSION}"
        exit
      end
      run(opts)
    end

    desc "usage", "Display help screen"
    def usage
      puts <<-EOS
Usage:
  index_html

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
      EOS
    end
    # rubocop:enable AmbiguousOperator, LineLength

    default_task :usage

  private

    def run(options = {})
      files = CodeLister.files options || []
      if files.empty?
        puts "No match found for your options :#{options}"
      else
        IndexHtml.htmlify files, options
        puts "FYI: your result is in #{options[:output]}"
      end
    end
  end
end
