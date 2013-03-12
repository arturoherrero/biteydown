require 'spec_helper'

describe Biteydown do

  it 'create html file from a markdown file' do
    markdown_file = 'example/curriculum.md'
    Biteydown.process(markdown_file, true, false)
    File.exists?(File.new('example/curriculum.html')).should be_true
  end

  it 'create pdf file from a markdown file' do
    markdown_file = 'example/curriculum.md'
    Biteydown.process(markdown_file, false, true)
    File.exists?(File.new('example/curriculum.pdf')).should be_true
  end

  it 'create html and pdf file from a markdown file' do
    markdown_file = 'example/curriculum.md'
    Biteydown.process(markdown_file, true, true)
    File.exists?(File.new('example/curriculum.html')).should be_true
    File.exists?(File.new('example/curriculum.pdf')).should be_true
  end

  after(:all) do
    File.delete('example/curriculum.html')
    File.delete('example/curriculum.pdf')
  end
end
