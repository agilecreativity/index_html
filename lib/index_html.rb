require 'uri'
require_relative "./index_html/version"
require_relative "./index_html/cli"
require_relative "./index_html/main"
require_relative "./active_support/core_ext/hash/hash"
require_relative "./active_support/core_ext/kernel/reporting"

module IndexHtml

  CustomError = Class.new(StandardError)

  class << self

    # Create html links to list of files
    def htmlify(file_list, args = {})

      header = <<-END.gsub(/^\s+\|/, '')
        |<html>
        |<title>File Listing</title>
        |<header>File List</header>
        |  <body>
        |    <ol>
        END

      footer = <<-END.gsub(/^\s+\|/, '')
        |    </ol>
        |  </body>
        |</html>
        END

      # our options
      prefix = args.fetch(:prefix, "")
      indent = args.fetch(:indent, 6)
      output = args.fetch(:output, "index.html")

      # write the output to files
      File.open(output, "w") do |f|
        f.write(header)
        make_links(file_list, prefix: prefix).each { |i| f.write("#{' ' * indent}#{i}\n") }
        f.write(footer)
      end
    end

    # Transform the list of full path to list of base name
    #
    # @param [Array<String>] file_list if of file path
    # @param [Hash<Symbol, Object>] args list of options
    #
    # @return [Array<String>] list of basename of a given input file
    def basenames!(file_list, args = {})
      file_list.map!{ |file| File.basename(file) } if args.fetch(:basename, false)
      file_list
    end

    def escape_uris!(file_list, args = {})
      if args.fetch(:encoded, false)
        file_list.map!{ |file| URI.escape(file, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")) }
      end
      file_list
    end

    # Make links using <li> tags
    #
    # @return [Array] the list of valid <li> tags
    def make_links(file_list, args = {})
      original_links = file_list
      escape_uris!(file_list, args)
      file_list = basenames!(file_list, args)

      prefix = args.fetch(:prefix, "")

      result = []
      original_links.zip(file_list).each do |i,j|
        result << %Q{<li><a href="#{prefix}#{j}" target="_blank">#{i}</li>}
      end
      result
    end

  end
end
