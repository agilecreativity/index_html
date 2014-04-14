require_relative '../spec_helper'

describe IndexHtml do

  let(:files) {
    CodeLister.files(base_dir: 'spec/fixtures', exts: %w(xxx.rb), recursive: true)
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
    it 'works liks it shoulds' do
      IndexHtml.htmlify files,
                          indent: 6,
                          output: "index.html"
                          #prefix: "http://agilecreativity.com/public/"
    end
  end

end
