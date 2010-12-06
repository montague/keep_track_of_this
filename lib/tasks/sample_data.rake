require 'faker'

namespace :db do
  desc "Add sample data to the db"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    guid = UUID.new
    User.create!( :email => "ian.asaff@gmail.com",
                  :uuid => guid.generate,
                  :password => "foobar",
                  :password_confirmation => "foobar")
    99.times do |n|
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!( :email => email,
                    :uuid => guid.generate,
                    :password => password,
                    :password_confirmation => password)
    end
  end
end