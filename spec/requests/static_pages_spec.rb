require 'spec_helper'

describe "Static Pages" do
  
  let(:title) { "Ruby on Rails Sample App" }
  subject { page }

  describe "Home Page" do 
    
    before { visit root_path }
    it { should have_selector('h1', text: 'Sample App') }
    it { should have_selector('title', text: "#{title}") }
    it { should_not have_selector('title', text: "#{title} | Home") }
    
  end

  describe "Help Page" do 
    
    before { visit help_path }
    it { should have_selector('h1', text: 'Help') }
    it { should have_selector('title', text: "#{title} | Help") }
    
  end
  
  describe "About Page" do 
    
    before { visit about_path }
    it { should have_selector('h1', text: 'About Us') }
    it { should have_selector('title', text: "#{title} | About Us") }
    
  end

  describe "Contact Page" do 
    
    before { visit contact_path }
    it { should have_selector('h1', text: 'Contact') }
    it { should have_selector('title', text: "#{title} | Contact") }
    
    it "should have the right links on the layout" do
      
      visit root_path
      click_link "sample app"
      page.should have_selector('h1', text: 'Sample App')
      
    end
    
  end

end
