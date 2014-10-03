module IndexHtml
  CustomError = Class.new(StandardError)
  class << self
    # Create html links for a given list of files
    #
    # @param [Array<String>] file_list list of input file
    # @param [Hash<Synbol, Object>] args the argument hash
    def htmlify(file_list, args = {})
      header = <<-END.gsub(/^\s+\|/, "")
        |<html>
        |<title>File Listing</title>
        |<header>File List</header>
        |  <body>
        |    <ol>
        END

      footer = <<-END.gsub(/^\s+\|/, "")
        |    </ol>
        |  </body>
        |</html>
        END

      indent = args.fetch(:indent, 6)
      output = args.fetch(:output, "index.html")

      File.open(output, "w") do |file|
        file.write(header)
        links = make_links file_list, prefix:   args.fetch(:prefix, ".") ,
                                      base_dir: args[:base_dir],
                                      drop_ext: args.fetch(:drop_ext, false)
        links.each { |link| file.write("#{" " * indent}#{link}\n") }
        file.write(footer)
      end
    end

    # Transform the list of full path to list of base name
    #
    # @param [Array<String>] file_list input file list
    # @param [Hash<Symbol, Object>] args list of options
    #
    # @return [Array<String>] list of basename of a given input file
    def basenames!(file_list, args = {})
      file_list.map! { |file| File.basename(file) } if args.fetch(:basename, false)
      file_list
    end

    def escape_uris!(file_list, args = {})
      if args.fetch(:encoded, false)
        file_list.map! { |file| URI.escape(file, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")) }
      end
      file_list
    end

    # Make links using <li> tags
    #
    # @param [Array<String>] file_list the input file list
    # @param [Hash<Symbol,Object>] args the option hash
    #
    # @return [Array<String>] the list of valid <li> tags
    def make_links(file_list, args)
      prefix   = args.fetch(:prefix, ".")
      drop_ext = args.fetch(:drop_ext, false)
      result = []
      file_list.each do |file|
        path = File.absolute_path(file).gsub(Dir.pwd, "")
        if prefix
          # link =  %Q(<li><a href="#{prefix}#{drop_ext ? drop_extension(path): path}" target='_blank'>#{prefix}#{path}</li>)
          link =  %Q(<li><a href="#{prefix}#{path}" target='_blank'>#{prefix}#{drop_last_ext(path, drop_ext)}</li>)
        else
          # add "." in front of the link and drop the last extension
          # link =  %Q(<li><a href=".#{drop_ext ? drop_extension(path) : path}" target='_blank'>#{path.gsub(/^\//, "")}</li>)
          # at this point path always start with "/"
          link =  %Q(<li><a href=".#{path}" target='_blank'>#{drop_last_ext(path.gsub(/^\//, ""), drop_ext)}</li>)
        end
        result << link
      end
      result
    end

    # Wrapper method to call the drop_extension if applicable
    #
    # @param [String] link the input link
    # @param [Boolean] flag the boolean flag
    # @return (see #drop_extension)
    def drop_last_ext(link, flag = false)
      if flag
        drop_extension(link)
      else
        link
      end
    end

    # Drop string after the last '.' dot string if any
    #
    # @param [String] link the input link
    # @return [String] the new string with extension drop if any
    # @example
    #  drop_extension("some_file")                  == "some_file"
    #  drop_extension("some_file.txt")              == "some_file"
    #  drop_extension("/path/to/some_file")         == "/path/to/some_file"
    #  drop_extension("/path/to/some_file.txt")     == "/path/to/some_file"
    #  drop_extension("/path/to/some_file.txt.pdf") == "/path/to/some_file.txt"
    def drop_extension(link)
      dot_index = link.rindex(".")
      if dot_index
        link[0..(dot_index - 1)]
      else
        link
      end
    end
  end
end
