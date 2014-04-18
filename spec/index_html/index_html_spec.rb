require 'fileutils'
require_relative '../spec_helper'

describe IndexHtml do

  let(:files) {
    CodeLister.files base_dir: 'spec/fixtures',
                     exts: %w(xxx.rb), recursive: true
  }

  context '#basenames!' do
    it 'excludes full path of the files' do
      expect(IndexHtml.basenames!(files, basename: true)).to eq ["demo1.xxx.rb",
                                                                 "demo2.xxx.rb"]
    end

    it 'includes full path of the files' do
      expect(IndexHtml.basenames!(files)).to eq ["spec/fixtures/demo1.xxx.rb",
                                                 "spec/fixtures/demo2.xxx.rb"]
      expect(IndexHtml.basenames!(files, basename: false)).to eq ["spec/fixtures/demo1.xxx.rb",
                                                                  "spec/fixtures/demo2.xxx.rb"]
    end
  end

  context '#escape_uris!' do
    it 'works correctly with full path' do
      expect(IndexHtml.escape_uris!(files, encoded: true)).to eq ["spec%2Ffixtures%2Fdemo1.xxx.rb",
                                                                  "spec%2Ffixtures%2Fdemo2.xxx.rb"]
    end
  end

  context '#htmlify' do
    let :files do
      CodeLister.files base_dir: 'spec/fixtures',
                       exts: %w(rb java),
                       recursive: true
    end

    it 'generates simple index file' do
      FileUtils.rm_rf('index.html')
      IndexHtml.htmlify files,
                        indent: 6,
                        output: 'index.html',
                        base_dir: 'spec/fixtures'
      expect(capture(:stdout) { system('cat index.html') }).to eq \
        <<-EOT
<html>
<title>File Listing</title>
<header>File List</header>
  <body>
    <ol>
      <li><a href="./spec/fixtures/demo1.xxx.java" target="_blank">./spec/fixtures/demo1.xxx.java</li>
      <li><a href="./spec/fixtures/demo1.xxx.rb" target="_blank">./spec/fixtures/demo1.xxx.rb</li>
      <li><a href="./spec/fixtures/demo2.xxx.java" target="_blank">./spec/fixtures/demo2.xxx.java</li>
      <li><a href="./spec/fixtures/demo2.xxx.rb" target="_blank">./spec/fixtures/demo2.xxx.rb</li>
      <li><a href="./spec/fixtures/sub-dir/demo3.yyy.java" target="_blank">./spec/fixtures/sub-dir/demo3.yyy.java</li>
      <li><a href="./spec/fixtures/sub-dir/demo3.yyy.rb" target="_blank">./spec/fixtures/sub-dir/demo3.yyy.rb</li>
      <li><a href="./spec/fixtures/sub-dir/demo4.yyy.java" target="_blank">./spec/fixtures/sub-dir/demo4.yyy.java</li>
      <li><a href="./spec/fixtures/sub-dir/demo4.yyy.rb" target="_blank">./spec/fixtures/sub-dir/demo4.yyy.rb</li>
    </ol>
  </body>
</html>
      EOT
    end

    it 'generates simple index file with prefix' do
      FileUtils.rm_rf('index.html')
      IndexHtml.htmlify files,
                        indent: 6,
                        output: 'index.html',
                        prefix: 'http://agilecreativity.com/public',
                        base_dir: 'spec/fixtures' # Note: must not puts the '/' at the end!
      expect(capture(:stdout) { system('cat index.html') }).to eq \
        <<-EOT
<html>
<title>File Listing</title>
<header>File List</header>
  <body>
    <ol>
      <li><a href="http://agilecreativity.com/public/spec/fixtures/demo1.xxx.java" target="_blank">http://agilecreativity.com/public/spec/fixtures/demo1.xxx.java</li>
      <li><a href="http://agilecreativity.com/public/spec/fixtures/demo1.xxx.rb" target="_blank">http://agilecreativity.com/public/spec/fixtures/demo1.xxx.rb</li>
      <li><a href="http://agilecreativity.com/public/spec/fixtures/demo2.xxx.java" target="_blank">http://agilecreativity.com/public/spec/fixtures/demo2.xxx.java</li>
      <li><a href="http://agilecreativity.com/public/spec/fixtures/demo2.xxx.rb" target="_blank">http://agilecreativity.com/public/spec/fixtures/demo2.xxx.rb</li>
      <li><a href="http://agilecreativity.com/public/spec/fixtures/sub-dir/demo3.yyy.java" target="_blank">http://agilecreativity.com/public/spec/fixtures/sub-dir/demo3.yyy.java</li>
      <li><a href="http://agilecreativity.com/public/spec/fixtures/sub-dir/demo3.yyy.rb" target="_blank">http://agilecreativity.com/public/spec/fixtures/sub-dir/demo3.yyy.rb</li>
      <li><a href="http://agilecreativity.com/public/spec/fixtures/sub-dir/demo4.yyy.java" target="_blank">http://agilecreativity.com/public/spec/fixtures/sub-dir/demo4.yyy.java</li>
      <li><a href="http://agilecreativity.com/public/spec/fixtures/sub-dir/demo4.yyy.rb" target="_blank">http://agilecreativity.com/public/spec/fixtures/sub-dir/demo4.yyy.rb</li>
    </ol>
  </body>
</html>
        EOT
    end
  end

  context '#make_links' do
    it 'works with prefix' do
      result = IndexHtml.make_links files, base_dir: "spec/fixtures", prefix: 'public'
      expect(capture(:stdout) { puts result }).to eq \
        <<-EOT
<li><a href="public/spec/fixtures/demo1.xxx.rb" target="_blank">public/spec/fixtures/demo1.xxx.rb</li>
<li><a href="public/spec/fixtures/demo2.xxx.rb" target="_blank">public/spec/fixtures/demo2.xxx.rb</li>
      EOT
    end

    it 'works without prefix' do
      result = IndexHtml.make_links(files, base_dir: "spec/fixtures")
      expect(capture(:stdout) { puts result }).to eq \
        <<-EOT
<li><a href="./spec/fixtures/demo1.xxx.rb" target="_blank">./spec/fixtures/demo1.xxx.rb</li>
<li><a href="./spec/fixtures/demo2.xxx.rb" target="_blank">./spec/fixtures/demo2.xxx.rb</li>
      EOT
    end

    it 'works with base_dir starting with dot' do
      files = CodeLister.files base_dir: './spec/fixtures',
                               exts: %w(xxx.rb), recursive: true
      result = IndexHtml.make_links(files, base_dir: "./spec/fixtures/")
      expect(capture(:stdout) { puts result }).to eq \
        <<-EOT
<li><a href="./spec/fixtures/demo1.xxx.rb" target="_blank">./spec/fixtures/demo1.xxx.rb</li>
<li><a href="./spec/fixtures/demo2.xxx.rb" target="_blank">./spec/fixtures/demo2.xxx.rb</li>
      EOT
    end

    it 'works with base_dir not starting with dot' do
      files = CodeLister.files base_dir: 'spec/fixtures',
                               exts: %w(xxx.rb), recursive: true
      result = IndexHtml.make_links(files, base_dir: "spec/fixtures/")
      expect(capture(:stdout) { puts result }).to eq \
        <<-EOT
<li><a href="./spec/fixtures/demo1.xxx.rb" target="_blank">./spec/fixtures/demo1.xxx.rb</li>
<li><a href="./spec/fixtures/demo2.xxx.rb" target="_blank">./spec/fixtures/demo2.xxx.rb</li>
      EOT
    end

  end
end
