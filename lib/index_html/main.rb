module IndexHtml
  class Main
    class << self
      def run(options = {})
        files = CodeLister.files options || []
        unless files.empty?
          IndexHtml.htmlify files, options
          puts "FYI: your result is in #{options[:output]}"
        else
          puts "No match found for your options :#{options}"
        end
      end
    end
  end
end
