require 'spec_helper'

describe "Static Pages" do
  
  let(:title) { "Ruby on Rails Sample App" }

  describe "Home Page" do 
    
    it "should have the content 'Sample App'" do
      
      visit root_path
      page.should have_selector('h1', text: 'Sample App')
      
    end
    
    it "it should have the base title" do
      
      visit root_path
      page.should have_selector('title', 
                                text: "#{title}")
                                
    end
    
    it "it should not have a custom title" do
      
      visit root_path
      page.should_not have_selector('title', 
                                text: "#{title} | Home")
                                
    end
    
  end

  describe "Help Page" do 
    
    it "should have the content 'Help'" do
      
      visit help_path
      page.should have_selector('h1', text: 'Help')
      
    end
    
    it "should have the right title" do
      
      visit help_path
      page.should have_selector('title', 
                                text: "#{title} | Help")
                                
    end
  end
  
  describe "About Page" do 
    
    it "should have the content 'About Us'" do
      
      visit about_path
      page.should have_selector('h1', text: 'About Us')
      
    end
    
    it "should have the right title" do
      
      visit about_path
      page.should have_selector('title', 
                                text: "#{title} | About Us")
                                
    end
  end

  describe "Contact Page" do 
    
    it "should have the content 'Contact'" do
      
      visit contact_path
      page.should have_selector('h1', text: 'Contact')
      
    end
    
    it "should have the right title" do
      
      visit contact_path
      page.should have_selector('title', 
                                text: "#{title} | Contact")
                                
    end
    
    it "should have the right links on the layout" do
      
      visit root_path
      click_link "sample app"
      page.should have_selector('h1', text: 'Sample App')
      
    end
    
  end

end
