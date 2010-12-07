Factory.define :user do |user|
  user.email                 "ian.asaff@gmail.com"
  user.uuid                   UUID.new.generate
  user.password              "foobar"
  user.password_confirmation "foobar"
end

#define a sequence for generating emails to test pagination
Factory.sequence :email do |n| 
  "person-#{n}@example.com" 
end