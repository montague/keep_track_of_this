Factory.define :user do |user|
  user.email                 "ian.asaff@gmail.com"
  user.uuid                   UUID.new.generate
  user.password              "foobar"
  user.password_confirmation "foobar"
end