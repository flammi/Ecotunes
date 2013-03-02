FactoryGirl.define do
  factory :user do 
    name "Testuser"
    email "fabian@fabian.de"
    password "testtest"
    approved true

    after(:create) {|user| user.remove_role(:admin)}
    
    factory :admin do
      after(:create) {|user| user.add_role(:admin) }
    end

  end
end
