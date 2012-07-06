require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "when not signed in" do
    before { visit root_path }
    it { should_not have_link('Sign Out',     href: signout_path) }
    it { should_not have_link('Users',        href: users_path) }
    it { should have_link('Sign In',          href: signin_path) }
  end

  describe "sign in page" do
    before { visit signin_path }
    
    it { should have_selector('h1',     text: 'Sign In') }
    it { should have_selector('title',  text: full_title('Sign In')) }
    
  end
  
  describe "sign in" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "Sign In" }
      
      it { should have_selector('title',                  text: full_title('Sign In')) }
      it { should have_selector('div.alert.alert-error',  text: 'Invalid') }
      
      describe "after visiting another page" do

        before{ click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }

      end
      
    end
      
    describe "with valid information" do

      let(:user) { FactoryGirl.create(:user) }

      before { sign_in(user) }
      
      it { should have_selector('title',    text: user.name) }
      it { should have_link('Profile',      href: user_path(user)) }
      it { should have_link('Sign Out',     href: signout_path) }
      it { should have_link('Settings',     href: edit_user_path(user)) }
      it { should have_link('Users',        href: users_path) }
      it { should_not have_link('Sign In',  href: signin_path) }
      
      describe "followed by sign out" do
        before { click_link "Sign Out" }
        it { should have_link("Sign In") }
      end

    end
      
  end
  
  describe "authorisation" do
    
    describe "for users not signed in" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign In"
        end
        
        describe "after sign in" do
          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit User')
          end
          
          describe "when signing in again" do
            before do
              click_link "Sign Out"
              click_link "Sign In"
              fill_in "Email",    with: user.email
              fill_in "Password", with: user.password
              click_button "Sign In"
            end
            
            it "should render the profile page and not edit page" do
              page.should have_selector('title', text: user.name)
            end
            
          end
          
        end
        
      end
      
      describe "in the users controller" do
        
        describe "when visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }
          it { should have_selector('div.alert.alert-notice') }
        end
        
        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
        
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_selector('title', text: 'Sign In') }
        end
        
      end
      
      describe "in Microposts controller" do
        describe "submitting to the create action" do
          before { post microposts_path }
          specify { response.should redirect_to(signin_path) }
        end
        
        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { response.should redirect_to(signin_path)  }
        end
        
      end
      
      describe "as wrong user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
        before { sign_in user }
        
        describe "visiting users edit page" do
          before { visit edit_user_path(wrong_user) }
          it { should_not have_selector('title', text: 'Edit User') }
        end
        
        describe "submitting a PUT request to the users update action" do
          before { put user_path(wrong_user) }
          specify { response.should redirect_to(root_path) }
        end

      end
      
    end
    
    describe "none admin users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      
      before { sign_in non_admin }
      
      describe "submitting a DELETE request to the Users#destroy method" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }
      end
    end
    
  end

end
