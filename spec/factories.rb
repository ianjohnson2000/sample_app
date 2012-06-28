FactoryGirl.define do
  factory :user do
    name "Ian Johnson"
    email "ianjohnson2000@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end