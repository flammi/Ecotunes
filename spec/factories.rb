FactoryGirl.define do
  factory :user do 
    name "Testuser"
    email "fabian@fabian.de"
    password "testtest"
    approved true
  end
end
