module IndexHtml
  class Main
    class << self
      def run(options = {})
        files = CodeLister.files options || []
        unless files.empty?
          puts "FYI: your options #{options}"
          IndexHtml.htmlify files, options
          puts "FYI: your result is in #{options[:output]}"
        else
          puts "No match found for your options :#{options}"
        end
      end
    end
  end
end
