begin
  namespace :db do
    desc "Populate the development database with some fake data"
    task :populate => :environment do
      5.times do
        Account.create! :owner => 'Kia', :balance => 100
      end
    end
  end
rescue LoadError
  puts "Please run: sudo gem install forgery"
end
