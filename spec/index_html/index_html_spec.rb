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

  #TODO: add proper test here
  context '#htmlify' do
    let :files do
      CodeLister.files base_dir: 'spec/fixtures',
                       exts: %w(rb java),
                       recursive: true
    end

    it 'generates simple index file' do
      IndexHtml.htmlify files,
                        indent: 6,
                        output: 'index.html'
      expect(capture(:stdout) { system('cat index.html') }).to eq \
        <<-EOT
<html>
<title>File Listing</title>
<header>File List</header>
  <body>
    <ol>
      <li><a href="spec/fixtures/demo1.xxx.java" target="_blank">spec/fixtures/demo1.xxx.java</li>
      <li><a href="spec/fixtures/demo1.xxx.rb" target="_blank">spec/fixtures/demo1.xxx.rb</li>
      <li><a href="spec/fixtures/demo2.xxx.java" target="_blank">spec/fixtures/demo2.xxx.java</li>
      <li><a href="spec/fixtures/demo2.xxx.rb" target="_blank">spec/fixtures/demo2.xxx.rb</li>
      <li><a href="spec/fixtures/sub-dir/demo3.yyy.java" target="_blank">spec/fixtures/sub-dir/demo3.yyy.java</li>
      <li><a href="spec/fixtures/sub-dir/demo3.yyy.rb" target="_blank">spec/fixtures/sub-dir/demo3.yyy.rb</li>
      <li><a href="spec/fixtures/sub-dir/demo4.yyy.java" target="_blank">spec/fixtures/sub-dir/demo4.yyy.java</li>
      <li><a href="spec/fixtures/sub-dir/demo4.yyy.rb" target="_blank">spec/fixtures/sub-dir/demo4.yyy.rb</li>
    </ol>
  </body>
</html>
      EOT
    end

    it 'generates simple index file with prefix' do
      IndexHtml.htmlify files,
                        indent: 6,
                        output: 'index.html',
                        prefix: 'http://agilecreativity.com/'
      expect(capture(:stdout) { system('cat index.html') }).to eq \
        <<-EOT
<html>
<title>File Listing</title>
<header>File List</header>
  <body>
    <ol>
      <li><a href="http://agilecreativity.com/spec/fixtures/demo1.xxx.java" target="_blank">spec/fixtures/demo1.xxx.java</li>
      <li><a href="http://agilecreativity.com/spec/fixtures/demo1.xxx.rb" target="_blank">spec/fixtures/demo1.xxx.rb</li>
      <li><a href="http://agilecreativity.com/spec/fixtures/demo2.xxx.java" target="_blank">spec/fixtures/demo2.xxx.java</li>
      <li><a href="http://agilecreativity.com/spec/fixtures/demo2.xxx.rb" target="_blank">spec/fixtures/demo2.xxx.rb</li>
      <li><a href="http://agilecreativity.com/spec/fixtures/sub-dir/demo3.yyy.java" target="_blank">spec/fixtures/sub-dir/demo3.yyy.java</li>
      <li><a href="http://agilecreativity.com/spec/fixtures/sub-dir/demo3.yyy.rb" target="_blank">spec/fixtures/sub-dir/demo3.yyy.rb</li>
      <li><a href="http://agilecreativity.com/spec/fixtures/sub-dir/demo4.yyy.java" target="_blank">spec/fixtures/sub-dir/demo4.yyy.java</li>
      <li><a href="http://agilecreativity.com/spec/fixtures/sub-dir/demo4.yyy.rb" target="_blank">spec/fixtures/sub-dir/demo4.yyy.rb</li>
    </ol>
  </body>
</html>
        EOT
    end
  end
end
