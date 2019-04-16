# encoding: utf-8

require 'csv'

#CSV.foreach("#{RAILS_ROOT}/db/seeds/user.csv", :encoding => "utf-8") do |row|
 # User.create! :name => row[0], :email => row[1], :password => row[2], :password_confirmation => row[3]
#end

#user = User.where(:email => 'kamenew@apk-invest.com').first
#user.roles = ["admin"]
#user.save!

#user = User.where(:email => 'allorsi@rambler.ru').first
#user.roles = ["contractor"]
#user.save!

user = User.where(:email => 'galahov@mail.ru').first
user.roles = ["contractor", "chief_contractor"]
user.save!

user = User.where(:email => 'dorenrsi@mail.ru').first
user.roles = ["contractor"]
user.save!


user = User.where(:email => 'serdobincev@apk-invest.com').first
user.roles = ["controller", "chief_controller"]
user.save!


user = User.where(:email => 'romanenko@apk-invest.com').first
user.roles = ["controller"]
user.save!

user = User.where(:email => 'nasonov@apk-invest.com').first
user.roles = ["controller"]
user.save!



#CSV.foreach("#{RAILS_ROOT}/db/seeds/project.csv", :encoding => "utf-8") do |row|
#  Project.create! :code => row[0], :name => row[1], :description => row[2]
#end

#CSV.foreach("#{RAILS_ROOT}/db/seeds/category.csv", :encoding => "utf-8") do |row|
#  Category.create! :code => row[0], :name => row[1], :description => row[2]
#end

#CSV.foreach("#{RAILS_ROOT}/db/seeds/specification.csv", :encoding => "utf-8") do |row|
#  Specification.create! :entity => row[0],  :unit => row[1], :quantity => row[2], :price_without_vat => row[3],
#   :price_with_vat => row[4], :coast_of_delivery => row[5], :amount_with_vat => row[6], 
#   :category => Category.find(row[7]), :supplier => row[8], :project => Project.find(row[9]), :notice => row[10], :recommended_conditions => row[11], :recommended_supplier => row[12],
#   :recommended_notice => row[13], :contractor => User.find(row[14]), :controller => User.find(row[15]), :open_on => Date.parse(row[16]), 
#   :close_on => Date.parse(row[17]), :search_time => row[18], :wait_time => row[19], :check_time => row[20], :state => 'studying'  
#end
