require_relative "../spec_helper"
describe IndexHtml do
  let(:files) do
    CodeLister.files base_dir: "spec/fixtures",
                     exts: %w[xxx.rb], recursive: true
  end

  context "#basenames!" do
    it "excludes full path of the files" do
      expect(IndexHtml.basenames!(files, basename: true)).to eq ["demo1.xxx.rb",
                                                                 "demo2.xxx.rb"]
    end

    it "includes full path of the files" do
      expect(IndexHtml.basenames!(files)).to eq ["./demo1.xxx.rb",
                                                 "./demo2.xxx.rb"]
      expect(IndexHtml.basenames!(files, basename: false)).to eq ["./demo1.xxx.rb",
                                                                  "./demo2.xxx.rb"]
    end
  end

  context "#escape_uris!" do
    it "works correctly with full path" do
      expect(IndexHtml.escape_uris!(files, encoded: true)).to eq [".%2Fdemo1.xxx.rb",
                                                                  ".%2Fdemo2.xxx.rb"]
    end
  end

  context "#htmlify" do
    let :files do
      CodeLister.files base_dir: "spec/fixtures",
                       exts: %w[rb java],
                       recursive: true
    end

    it "generates simple index file" do
      FileUtils.rm_rf("index.html")
      IndexHtml.htmlify files,
                        indent: 6,
                        output: "index.html",
                        base_dir: "spec/fixtures"

      expect(File.read("index.html")).to eq \
        <<-EOT
<html>
<title>File Listing</title>
<header>File List</header>
  <body>
    <ol>
      <li><a href="./demo1.xxx.java" target='_blank'>./demo1.xxx.java</li>
      <li><a href="./demo1.xxx.rb" target='_blank'>./demo1.xxx.rb</li>
      <li><a href="./demo2.xxx.java" target='_blank'>./demo2.xxx.java</li>
      <li><a href="./demo2.xxx.rb" target='_blank'>./demo2.xxx.rb</li>
      <li><a href="./sub-dir/demo3.yyy.java" target='_blank'>./sub-dir/demo3.yyy.java</li>
      <li><a href="./sub-dir/demo3.yyy.rb" target='_blank'>./sub-dir/demo3.yyy.rb</li>
      <li><a href="./sub-dir/demo4.yyy.java" target='_blank'>./sub-dir/demo4.yyy.java</li>
      <li><a href="./sub-dir/demo4.yyy.rb" target='_blank'>./sub-dir/demo4.yyy.rb</li>
    </ol>
  </body>
</html>
      EOT
    end

    it "generates simple index file with prefix" do
      FileUtils.rm_rf("index.html")
      IndexHtml.htmlify files,
                        indent: 6,
                        output: "index.html",
                        prefix: "http://agilecreativity.com/public",
                        base_dir: "spec/fixtures" # Note: must not puts the '/' at the end!
      expect(File.read("index.html")).to eq \
        <<-EOT
<html>
<title>File Listing</title>
<header>File List</header>
  <body>
    <ol>
      <li><a href="http://agilecreativity.com/public/demo1.xxx.java" target='_blank'>http://agilecreativity.com/public/demo1.xxx.java</li>
      <li><a href="http://agilecreativity.com/public/demo1.xxx.rb" target='_blank'>http://agilecreativity.com/public/demo1.xxx.rb</li>
      <li><a href="http://agilecreativity.com/public/demo2.xxx.java" target='_blank'>http://agilecreativity.com/public/demo2.xxx.java</li>
      <li><a href="http://agilecreativity.com/public/demo2.xxx.rb" target='_blank'>http://agilecreativity.com/public/demo2.xxx.rb</li>
      <li><a href="http://agilecreativity.com/public/sub-dir/demo3.yyy.java" target='_blank'>http://agilecreativity.com/public/sub-dir/demo3.yyy.java</li>
      <li><a href="http://agilecreativity.com/public/sub-dir/demo3.yyy.rb" target='_blank'>http://agilecreativity.com/public/sub-dir/demo3.yyy.rb</li>
      <li><a href="http://agilecreativity.com/public/sub-dir/demo4.yyy.java" target='_blank'>http://agilecreativity.com/public/sub-dir/demo4.yyy.java</li>
      <li><a href="http://agilecreativity.com/public/sub-dir/demo4.yyy.rb" target='_blank'>http://agilecreativity.com/public/sub-dir/demo4.yyy.rb</li>
    </ol>
  </body>
</html>
        EOT
    end
  end

  context "#make_links" do
    it "works with prefix" do
      actual = IndexHtml.make_links(files, base_dir: "spec/fixtures", prefix: "public")
      expected = <<-EOT
<li><a href="public/demo1.xxx.rb" target='_blank'>public/demo1.xxx.rb</li>
<li><a href="public/demo2.xxx.rb" target='_blank'>public/demo2.xxx.rb</li>
      EOT
      expect(actual).to eq(expected.split("\n"))
    end

    it "works without prefix" do
      actual = IndexHtml.make_links(files, base_dir: "spec/fixtures")
      expected = <<-EOT
<li><a href="./demo1.xxx.rb" target='_blank'>./demo1.xxx.rb</li>
<li><a href="./demo2.xxx.rb" target='_blank'>./demo2.xxx.rb</li>
      EOT
      expect(actual).to eq(expected.split("\n"))
    end

    it "works with base_dir starting with dot" do
      files = CodeLister.files base_dir: "./spec/fixtures",
                               exts: %w[xxx.rb], recursive: true
      actual = IndexHtml.make_links(files, base_dir: "./spec/fixtures/")
      expected = <<-EOT
<li><a href="./demo1.xxx.rb" target='_blank'>./demo1.xxx.rb</li>
<li><a href="./demo2.xxx.rb" target='_blank'>./demo2.xxx.rb</li>
      EOT
      expect(actual).to eq(expected.split("\n"))
    end

    it "works with base_dir not starting with dot" do
      files = CodeLister.files base_dir: "spec/fixtures",
                               exts: %w[xxx.rb], recursive: true
      actual = IndexHtml.make_links(files, base_dir: "spec/fixtures/")
      expected = <<-EOT
<li><a href="./demo1.xxx.rb" target='_blank'>./demo1.xxx.rb</li>
<li><a href="./demo2.xxx.rb" target='_blank'>./demo2.xxx.rb</li>
      EOT
      expect(actual).to eq(expected.split("\n"))
    end
  end

  context "#drop_extension" do
    it 'returns original input for file with no extension' do
      expect(IndexHtml.drop_extension("/path/to/file")).to eq              "/path/to/file"
      expect(IndexHtml.drop_extension("some_file")).to eq                  "some_file"
      expect(IndexHtml.drop_extension("/path/to/some_file")).to eq         "/path/to/some_file"
    end
    it 'returns new string with last extension dropped ' do
      expect(IndexHtml.drop_extension("some_file.txt")).to eq              "some_file"
      expect(IndexHtml.drop_extension("/path/to/some_file.txt")).to eq     "/path/to/some_file"
      expect(IndexHtml.drop_extension("/path/to/some_file.txt.pdf")).to eq "/path/to/some_file.txt"
    end
  end
end
