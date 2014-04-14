module IndexHtml
  class Main
    class << self
      def run(options = {})
        puts "IndexHtml::Main.run():"
        puts options
        files = CodeLister.files options || []
        unless files.empty?
          puts "Your result: #{files}"
          IndexHtml.htmlify files, options
        else
          puts "No match found for your options :#{options}"
        end
      end
    end
  end
end
