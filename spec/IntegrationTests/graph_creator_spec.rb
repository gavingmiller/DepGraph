require File.dirname(__FILE__) + "/../spec_helper"
require 'graph_creator'
require 'rubygems'
gem 'filetesthelper'
require 'spec'
require 'filetesthelper'
include DepGraph
include FileTestHelper
  
test_data = {
  :csproj => {'file1.csproj'=>'"file2.csproj"', 'dir/file2.csproj'=>'"file1.csproj"' },
  :ruby_requires => {'file1.rb'=>'require "file2"', 'dir/file2.rb'=>'require "file1"' }
}

describe GraphCreator, '(integration tests)' do
  dependency_types.each do |filter_type|
    it "should create a png image from the #{filter_type} dependencies found in the current directory tree" do
      with_files(test_data[filter_type]) do
        GraphCreator.new(filter_type).create_image('test.png')
      
        non_empty_file_created('test.png').should be_true
      end
    end
  end
end  






