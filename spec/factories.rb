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

#defines an item that has an association to a user
Factory.define :item do |item|
  item.content "dexter is a good television show"
  item.subject "dexter"
  item.association :user
end

#defines a tag that has an association to a user
Factory.define :tag do |tag|
  tag.content "things i like"
  tag.association :item
end