require 'spec_helper'

describe ApplicationHelper do
  
  describe "full_title" do
    
    it "should include the page title" do
      full_title('Foo').should =~ /Foo/
    end
    
    it "should include the base title" do
      full_title('Foo').should =~ /^Ruby on Rails Sample App/
    end
    
    it "should not include a bar on the home page" do
      full_title('').should_not =~ /\|/
    end
    
  end
  
end