require 'faker'

namespace :db do
  desc "Add sample data to the db"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    guid = UUID.new
    admin = User.create!( :email => "ian.asaff@gmail.com",
                  :uuid => guid.generate,
                  :password => "foobar",
                  :password_confirmation => "foobar")
    admin.toggle!(:admin)
    
    99.times do |n|
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!( :email => email,
                    :uuid => guid.generate,
                    :password => password,
                    :password_confirmation => password)
    end
    
    User.all(:limit => 6).each do |user|
      10.times do
        user.items.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end